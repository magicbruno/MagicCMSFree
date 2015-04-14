package 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.utils.getTimer;
	import hype.extended.rhythm.FilterCanvasRhythm;
	import hype.framework.core.TimeType;
	import hype.framework.display.BitmapCanvas;
	import hype.framework.rhythm.AbstractRhythm;
	import hype.framework.rhythm.SimpleRhythm;
	import hype.framework.trigger.SimpleTrigger;
	import mb.behavior.Swarm;
	import mb.puroAS3.MB_polystar;
	import mb.puroAS3.MB_shapeColorSchema;
	
	/**
	 * ...
	 * @author Bruno Milgiaretti
	 */
	public class Main extends Sprite 
	{
		private const LATI:uint = 3;
		private var colorSchema:MB_shapeColorSchema = new MB_shapeColorSchema(0, 0x888888,0.5, 0xff0000, 0.5, MB_shapeColorSchema.STAR);
		private var colorSchema1:MB_shapeColorSchema = new MB_shapeColorSchema(0, 0x888888, 0.5, 0xFFDD00, 0.5, MB_shapeColorSchema.STAR);
		private var myStar:MB_polystar = new MB_polystar(30,LATI,colorSchema);
		private var myStar1:MB_polystar = new MB_polystar(30,LATI,colorSchema1);
		private var contenitore:Sprite = new Sprite();
		private var swarm:Swarm;
		private var swarm1:Swarm;
		private var maxGrow:Number = 0.1;
		private var minGrow:Number = 0.1;
		private var growStep:int = 1;
		private var growTime:Number = 500;
		
		private var startTime:Number = getTimer();
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			
			this.loaderInfo.addEventListener(Event.UNLOAD, chiudiTutto);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			this.graphics.beginFill(0x333333);
			this.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			addChild(contenitore);
			contenitore.addChild(myStar1);
			contenitore.addChild(myStar);
			myStar.x = stage.stageWidth / 2;
			myStar.y = stage.stageHeight / 2;
			myStar1.x = stage.stageWidth / 2 + 4;
			myStar1.y = stage.stageHeight / 2 + 4;
			
			swarm = new Swarm(myStar, new Point(190, 190), 15, 0.2, 0.2);
			swarm.start();
			swarm1 = new Swarm(myStar1, new Point(194, 194), 15, 0.2, 0.2);
			swarm1.start();
			var ritmo:SimpleRhythm = new SimpleRhythm(update);
			ritmo.start();
			
			
			
			var bmc:BitmapCanvas = new BitmapCanvas(stage.stageWidth, stage.stageHeight, true);
			bmc.startCapture(contenitore, true, TimeType.ENTER_FRAME, 1);
			addChild(bmc);
			var matrix:Array = [1, 0, 0, 0, 0,
								0, 1, 0, 0, 0,
								0, 0, 1, 0, 0,
								0, 0, 0, 0.9888, 0];
			var alphaFilter:FilterCanvasRhythm = new FilterCanvasRhythm([new ColorMatrixFilter(matrix)], bmc);
			alphaFilter.start(TimeType.ENTER_FRAME, 10);
		}
		
		private function update (r:SimpleRhythm):void {
			if (Point.distance(swarm.point, new Point(myStar.x, myStar.y)) < 50) {
				var myX:Number = stage.stageWidth * Math.random();
				var myY:Number = stage.stageHeight * Math.random();
				swarm.point = new Point(myX, myY);
				swarm1.point = new Point(myX + 4, myY + 4);
				if (Math.random() > 0.4) {
					startGrow();
				}
			}
			if (maxGrow <= minGrow) {
				maxGrow = minGrow;
				myStar.scaleX = myStar1.scaleX = myStar.scaleY = myStar1.scaleY = maxGrow;
				startTime = getTimer();
				growStep = 1;
			} else {
				//trace(growStep);
				var t:Number = getTimer() - startTime;
				var scale:Number;
				if (t > growTime) t = growTime;
				if (growStep == 1) {
					scale = minGrow + (maxGrow - minGrow) * (t / growTime);
				} else {
					scale = minGrow + (maxGrow - minGrow) * ( 1- (t / growTime));
				}
				myStar.scaleX = myStar1.scaleX = myStar.scaleY = myStar1.scaleY = scale;
				if (scale >= maxGrow) {
					growStep = -1;
					startTime = getTimer();
				} else if (scale <= minGrow) {
					maxGrow = minGrow;
				}
			}
		}
		
		private function startGrow():void {
			maxGrow = minGrow + Math.random() * 6 * stage.stageWidth/800;
		}
		
		/*
		NOTA IMPORTANTE
		Questo evento è necessario solo se si carica l'animazione in maniera dinamica dentro un'altro filmato
		con la classe Loader o la relativa componente.
		Il metodo  AbstractRhythm.manager.removeAllRhythms() al momento NON esiste nel Hype Framework
		rilasciato (1.1.8), è stato aggiunto da me per evitare  che flash si blocchi quando si un filmato hype 
		viene scaricato (unload) per caricare un'altro filmato come avviene nella home page di 
		sisteminterattivi.org.
		Eliminare i segni di commento dal comando solo se si è sicuri di utilizzare una versione di hype che 
		comprenda questo comando.
		Si consiglia di leggere l'articolo relativo al problema su sistemiinterattivi.org.
		*/
		private function chiudiTutto (evt:Event):void {
			AbstractRhythm.manager.removeAllRhythms();
		}
		
	}
	
}