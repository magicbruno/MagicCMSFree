package {
	import flash.display.*;
	import flash.events.Event;
	import flash.text.*;
	import mb.hype.behavior.MagneticMouse;
	import mb.hype.color.ColorGradient;
	import hype.extended.layout.GridLayout;
	import hype.framework.core.ObjectPool;
	import hype.framework.core.TimeType;
	import hype.framework.rhythm.SimpleRhythm;
	import mb.puroAS3.MB_sedile;
	import hype.framework.rhythm.AbstractRhythm;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class ProvaMagneticMouse extends Sprite {
		private var colorGradient:ColorGradient;
		private var pool:ObjectPool;
		private var gridLayout:GridLayout;
		private var myText:TextField = new TextField();
		
		public function ProvaMagneticMouse () {
			var lf:LoaderInfo = loaderInfo;
			lf.addEventListener(Event.UNLOAD, chiudiTutto);
			colorGradient = new ColorGradient (0xFF8800, 0x880000, 5, 0x888888, 0xCCCCCC, 5);
			addEventListener(Event.ADDED_TO_STAGE, inizializzaVideo);
			
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, scriviTesto);
			loader.load(new URLRequest("CretiniChaHannoVistoLaMadonna.txt"));
		}
		
		private function inizializzaVideo (evt:Event) {
			var s:Stage = stage;
			s.align = StageAlign.TOP_LEFT;
			s.scaleMode = StageScaleMode.NO_SCALE;
			
			var myFont:Font = new CustomFont();
			
			myText.width = s.stageWidth;
			myText.height = s.stageHeight;
			myText.multiline = true;
			myText.wordWrap = true;
			myText.selectable = false;
			var tf:TextFormat = new TextFormat(myFont.fontName, 30, 0x444444, false, false, false, null, null, 
											   TextFormatAlign.JUSTIFY, 8, 8, 0, -2);
			
			myText.defaultTextFormat = tf;
			myText.text = "Caricamento...";
			myText.condenseWhite = true;
			
			addChild(myText);
			gridLayout = new GridLayout(s.stageWidth/23, s.stageHeight/13, s.stageWidth/23, s.stageHeight/13, 22);
		 	pool = new ObjectPool(MB_sedile, 264);
			
			pool.onRequestObject = function(clip) {
				clip.scale = 0.2;
				clip.lineThickness = 1;
				clip.fillColor = colorGradient.getColor();
				clip.lineColor = 0x555555;
				gridLayout.applyLayout(clip);
				addChild(clip);
				var myBehav:MagneticMouse = new MagneticMouse(clip, 70, 0.1);
				myBehav.start("enter_frame", 1);
				
			}
			pool.requestAll();
			//colora();
		}
		
		private function scriviTesto (evt:Event) {
			var l:URLLoader = evt.target as URLLoader;
			myText.htmlText = String(l.data);
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
			//AbstractRhythm.manager.removeAllRhythms();
		}
	}
}