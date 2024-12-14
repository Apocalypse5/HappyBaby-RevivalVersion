package {
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.media.Sound;
    import flash.media.SoundChannel;
    import flash.net.URLRequest;

    public class Pendant extends HB_Object {
        public function Shelves() {
            this.y = yStart;  // 设置初始位置

            this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
            this.addEventListener(Event.ENTER_FRAME, fall);  // 每一帧更新物体下落
        }

        override public function fall(event:Event):void {
            if (!isDragging) {  // 只有在不拖动时才模拟物理效果
                velocityY += 0;  // 增加垂直下落的速度
                this.y += 0;    // 更新垂直位置
                this.x += 0;      

                checkCollisions();
            }
        }

        override public function checkCollisions():void {

            if (Math.abs(velocityY) < 1 ) {  // 以 0.1 作为判断的阈值
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
        }













    }
}