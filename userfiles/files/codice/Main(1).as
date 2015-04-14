package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	import flash.utils.getTimer;
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
		private const ACCELERAZIONE:Number = 10;
		private const RAGGIO:Number = 3;
		private const NUM:int = 1023;
		private var polarPoints:Vector.<Point> = new Vector.<Point>(NUM, true);
		private var variazioneColore:Vector.<uint> = new Vector.<uint>(NUM, true);
		private var intervalli:Vector.<Number> = new Vector.<Number>(NUM, true);
		private var acc:Vector.<Number> = new Vector.<Number>(NUM, true);
		private var schermo:Sprite = new Sprite();
		private var analyzer:SoundAnalyzer = new SoundAnalyzer();
		private var maxLength:Number;
		private var mySound:Sound;
		private var myChannel:SoundChannel;
		private var brano:String = "Orphee.mp3";
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			var colors:Array = new Array();
			MbMath.createGradient(0xFF0000, 0xFFFF00, 128, colors);
			MbMath.createGradient(0xFFFF00, 0xFFFFEE, 64, colors);
			MbMath.createGradient(0x888888, 0xEEEEEE, 64, colors);	
			
			maxLength = Point.distance(new Point(0, 0), new Point(stage.stageWidth / 2, stage.stageHeight / 2));

			//posizione iniziale di punti
			for (var i:uint = 0; i < polarPoints.length; i++) {
				polarPoints[i] = new Point(maxLength * Math.random(), 2 * Math.PI * Math.random());
			}
			
			for (i = 0; i < variazioneColore.length; i++) {
				if (i < 768){
					variazioneColore[i] = 0x222222;
				} else {
					variazioneColore[i] = colors[i-768];
				}
			}
			
			for (i = 0; i < acc.length; i++) {
				acc[i] = ACCELERAZIONE * Math.random() + 2;
			}
			
			var t:Number = getTimer();
			for (i = 0; i < intervalli.length; i++) {
				intervalli[i] = t + Math.sqrt(2 * polarPoints[i].y/ acc[i]);
			}
			
			schermo.filters = [new BlurFilter(12, 12)];
			schermo.x = stage.stageWidth / 2;
			schermo.y = stage.stageHeight / 2;
			var contenitore:Sprite = new Sprite();
			contenitore.addChild(schermo);
			addChild(contenitore);
			var bmc:BitmapCanvas = new BitmapCanvas(stage.stageWidth, stage.stageHeight, true);
			bmc.startCapture(contenitore, true);
			addChild(bmc);
			var blur:FilterCanvasRhythm = new FilterCanvasRhythm([new BlurFilter(20, 20)], bmc);
			blur.start(TimeType.ENTER_FRAME,1);
			
			analyzer.start();
			
			eseguiBrano();
			var ritmo:SimpleRhythm = new SimpleRhythm(update);
			ritmo.start(TimeType.ENTER_FRAME,1);
		}
		
		private function aggiornaPosizione():void {
			var pX:Number;
			var t:Number;
			for (var i:uint = 0; i < polarPoints.length; i++) {
				t = getTimer() - intervalli[i];
				pX = polarPoints[i].x + Math.pow(t/1000, 2) * (acc[i]/2);
				if (pX > maxLength) {
					pX = 50 * Math.random();
					intervalli[i] = getTimer();
				}
				polarPoints[i].x = pX;
				//polarPoints[i].y = polarPoints[i].y + Math.PI / 18;
			}
		}
		
		private function update (r:SimpleRhythm):void {
			var freq:Number;
			var myPoint:Point;
			schermo.graphics.clear();
			for (var i:uint = 0; i < polarPoints.length; i++) {
				myPoint = Point.polar(polarPoints[i].x, polarPoints[i].y);
				if (i < 768) {
					schermo.graphics.beginFill(variazioneColore[i], 0.5);
					schermo.graphics.drawCircle(myPoint.x, myPoint.y, RAGGIO * 1);
				} else {
					freq = analyzer.getFrequencyIndex(i - 768, 0.2, 1);
					schermo.graphics.beginFill(variazioneColore[i], freq);
					schermo.graphics.drawCircle(myPoint.x, myPoint.y, RAGGIO * (freq * 5) * (freq * 5));
				}
			}
			aggiornaPosizione();
		}
		
		private function eseguiBrano():void {
			mySound = new Sound(new URLRequest(brano));
			myChannel = mySound.play();
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
			//AbstractBehavior.manager.removeAllRhythms();
			myChannel.stop();
			if (mySound.bytesLoaded < mySound.bytesTotal) {
				mySound.close();
			}
		}
		
		
	}
	
}