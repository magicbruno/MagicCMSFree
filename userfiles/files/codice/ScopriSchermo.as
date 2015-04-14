package {
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import mb.hype.display.*;
	import mb.puroAS3.MB_sedile;
	import mb.hype.utils.MB_hypeUtils;
	import hype.extended.layout.GridLayout;
	import hype.framework.behavior.AbstractBehavior;
	
	public class ScopriSchermo extends Sprite {
		var layerSedili:Sprite = new Sprite();
		
		public function ScopriSchermo () {
			addEventListener(Event.ADDED_TO_STAGE, inizializzaSchermo);
			loaderInfo.addEventListener(Event.UNLOAD, chiudiTutto);
		}
		
		private function inizializzaSchermo (evt:Event) {
			addChild(layerSedili);
			var t:Timer = new Timer(2000, 1);
			t.addEventListener(TimerEvent.TIMER, mostraSedili);
			t.start();
			var hide = new HiddenStageAlpha(stage.stageWidth, stage.stageHeight, 8, 100, 0xFF8800, 0);
			addChild(hide);
		}
		
		private function mostraSedili(evt:TimerEvent) {
			var grid:GridLayout = new GridLayout(stage.stageWidth/6, stage.stageHeight/2, stage.stageWidth/6, 0, 5);
			for (var i = 0; i < 5; i++) {
				var myClip:MB_sedile = new MB_sedile();
				myClip.fillColor = 0xBABABA;
				myClip.scale = 0.7;
				myClip.lineThickness = 2;
				grid.applyLayout(myClip);
				
				layerSedili.addChild(myClip);
			}
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
		private function chiudiTutto(evt:Event) {
			//AbstractBehavior.manager.removeAllRhythms();
		}
	}
}