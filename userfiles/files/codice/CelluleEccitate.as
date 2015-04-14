package{
	import mb.hype.behavior.MB_gravity;
	import mb.utils.MbMath;
	import hype.framework.core.TimeType;
	import hype.framework.rhythm.SimpleRhythm;
	import hype.framework.behavior.AbstractBehavior;
	import hype.framework.sound.SoundAnalyzer;

	import flash.display.*;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	
	public class CelluleEccitate extends Sprite {
		//array che contiene le cellule
		private var clips:Array = new Array();
		//colori
		private var colors:Array = new Array();
		
		private var soundAnalyzer:SoundAnalyzer = new SoundAnalyzer();
		private var mySound:Sound;
		private var myChannel:SoundChannel;
		private var brano:String = "Shine on your crazy Diamonds.mp3";
		private var backgroundColor:uint = 0x222222;
		
		public function CelluleEccitate () {
			// aggiungo gradienti di colore all'array
			MbMath.createGradient(0xFF0000, 0xFFFF00 , 64, colors);
			MbMath.createGradient(0xFFFF00, 0xFFFFFF , 64, colors);
			MbMath.createGradient(0xFFFFFF, 0xff8800 , 64, colors);
			MbMath.createGradient(0xff8800, 0xFF0000 , 64, colors);
			var lf:LoaderInfo = loaderInfo;
			if (lf.parameters["brano"] != null ) {
				brano = lf.parameters["brano"];
			}
			if (lf.parameters["backgroundColor"] != null ) {
				backgroundColor = lf.parameters["backgroundColor"];
			}
			lf.addEventListener(Event.UNLOAD, chiudiTutto);
			
			addEventListener(Event.ADDED_TO_STAGE, initDisplay);
			soundAnalyzer.start();
		}
		
		private function initDisplay (evt:Event) {
			var bk:Shape = new Shape();
			var g:Graphics = bk.graphics;
			g.beginFill(backgroundColor);
			g.drawRect(0,0,stage.stageWidth, stage.stageHeight);
			addChild(bk);
			
			for (var i = 0; i < 256; i++) {
				var s:Shape = new Shape();
				//var c:uint = Math.round(Math.random()*0xffffff);
				var c:uint = colors[i];
				g = s.graphics;
				g.lineStyle(1,c,0.2);
				g.beginFill(c, 0.5);
				g.drawCircle(0,0,10);
				
				s.filters = [new BlurFilter(10,10)];
				
				addChild(s);
				clips.push(s);
			
				var grav:MB_gravity = new MB_gravity(s, -s.height, 0, (6 * Math.random()), 
													 true, true, MB_gravity.ACCELERATION, 2);
				grav.start();
			}			
			
			var rhythm:SimpleRhythm = new SimpleRhythm(track);
			rhythm.start();
			eseguiBrano();
		}
		
		private function track(myRhythm:SimpleRhythm) {
			var freq:Number;
		
			for (var i:uint = 0; i < 256; ++i) {
				freq = soundAnalyzer.getFrequencyIndex(i, 0, 2.5);
				var c:DisplayObject = clips[i] as DisplayObject;
				c.alpha = 0.2 + freq/2.5;
				c.scaleX = c.scaleY = 0.4 + (freq * freq);
			}
		}
		
		private function eseguiBrano() {

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
		private function chiudiTutto (evt:Event) {
			//AbstractBehavior.manager.removeAllRhythms();
			myChannel.stop();
			if (mySound.bytesLoaded < mySound.bytesTotal) {
				mySound.close();
			}
		}
	}
}