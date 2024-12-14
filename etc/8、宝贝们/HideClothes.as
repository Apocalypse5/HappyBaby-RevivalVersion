package {
    import flash.display.MovieClip;

    public class HideClothes {

        public static function hideClothes(...clips):void {
            // 遍历所有传入的影片剪辑对象
            for (var i:int = 0; i < clips.length; i++) {
                var clip:MovieClip = clips[i] as MovieClip;
                if (clip) {
                    clip.visible = false;  // 隐藏影片剪辑
                } else {
                    trace("无效的影片剪辑对象：", clips[i]);
                }
            }
        }

        public static function showClothes(...clips):void {
            // 遍历所有传入的影片剪辑对象
            for (var i:int = 0; i < clips.length; i++) {
                var clip:MovieClip = clips[i] as MovieClip;
                if (clip) {
                    clip.visible = true;  // 隐藏影片剪辑
                } else {
                    trace("无效的影片剪辑对象：", clips[i]);
                }
            }
        }
    }
}
