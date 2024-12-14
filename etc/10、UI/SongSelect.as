package {
    import flash.display.MovieClip;
    import flash.events.MouseEvent;

    public class SongSelect extends MovieClip {
        private var song1:MovieClip;
        private var isListAtFrame3:Boolean = false; // 用来跟踪 List 是否已经在第 3 帧

        public function SongSelect(song1:MovieClip) {
            // 将传递进来的 Song_1 实例赋值给 song1
            this.song1 = song1;

            // 添加鼠标事件监听
            song1.Up.addEventListener(MouseEvent.MOUSE_OVER, onUpHover);
            song1.Up.addEventListener(MouseEvent.CLICK, onUpClick);
            song1.List.addEventListener(MouseEvent.MOUSE_OVER, onUpHover);
            song1.List.addEventListener(MouseEvent.MOUSE_OUT, onUpOut);
            song1.List.addEventListener(MouseEvent.CLICK, onSongClick);
            song1.List.addEventListener(MouseEvent.MOUSE_UP, onSongRelease);
        }

        private function onUpHover(event:MouseEvent):void {
            // 让 List 元件跳到帧 2
            song1.List.gotoAndStop(2);
        }

        private function onUpOut(event:MouseEvent):void {
            // 让 List 元件返回帧 1（或其他帧）
            if (!isListAtFrame3) {  // 如果当前没有停留在第 3 帧，则返回第 1 帧
                song1.List.gotoAndStop(1);
            }
            else {
                song1.List.gotoAndStop(3);
            }
        }

        private function onSongClick(event:MouseEvent):void {
            // 如果 List 当前不在第 3 帧，则跳到第 3 帧
            if (!isListAtFrame3) {
                song1.List.gotoAndStop(3);
                song1.Listen.gotoAndStop(2);
                isListAtFrame3 = true; // 标记为已经在第 3 帧
            } else {
                song1.List.gotoAndStop(3);
            }
        }

        private function onSongRelease(event:MouseEvent):void {
            // 松开鼠标时，如果 List 在第 3 帧，则保持在第 3 帧
            if (isListAtFrame3) {
                song1.List.gotoAndStop(3);
            }
        }

        private function onUpClick(event:MouseEvent):void {
            trace("Up!");
        }
    }
}
