package {
    import flash.events.MouseEvent;
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.text.TextField;

    public class Song extends MovieClip {
        private static var allSongs:Array = []; // 用来存储所有的 Song 实例
        private var isListAtFrame3:Boolean = false; // 用来跟踪 List 是否已经在第 3 帧

        public function Song() {
            // 将当前 Song 实例添加到 allSongs 数组中
            allSongs.push(this);

            // 添加鼠标事件监听
            this.Up.addEventListener(MouseEvent.MOUSE_OVER, onSongHover);
            this.Up.addEventListener(MouseEvent.MOUSE_OUT, onSongOut);
            this.Up.addEventListener(MouseEvent.CLICK, onUpClick);
            this.List.addEventListener(MouseEvent.MOUSE_OVER, onSongHover);
            this.List.addEventListener(MouseEvent.MOUSE_OUT, onSongOut);
            this.List.addEventListener(MouseEvent.CLICK, onSongClick);
        }

        private function onSongHover(event:MouseEvent):void {
            // 让 List 元件跳到帧 2
            this.List.gotoAndStop(2);
        }

        private function onSongOut(event:MouseEvent):void {
            // 让 List 元件返回帧 1（或其他帧）
            if (!isListAtFrame3) {  // 如果当前没有停留在第 3 帧，则返回第 1 帧
                this.List.gotoAndStop(1);
            } else {
                this.List.gotoAndStop(3);
            }
        }

        private function onSongClick(event:MouseEvent):void {
            // 当点击某个 Song 实例时，先将其他所有 Song 的 List 跳回第 1 帧
            for (var i:int = 0; i < allSongs.length; i++) {
                if (allSongs[i] != this) {
                    allSongs[i].List.gotoAndStop(1);
                    allSongs[i].Listen.gotoAndStop(1);
                    allSongs[i].isListAtFrame3 = false;
                }
                else {
                    trace(i+1);
                }
            }

            // 如果 List 当前不在第 3 帧，则跳到第 3 帧
            if (!isListAtFrame3) {
                this.List.gotoAndStop(3);
                this.Listen.gotoAndStop(2); // 假设 Listen 是另一个元件
                isListAtFrame3 = true; // 标记为已经在第 3 帧
            } else {
                this.List.gotoAndStop(3);
            }
        }

        private function onUpClick(event:MouseEvent):void {

            var currentIndex:int = allSongs.indexOf(this);
            //trace(currentIndex);
            // 如果当前 Song 已经是第一个元素，就不进行交换
            if (currentIndex > 0) {
                // 获取当前 Song 上方的 Song 对象
                var aboveSong:Song = allSongs[currentIndex - 1]; //aboveSong是虫儿飞对象
                var newY:int = this.y;

                allSongs[currentIndex] = aboveSong; //allSongs[currentIndex]是虫儿飞对象
                allSongs[currentIndex - 1] = this; //this是天空之城对象，allSongs[currentIndex - 1]是天空之城对象

                // 更新显示顺序或其他位置属性，确保两个对象的显示位置交换
                allSongs[currentIndex - 1].y = aboveSong.y;  // 更新上一个 Song 的 y 坐标
                allSongs[currentIndex].y = newY;  // 更新 y 坐标

                if (!isListAtFrame3) {  // 如果当前没有停留在第 3 帧，则返回第 1 帧
                    this.List.gotoAndStop(1);
                } else {
                    this.List.gotoAndStop(3);
                }
            }
        }
    }
}
