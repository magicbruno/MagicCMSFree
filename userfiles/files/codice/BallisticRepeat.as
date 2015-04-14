package {
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Point;
	import flash.utils.Timer;
	import flash.filters.*;
	import mb.behavior.*;
	import hype.framework.display.*;
	import mb.hype.color.*;
	import hype.framework.rhythm.SimpleRhythm;
	import hype.framework.rhythm.AbstractRhythm;
	import hype.framework.core.*;
	import hype.framework.trigger.*;
	import hype.extended.trigger.ExitShapeTrigger;
	import hype.extended.rhythm.*;
	import mb.puroAS3.MB_sedile;

	public class BallisticRepeat extends Sprite {
		//private var my_clip:Sprite;
		private var swarmArray:Array = new Array();
		private var colorist:ColorGradient;
		private var sfondo:Sprite;
		private var mycanvas:BitmapCanvas;
		private var myFilterRhythm:FilterCanvasRhythm;
		
		public function BallisticRepeat () {
			
			var lf:LoaderInfo = loaderInfo;
			lf.addEventListener(Event.UNLOAD, chiudiTutto);
	        addEventListener(Event.ADDED_TO_STAGE, initSchermo);
			
			colorist = new ColorGradient(0xffee00, 0xdd0000, 10, 0x666666, 0xeeeeee, 10);
			
/*			var mycanvas2= new BitmapCanvas(stage.stageWidth, stage.stageHeight);
			mycanvas2.startCapture(sfondo, false);
			addChild(mycanvas2);
*/		}

		private function initSchermo (evt:Event) {

			mycanvas= new BitmapCanvas(stage.stageWidth, stage.stageHeight, true,0xFFFFFF);
			addChild(mycanvas);
			sfondo = new Sprite();
			addChild(sfondo);
			
			mycanvas.startCapture(sfondo, true);
			
			myFilterRhythm = new FilterCanvasRhythm([new BlurFilter(10,10,1)],mycanvas);
			myFilterRhythm.start();
			var my_rhythm = new SimpleRhythm(onTimer);
			my_rhythm.start(TimeType.TIME, 200);
		}
		
		private function onTimer (r:SimpleRhythm) {
				var my_clip:MB_sedile = new MB_sedile();
				var scale = 0.2 + Math.random() * 0.4;
				my_clip.scale = scale;
				my_clip.lineThickness = 0;
				my_clip.fillColor = colorist.getColor();
				sfondo.addChild(my_clip);
				my_clip.x = my_clip.stage.stageWidth/2;
				my_clip.y = 150;

				var prova:SimpleBallistic = new SimpleBallistic(my_clip, 0.97, 5, 10, 0.15, 90);
				prova.start();
				if (sfondo.numChildren > 30) {
					sfondo.removeChildAt(0);
				}
				
		}		
		/*
		NOTA IMPORTANTE
		Questo evento è necessario se si carica l'animazione in maniera dinamica dentro un'altro filmato
		con la classe Loader o la componente Loader che si trova nel pannello delle componenti di flash.
		Il metodo  AbstractRhythm.manager.removeAllRhythms() al momento NON esiste nel Hype Framework
		rilasciato (1.1.8), è stato aggiunto da me per evitare  che flash si blocchi quando si un filmato hype 
		viene scaricato (unload) per caricare un'altro filmato come avviene nella home page di 
		sisteminterattivi.org.
		Eliminare i segni di commento dal comando solo se si è sicuri di utilizzare una versione di hype che 
		comprenda questo comando.
		Si consiglia di leggere l'articolo relativo al problema su sistemiinterattivi.org.
		*/
		private function chiudiTutto (evt:Event) {
			//AbstractRhythm.manager.removeAllRhythms();
		}
	}
}