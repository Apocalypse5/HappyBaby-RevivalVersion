package {
    import flash.display.Sprite;
    import flash.display.SimpleButton;
    import flash.events.MouseEvent; // 引入事件处理相关类

    public class ShowText {
        public var Male_text:Sprite;
        public var Female_text:Sprite;
        public var Color_text:Sprite;
        public var Clothes_text:Sprite;
        public var Random_text:Sprite;
        public var Yes_text:Sprite;
        public var Close_text:Sprite;
        public var maleButton:SimpleButton;
        public var maleButton_g:SimpleButton;
        public var femaleButton:SimpleButton;
        public var femaleButton_g:SimpleButton;
        public var Close:SimpleButton;
        public var Yes:SimpleButton;
        public var Randoms:SimpleButton;
        public var Clothes:SimpleButton;
        public var Color_black:SimpleButton;
        public var Colors:Sprite;

        public function ShowText(
            Male_text:Sprite, 
            Female_text:Sprite, 
            Color_text:Sprite, 
            Clothes_text:Sprite, 
            Random_text:Sprite, 
            Yes_text:Sprite, 
            Close_text:Sprite,
            maleButton:SimpleButton,
            maleButton_g:SimpleButton,
            femaleButton:SimpleButton,
            femaleButton_g:SimpleButton,
            Close:SimpleButton,
            Yes:SimpleButton,
            Randoms:SimpleButton,
            Clothes:SimpleButton,
            Color_black:SimpleButton,
            Colors:Sprite
        ) {
            this.Male_text = Male_text;
            this.Female_text = Female_text;
            this.Color_text = Color_text;
            this.Clothes_text = Clothes_text;
            this.Random_text = Random_text;
            this.Yes_text = Yes_text;
            this.Close_text = Close_text;
            this.maleButton = maleButton;
            this.maleButton_g = maleButton_g;
            this.femaleButton = femaleButton;
            this.femaleButton_g = femaleButton_g;
            this.Close = Close;
            this.Yes = Yes;
            this.Randoms = Randoms;
            this.Clothes = Clothes;
            this.Color_black = Color_black;
            this.Colors = Colors;

            Male_text.visible = false;
            Female_text.visible = false;
            Color_text.visible = false;
            Clothes_text.visible = false;
            Random_text.visible = false;
            Yes_text.visible = false;
            Close_text.visible = false;

            this.maleButton.addEventListener(MouseEvent.MOUSE_OVER, onMouseOvermaleButton);
            this.maleButton.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutmaleButton);
            this.maleButton_g.addEventListener(MouseEvent.MOUSE_OVER, onMouseOvermaleButton);
            this.maleButton_g.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutmaleButton);
            this.femaleButton.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverfemaleButton);
            this.femaleButton.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutfemaleButton);
            this.femaleButton_g.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverfemaleButton);
            this.femaleButton_g.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutfemaleButton);
            this.Close.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverClose);
            this.Close.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutClose);
            this.Yes.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverYes);
            this.Yes.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutYes);
            this.Randoms.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverRandoms);
            this.Randoms.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutRandoms);
            this.Clothes.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverClothes);
            this.Clothes.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutClothes);
            this.Color_black.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutColor);
            this.Color_black.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverColor);
            this.Colors.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutColor);
            this.Colors.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverColor);
        }

        public function onMouseOverClose(event:MouseEvent):void {
            this.Close_text.visible = true;
        }

        public function onMouseOutClose(event:MouseEvent):void {
            this.Close_text.visible = false;
        }

        public function onMouseOverYes(event:MouseEvent):void {
            this.Yes_text.visible = true;
        }

        public function onMouseOutYes(event:MouseEvent):void {
            this.Yes_text.visible = false;
        }

        public function onMouseOverRandoms(event:MouseEvent):void {
            this.Random_text.visible = true;
        }

        public function onMouseOutRandoms(event:MouseEvent):void {
            this.Random_text.visible = false;
        }

        public function onMouseOverClothes(event:MouseEvent):void {
            this.Clothes_text.visible = true;
        }

        public function onMouseOutClothes(event:MouseEvent):void {
            this.Clothes_text.visible = false;
        }

        public function onMouseOvermaleButton(event:MouseEvent):void {
            this.Male_text.visible = true;
        }

        public function onMouseOutmaleButton(event:MouseEvent):void {
            this.Male_text.visible = false;
        }

        public function onMouseOverfemaleButton(event:MouseEvent):void {
            this.Female_text.visible = true;
        }

        public function onMouseOutfemaleButton(event:MouseEvent):void {
            this.Female_text.visible = false;
        }

        public function onMouseOverColor(event:MouseEvent):void {
            this.Color_text.visible = true;
        }

        public function onMouseOutColor(event:MouseEvent):void {
            this.Color_text.visible = false;
        }
    }
}
