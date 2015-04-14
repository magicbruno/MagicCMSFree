package {
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Point;
	import flash.utils.Timer;
	import hype.extended.behavior.Swarm;
	import hype.framework.rhythm.AbstractRhythm;
	import hype.framework.rhythm.SimpleRhythm;
	import hype.framework.core.TimeType;
	import mb.puroAS3.MB_sedile;
	import mb.utils.MbMath;

	public class SwarmRepeat extends Sprite {
		private var my_clip:Sprite;
		private var swarmArray:Array = new Array();
		private var colors:Array = new Array();
		private var bkColor:uint = 0x333333;
		private var background:Shape = new Shape;
		
		public function SwarmRepeat () {
			MbMath.createGradient(0xDD0000, 0xFF8800, 8, colors);
			MbMath.createGradient(0xFF8800, 0xFFFF00, 8, colors);		
			MbMath.createGradient(0x888888, 0xBABABA, 8, colors);	
			
			var lf:LoaderInfo = loaderInfo;
			if (lf.parameters['bkColor'] != null) {
				bkColor = lf.parameters['bkColor'];
			}
			addEventListener(Event.ADDED_TO_STAGE, inizializzaSchermo);
			lf.addEventListener(Event.UNLOAD, chiudiTutto);
		}
		
		private function creaSedili (r:SimpleRhythm) {
			if (swarmArray.length < 100) {
				var my_clip:MB_sedile = new MB_sedile();
				var scale = 0.2 + (Math.random() * 0.3);
				my_clip.scale = scale;
				my_clip.lineThickness = 2;
				my_clip.lineColor = colors[Math.floor(Math.random() * colors.length)];
				my_clip.fillColor = bkColor;
				my_clip.alpha = 0.7;
				this.addChild(my_clip);
				my_clip.x = my_clip.stage.stageWidth/2;
				my_clip.y = my_clip.stage.stageHeight/2;
				var speed:Number = 5 + (Math.random()*5);
				var turnEase:Number = 0.05 + Math.random()/3;
				var twich:Number = Math.random() * 30;
				var my_swarm:Swarm = new Swarm(my_clip, new Point(0, 0), speed, turnEase, twich);
				swarmArray.push(my_swarm);
				my_swarm.point = new Point(Math.random()* this.stage.stageWidth, 
														Math.random()* this.stage.stageHeight);
				my_swarm.start();
			}
		}
		
		private function cambiaDirezione (r:SimpleRhythm) {
			for (var i = 0; i < swarmArray.length; i++) {
				var s:Swarm = swarmArray[i] as Swarm;
				//trace(s.target.x + " " + s.point.x);
				if (Math.abs(s.target.x - s.point.x) < 10 && Math.abs(s.target.y - s.point.y) < 10) {
					s.point = new Point(Math.random()* this.stage.stageWidth, 
														Math.random()* this.stage.stageHeight);
				}
				
			}
		}
		
		private function inizializzaSchermo(evt:Event) {
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			var g:Graphics = background.graphics;
			g.beginFill(bkColor);
			g.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			addChild(background);
			
			var sr1:SimpleRhythm = new SimpleRhythm(creaSedili);
			var sr2:SimpleRhythm = new SimpleRhythm(cambiaDirezione);
			
			sr1.start(TimeType.TIME, 1000);
			sr2.start(TimeType.ENTER_FRAME, 1);
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