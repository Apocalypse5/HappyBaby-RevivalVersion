package {
    import flash.display.SimpleButton;
    import flash.events.MouseEvent;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    
    public class Item extends SimpleButton {
        private const MAX_SCALE:Number = 1.5; // 最大缩放比例 (150%)
        private const MIN_SCALE:Number = 1.0; // 最小缩放比例 (100%)
        private const ANIMATION_SPEED:Number = 0.15; // 缓动速度
        private const MIN_DISTANCE:Number = 5; // 按钮之间的最小距离
        private const PUSH_SPEED:Number = 0.1; // 按钮推开速度（缓动）

        private var activeTimer:Timer; // 存储定时器
        private var moveTimer:Timer; // 存储按钮推开时的定时器
        private var initialPositions:Object; // 存储每个按钮的初始位置

        public function Item() {
            super();
            this.scaleX = MIN_SCALE;  // 初始化按钮的缩放比例
            this.scaleY = MIN_SCALE;

            this.initialPositions = {}; // 初始化存储初始位置
            this.initialPositions[this] = { x: this.x, y: this.y };

            this.addEventListener(MouseEvent.ROLL_OVER, onItemRollOver); // 监听鼠标事件
            this.addEventListener(MouseEvent.ROLL_OUT, onItemRollOut);
        }

        private function onItemRollOver(event:MouseEvent):void { // 鼠标进入按钮时
            startAnimation(MAX_SCALE); // 开始放大动画
        }

        private function onItemRollOut(event:MouseEvent):void {  // 鼠标离开按钮时
            startAnimation(MIN_SCALE); // 开始缩小动画
        }

        private function startAnimation(targetScale:Number):void { // 动画控制
            if (activeTimer != null) {  // 如果已有定时器在运行，先停止
                activeTimer.stop();
            }
            
            activeTimer = new Timer(30); // 创建定时器，用于逐步调整缩放，每30毫秒更新一次缩放比例

            activeTimer.addEventListener(TimerEvent.TIMER, function(event:TimerEvent):void {
                var currentScale:Number = scaleX; // 当前缩放比例
                var scaleDiff:Number = targetScale - currentScale; // 当前比例与目标比例的差值
                var step:Number = scaleDiff * ANIMATION_SPEED;  // 使用缓动公式调整比例（非匀速变化）

                if (Math.abs(scaleDiff) < 0.01) {  // 如果接近目标比例，停止动画
                    scaleX = targetScale;
                    scaleY = targetScale;
                    activeTimer.stop(); // 停止定时器
                    adjustPositions(); // 调整按钮位置
                    return;
                }

                scaleX += step;  // 逐步调整缩放比例
                scaleY += step;
            });

            activeTimer.start(); // 启动定时器
        }

        private function adjustPositions():void {
            // 获取父容器中的所有按钮
            var buttons:Array = [];
            for (var i:int = 0; i < parent.numChildren; i++) {
                var button:Item = parent.getChildAt(i) as Item;
                if (button != this) {
                    buttons.push(button);
                }
            }

            // 计算总宽度，包括按钮的间隔
            var totalWidth:Number = 0;
            for (var j:int = 0; j < buttons.length; j++) {
                totalWidth += buttons[j].width * buttons[j].scaleX + MIN_DISTANCE;  // 累加按钮宽度和间隔
            }
            totalWidth += this.width * this.scaleX; // 当前按钮的宽度也加上去

            // 计算每个按钮的 X 坐标，使它们居中
            var startX:Number = (parent.stage.stageWidth - totalWidth) / 2;

            // 设置每个按钮的位置，保持最小间距
            var currentX:Number = startX;
            for (var k:int = 0; k < buttons.length; k++) {
                var otherButton:Item = buttons[k];
                otherButton.x = currentX; // 更新按钮的位置
                currentX += otherButton.width * otherButton.scaleX + MIN_DISTANCE;  // 更新 X 坐标，添加按钮宽度和间距
            }

            // 更新当前按钮的位置
            this.x = currentX;

            // 调整按钮之间的碰撞，检查是否需要推开
            checkCollisionAndPush(buttons);
        }

        private function checkCollisionAndPush(buttons:Array):void {
            for (var i:int = 0; i < buttons.length; i++) {
                var otherButton:Item = buttons[i];
                // 检查两个按钮之间的距离
                var distance:Number = this.x - otherButton.x - otherButton.width * otherButton.scaleX;

                // 如果两个按钮之间的距离小于最小距离，则需要推动另一个按钮
                if (distance < MIN_DISTANCE) {
                    var pushDistance:Number = MIN_DISTANCE - distance; // 计算推开的距离

                    if (moveTimer != null) {
                        moveTimer.stop(); // 如果正在移动，则停止先前的移动
                    }

                    // 使用缓动的方式推动另一个按钮
                    moveTimer = new Timer(30);
                    moveTimer.addEventListener(TimerEvent.TIMER, function(event:TimerEvent):void {
                        var currentX:Number = otherButton.x; // 当前按钮的位置
                        var step:Number = pushDistance * PUSH_SPEED; // 每次推动的距离
                        otherButton.x += step; // 更新按钮位置

                        // 如果距离接近推开的目标，则停止动画
                        if (Math.abs(currentX - otherButton.x) >= pushDistance) {
                            moveTimer.stop();
                        }
                    });

                    moveTimer.start(); // 启动移动定时器
                }
            }
        }
    }
}
