package {
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.display.Loader;
    import flash.events.Event;
    import flash.geom.Matrix;
    import flash.net.URLRequest;

    public class ChangeClothes {
        public static function loadAndReplace(url:String, targetToReplace:DisplayObject):void {
            var loader:Loader = new Loader();
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(event:Event):void {
                onSwfLoaded(event, targetToReplace);
            });
            loader.load(new URLRequest(url));
        }

        private static function onSwfLoaded(event:Event, targetToReplace:DisplayObject):void {
            var newContent:DisplayObject = event.target.content as DisplayObject;
            if (!newContent) {
                trace("Failed to load SWF: Content is not a valid DisplayObject.");
                return;
            }

            if (targetToReplace && targetToReplace.parent) {
                var parent:DisplayObjectContainer = targetToReplace.parent;
                var index:int = parent.getChildIndex(targetToReplace);

                var originalMatrix:Matrix = targetToReplace.transform.matrix.clone();

                parent.removeChild(targetToReplace);
                parent.addChildAt(newContent, index);

                // 恢复原始矩阵，以免造成错误的翻转
                newContent.transform.matrix = originalMatrix;

                //trace("Replacement successful: SWF loaded and replaced target.");
                //trace("Matrix restored:", originalMatrix);
            } else {
                trace("Replacement failed: Target must have a valid parent.");
            }
        }
    }
}
