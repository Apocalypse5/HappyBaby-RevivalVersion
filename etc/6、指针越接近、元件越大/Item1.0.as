package {
    import flash.display.SimpleButton;
    import flash.events.MouseEvent;
    import flash.utils.Timer;
    import flash.events.TimerEvent;

    public class Item extends SimpleButton {
        private const MAX_SCALE:Number = 1.5; // 最大缩放比例 (150%)
        private const MIN_SCALE:Number = 1.0; // 最小缩放比例 (100%)
        private const ANIMATION_SPEED:Number = 0.15; // 缓动速度

        private var activeTimer:Timer; // 存储定时器

        public function Item() {
            super();
            this.scaleX = MIN_SCALE;  // 初始化按钮的缩放比例
            this.scaleY = MIN_SCALE;

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
                    return;
                }

                scaleX += step;  // 逐步调整缩放比例
                scaleY += step;
            });

            activeTimer.start();// 启动定时器
        }
    }
}