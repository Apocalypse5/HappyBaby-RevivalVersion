package {
    import flash.display.MovieClip;
    import flash.geom.ColorTransform;

    public class ChangeColors {

        public static function changeColor(...args):void {
            if (args.length != 13) {
                trace("错误：需要13个参数，11个目标对象和2个颜色！");
                return;
            }

            var color1:uint = args[args.length - 2];
            var color2:uint = args[args.length - 1];

            for (var i:int = 0; i < 8; i++) {
                var target1:MovieClip = args[i] as MovieClip;
                if (target1) {
                    applyColor(target1, color1);
                } else {
                    trace("目标对象不存在或未找到：", args[i]);
                }
            }

            for (i = 8; i < 11; i++) {
                var target2:MovieClip = args[i] as MovieClip;
                if (target2) {
                    applyColor(target2, color2);
                } else {
                    trace("目标对象不存在或未找到：", args[i]);
                }
            }
        }

        private static function applyColor(target:MovieClip, color:uint):void {
            var colorTransform:ColorTransform = target.transform.colorTransform;
            colorTransform.color = color;
            target.transform.colorTransform = colorTransform;
        }
    }
}
