package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import hype.extended.rhythm.FilterCanvasRhythm;
	import hype.framework.core.TimeType;
	import hype.framework.display.BitmapCanvas;
	import hype.framework.rhythm.SimpleRhythm;
	import hype.framework.sound.SoundAnalyzer;
	import mb.utils.MbMath;
	
	/**
	 * ...
	 * @author Bruno Milgiaretti
	 */
	public class Main extends Sprite 
	{
		private var schermo:Sprite = new Sprite();
		private var analyzer:SoundAnalyzer = new SoundAnalyzer();
		private var colors:Array = new Array();
		private var raggio:Number;
		private var points:Vector.<Point> = new Vector.<Point>(256, true);
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			//MbMath.createGradient(0x880000, 0xff0000, 64, colors);
			MbMath.createGradient(0xFF0000, 0xFFFF00, 128, colors);
			MbMath.createGradient(0xFFFF00, 0xFFFFEE, 64, colors);
			MbMath.createGradient(0x888888, 0xEEEEEE, 64, colors);	
			
			raggio = 3 * (stage.stageWidth / 500);
			
			for (var i:uint = 0; i < 256; i++) {
				points[i] = new Point(stage.stageWidth * Math.random(), stage.stageHeight * Math.random());
			}
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			// entry point
			this.graphics.beginFill(0x222222);
			this.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			//schermo.filters = [new BlurFilter(4, 4)];
			addChild(schermo);
			analyzer.start();
			var ritmo:SimpleRhythm = new SimpleRhythm(update);
			var suono:Sound = new Sound();
			suono.load(new URLRequest("Fortuna.mp3"));
			suono.play();
			ritmo.start();
			var bmc:BitmapCanvas = new BitmapCanvas(stage.stageWidth, stage.stageHeight);
			var bmc1:BitmapCanvas = new BitmapCanvas(stage.stageWidth, stage.stageHeight);
			bmc.startCapture(schermo, true);
			bmc1.startCapture(schermo, true);
			addChild(bmc);
			addChild(bmc1);
			var blur:FilterCanvasRhythm = new FilterCanvasRhythm([new BlurFilter(10, 10)], bmc);
			var alphaFilter:FilterCanvasRhythm = new FilterCanvasRhythm([new BlurFilter(30,30)], bmc1);
			alphaFilter.start(TimeType.ENTER_FRAME,1);
			blur.start(TimeType.TIME,30);
		}
		
		private function update (r:SimpleRhythm):void {
			schermo.graphics.clear();
			//schermo.graphics.beginFill(0xffffee, 0.3);
			var freq:Number;
			for (var i:uint = 0; i < 256; i++) {
				freq = analyzer.getFrequencyIndex(i, 0.2, 1);
				schermo.graphics.beginFill(colors[i], freq);
				schermo.graphics.drawCircle(stage.stageWidth * Math.random(), stage.stageHeight * Math.random(), raggio * (freq * 3)*(freq * 3));
				//schermo.graphics.drawCircle(points[i].x, points[i].y, raggio * (freq * 2.5)*(freq * 2.5));
			}
		}
		
	}
	
}