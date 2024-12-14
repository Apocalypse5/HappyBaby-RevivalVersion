(function (cjs, an) {

var p; // shortcut to reference prototypes
var Items_Furniture={};var ss={};var img={};
window.Items_Furniture = Items_Furniture;
Items_Furniture.ssMetadata = [];


(Items_Furniture.AnMovieClip = function(){
	this.actionFrames = [];
	this.ignorePause = false;
	this.gotoAndPlay = function(positionOrLabel){
		cjs.MovieClip.prototype.gotoAndPlay.call(this,positionOrLabel);
	}
	this.play = function(){
		cjs.MovieClip.prototype.play.call(this);
	}
	this.gotoAndStop = function(positionOrLabel){
		cjs.MovieClip.prototype.gotoAndStop.call(this,positionOrLabel);
	}
	this.stop = function(){
		cjs.MovieClip.prototype.stop.call(this);
	}
}).prototype = p = new cjs.MovieClip();
// symbols:
// helper functions:

function mc_symbol_clone() {
	var clone = this._cloneProps(new this.constructor(this.mode, this.startPosition, this.loop, this.reversed));
	clone.gotoAndStop(this.currentFrame);
	clone.paused = this.paused;
	clone.framerate = this.framerate;
	return clone;
}

function getMCSymbolPrototype(symbol, nominalBounds, frameBounds) {
	var prototype = cjs.extend(symbol, cjs.MovieClip);
	prototype.clone = mc_symbol_clone;
	prototype.nominalBounds = nominalBounds;
	prototype.frameBounds = frameBounds;
	return prototype;
	}


(Items_Furniture.Wall = function(mode,startPosition,loop,reversed) {
if (loop == null) { loop = true; }
if (reversed == null) { reversed = false; }
	var props = new Object();
	props.mode = mode;
	props.startPosition = startPosition;
	props.labels = {};
	props.loop = loop;
	props.reversed = reversed;
	cjs.MovieClip.apply(this,[props]);

	// 图层_1
	this.shape = new cjs.Shape();
	this.shape.graphics.f("#FF0000").s().p("A3WAZIAAgxMAutAAAIAAAxg");
	this.shape.setTransform(149.5,2.5);

	this.timeline.addTween(cjs.Tween.get(this.shape).wait(1));

	this._renderFirstFrame();

}).prototype = getMCSymbolPrototype(Items_Furniture.Wall, new cjs.Rectangle(0,0,299,5), null);


(Items_Furniture.HbObject_BlueShelf = function(mode,startPosition,loop,reversed) {
if (loop == null) { loop = true; }
if (reversed == null) { reversed = false; }
	var props = new Object();
	props.mode = mode;
	props.startPosition = startPosition;
	props.labels = {};
	props.loop = loop;
	props.reversed = reversed;
	cjs.MovieClip.apply(this,[props]);

	// 图层_1
	this.wall = new Items_Furniture.Wall();
	this.wall.name = "wall";
	this.wall.setTransform(149.35,1,1,0.15,0,0,0,149.5,2.6);
	this.wall.alpha = 0;

	this.shape = new cjs.Shape();
	this.shape.graphics.f("#13689F").s().p("APCAzIBchZMgg8AAAIBcBZIAABBIisi0IhfAAIAQAPIj8hDMAtzAAAIj9BDIAQgPIhfAAIisC0g");
	this.shape.setTransform(149.625,23.65);

	this.shape_1 = new cjs.Shape();
	this.shape_1.graphics.f("#163C61").s().p("APCBcIAAgCICsi1IBgAAIgQAPIi2CogAwHBcIi2ioIgQgPIBgAAICsC1IAAACg");
	this.shape_1.setTransform(149.575,26.325);

	this.shape_2 = new cjs.Shape();
	this.shape_2.graphics.f("#23C6ED").s().p("A25A8QgeAAAAggIAAg4QAAgfAeAAMAtzAAAQAeAAAAAfIAAA4QAAAggeAAg");
	this.shape_2.setTransform(149.625,6);

	this.timeline.addTween(cjs.Tween.get({}).to({state:[{t:this.shape_2},{t:this.shape_1},{t:this.shape},{t:this.wall}]}).wait(1));

	this._renderFirstFrame();

}).prototype = getMCSymbolPrototype(Items_Furniture.HbObject_BlueShelf, new cjs.Rectangle(-0.1,0,299.40000000000003,35.5), null);

})(createjs = createjs||{}, AdobeAn = AdobeAn||{});
var createjs, AdobeAn;