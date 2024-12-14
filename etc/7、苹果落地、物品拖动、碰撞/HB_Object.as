package {
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.media.Sound;
    import flash.media.SoundChannel;
    import flash.net.URLRequest;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import Wall;
    import flash.display.DisplayObject;
    import flash.geom.Point;


    public class HB_Object extends MovieClip {
        public var gravity:Number = 0.98;  // 模拟重力加速度
        public var velocityY:Number = 0;   // 垂直方向初速度
        public var velocityX:Number = 0;   // 水平方向初速度
        public var yStart:Number = 100;    // 苹果的起始y坐标
        public var bottomBound:Number = 320;   // 下边界
        public var leftBound:Number = 0;  // 左边界
        public var rightBound:Number = 1560; // 右边界 (舞台宽度是1560)
        public var topBound:Number = 0; // 上边界
        public var bounceFactor:Number = 0.15;  // 反弹系数
        public var friction:Number = 0.3;     // 水平摩擦力系数 (0-1)

        public var soundPlayed:Boolean = false; // 是否播放过音效
        public var fallSound:Sound = new Sound(new URLRequest("Fall.mp3")); // 创建一个Sound对象用于加载音效
        public var soundChannel:SoundChannel;

        public var isDragging:Boolean = false; // 是否正在拖动

        public var lastX:Number = 0;  // 上一帧的x位置
        public var lastY:Number = 0;  // 上一帧的y位置

        public var timer:Timer; // 定时器，用于记录位置

        public var originalIndex:int; // 记录当前对象的原始层级

        public function HB_Object() {
            this.y = yStart;  // 设置初始位置

            this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
            this.addEventListener(Event.ENTER_FRAME, fall);  // 每一帧更新物体下落
        }

        // 鼠标按下事件，开始拖动
        public function onMouseDown(event:MouseEvent):void {

            // 记录当前层级
            if (parent) {
                originalIndex = parent.getChildIndex(this); // 保存当前的层级索引
                parent.setChildIndex(this, parent.numChildren - 1); // 移动到最顶层
            }

            isDragging = true; // 开始拖动
            this.startDrag();  // 开始拖动
            this.removeEventListener(Event.ENTER_FRAME, fall); // 停止物理下落
            this.velocityY = 0;  // 物体在点击时初速度归零
            this.velocityX = 0;  // 水平速度归零
            this.soundPlayed = false; // 重置音效播放标志，确保音效重新播放
            this.addEventListener(MouseEvent.MOUSE_UP, onMouseUp); // 监听鼠标松开事件

            // 初始化定时器，每 100 毫秒记录一次位置
            timer = new Timer(100, 5); // 0.5 秒内采样 5 次
            timer.addEventListener(TimerEvent.TIMER, recordPosition);
            timer.start();
        }

        // 定时器回调函数，记录当前位置
        public function recordPosition(event:TimerEvent):void {
            lastX = this.x;
            lastY = this.y;
        }

        // 鼠标松开事件，恢复下落效果
        public function onMouseUp(event:MouseEvent):void {
            isDragging = false; // 停止拖动
            this.stopDrag();  // 停止拖动

            // 恢复到原来的层级
            if (parent) {
                parent.setChildIndex(this, originalIndex);
            }

            this.addEventListener(Event.ENTER_FRAME, fall); // 恢复物理下落
            this.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp); // 不再监听鼠标松开事件

            // 停止定时器
            if (timer) {
                timer.stop();
                timer.removeEventListener(TimerEvent.TIMER, recordPosition);
            }

            // 计算鼠标松开时的初始速度(X越大越往右，Y越大越往下)
            velocityX = (this.x - lastX) / 5;  // 水平速度
            velocityY = (this.y - lastY) / 5;  // 垂直速度
            //trace("Release velocity:", velocityX, velocityY);
        }

        // 每一帧更新，模拟物理下落和水平方向运动
        public function fall(event:Event):void {
            if (!isDragging) {  // 只有在不拖动时才模拟物理效果
                velocityY += gravity;  // 增加垂直下落的速度
                this.y += velocityY;    // 更新垂直位置
                this.x += velocityX;      

                checkCollisions();
            }
        }

        public function checkCollisions():void {

            if (Math.abs(velocityY) < 1) {  // 以 0.1 作为判断的阈值
                soundPlayed = false;  // 物体停止运动时，重置音效标志
            }

            // 检查与上下边界的碰撞
            if (this.y <= topBound) {  // 上边界
                this.y = topBound;
                velocityY *= -bounceFactor;  // 反弹
            } else if (this.y >= bottomBound) {  // 下边界
                this.y = bottomBound;
                velocityY *= -bounceFactor;  // 反弹
                velocityX *= friction; // 水平速度逐渐减小
                if (!soundPlayed && Math.abs(velocityY) > 1) {
                    soundChannel = fallSound.play();
                    soundPlayed = true;
                }
            }

            // 检查与左右边界的碰撞
            if (this.x <= leftBound) {  // 左边界
                this.x = leftBound;
                velocityX *= -bounceFactor;  // 反弹
            } else if (this.x + this.width >= rightBound) {  // 右边界
                this.x = rightBound - this.width;
                velocityX *= -bounceFactor;  // 反弹
            }

            //与Wall类对象的关系
            for (var i:int = 0; i < parent.numChildren; i++) {
                var obj:MovieClip = parent.getChildAt(i) as MovieClip; //obj是舞台上的所有对象
                if (obj) {  // 确保 obj 是 MovieClip
                    // 遍历 obj 的所有子对象
                    for (var j:int = 0; j < obj.numChildren; j++) {
                        var child:MovieClip = obj.getChildAt(j) as MovieClip; //child是舞台上的每个对象内的所有Wall对象
                        if (child is Wall) {
                            var childGlobalPosition:Point = child.localToGlobal(new Point(0, 0)); //必须把child(Wall对象)的坐标转换成全局坐标，否则无法正确获取child.y的值
                            if (
                                this.x + this.width > childGlobalPosition.x &&
                                this.x < childGlobalPosition.x + child.width && 
                                this.y + this.height > childGlobalPosition.y &&
                                this.y < childGlobalPosition.y + child.height &&
                                (this.y + this.height - childGlobalPosition.y) <= 18 //当物体的底部距离child的顶部过远地时候(物体在child下面)就不要再发生碰撞了
                               ) {
                                
                                this.y = childGlobalPosition.y - this.height;

                                velocityY *= -bounceFactor;  // 垂直反弹
                                velocityX *= friction;  // 水平速度减小

                                if (!soundPlayed && Math.abs(velocityY) > 1) {
                                    soundChannel = fallSound.play();
                                    soundPlayed = true;
                                }
                                break;  // 防止重复检测
                            }
                        }
                    }
                }
            }





        }






    }
}

//舞台的宽度并不是已知的，需要考虑地下室
//鼠标指针的改变
//层级问题需要考虑，例如地毯不应该盖住凳子、柜子不应该盖住柜子里的玩具