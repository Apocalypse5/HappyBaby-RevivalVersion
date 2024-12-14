package {
    import flash.display.SimpleButton;
    import flash.display.Sprite;
    import flash.events.MouseEvent;

    public class GenderSelector extends Sprite {
        private var btnMaleColor:SimpleButton;
        private var btnFemaleColor:SimpleButton;
        private var btnMaleGray:SimpleButton;
        private var btnFemaleGray:SimpleButton;

        public function GenderSelector(
            maleColor:SimpleButton, 
            maleGray:SimpleButton, 
            femaleColor:SimpleButton, 
            femaleGray:SimpleButton
        ) {
            btnMaleColor = maleColor;
            btnMaleGray = maleGray;
            btnFemaleColor = femaleColor;
            btnFemaleGray = femaleGray;

            //addChild(btnMaleColor);
            //addChild(btnFemaleColor);
            //addChild(btnMaleGray);
            //addChild(btnFemaleGray);

            btnMaleGray.visible = false;
            btnFemaleGray.visible = false;

            btnMaleColor.addEventListener(MouseEvent.CLICK, onMaleClick);
            btnFemaleColor.addEventListener(MouseEvent.CLICK, onFemaleClick);
            btnMaleGray.addEventListener(MouseEvent.CLICK, onMaleClick);
            btnFemaleGray.addEventListener(MouseEvent.CLICK, onFemaleClick);
        }

        private function onMaleClick(event:MouseEvent):void {
            btnMaleGray.visible = false;
            btnMaleColor.visible = true;
            btnFemaleGray.visible = true;
            btnFemaleColor.visible = false;
        }

        private function onFemaleClick(event:MouseEvent):void {
            btnFemaleGray.visible = false;
            btnFemaleColor.visible = true;
            btnMaleGray.visible = true;
            btnMaleColor.visible = false;
        }
    }
}