/**
	ClasseRettangolo
	autore: Bruno MIlgiaretti
	versione: 1.0
	data modifica: 01/12/2006
	copyright: Accademia di Belle Arti di Urbino
	Questo codice definisce una classe Rettangolo che consente di gestire sullo schermo una figura geometrica di forma rettagolare.
*/

class Rettangolo {
	private var larghezza:Number;		//La larghezza del rettangolo 		
	private var altezza:Number;			//L’altezza del rettangolo
	private var parent_mc:MovieClip;	//Moviclip a cui appartiene il rettangolo
	
	private var _color:Number;			//Colore del rettangolo
	private var _alpha:Number;			//Trasparenza del rettangolo
	private var _rotation:Number;		//Rotazione del rettangolo realtiva al clip filmato parent_mc.

	private var _x:Number;				//Coordinata x del rettangolo realtiva al clip filmato parent_mc
	private var _y:Number;				//Coordinata y del rettangolo realtiva al clip filmato parent_mc
	private var canvas_mc:MovieClip;  		//MovieClip su cui è disegnato il rettangolo
	
	public function Rettangolo (larg:Number, alt:Number, parent:MovieClip, col:Number, 
								trans:Number, rot:Number) {
		//vengono impostate le proprietà
		if (larg != undefined) {
			this.larghezza = larg;
		} else {
			this.larghezza = 0;
		}
		if (alt != undefined) {
			this.altezza = alt;
		} else {
			this.altezza = 0;
		}
		if (parent_mc != undefined) {
			this.parent_mc = parent;
		} else {
			this.parent_mc = _root;			//timeline principale
		}
		if (col != undefined) {
			this._color = col;
		} else {
			this._color = 0;				//nero
		}
		if (trans != undefined) {
			this._alpha = trans;
		} else {
			this._alpha = 100;				//non trasparente
		}
		if (rot != undefined) {
			this._rotation = rot;
		} else {
			this._rotation = 0;				//in gradi
		}
		
		// viene creata la movie clip su cui verrà disegnato il rettangolo
		this.canvas_mc = parent_mc.createEmptyMovieClip("canvas",parent_mc.getNextHighestDepth());
		
		//il retangolo per default viene collocato al centro dello schermo
		this.moveTo(Stage.width/2, Stage.height/2);
		
	}
	
	public function draw () {
		/*
		La MovieClip canvas_mc viene svuotata (clear) e viene disegnato un rettagolo nel colore e con la 
		trasparenza definiti dalle porprietà color e alpha. Il rettangolo viene disegnato in modo che le 
		coordinate di l'origine di canvas_mc risultino al centro del rettangolo. 
		*/
		this.canvas_mc.clear();
		this.canvas_mc.lineStyle(0,0,0);
		this.canvas_mc.beginFill(this.color, this.alpha);
		this.canvas_mc.moveTo(0 - this.larghezza/2 ,0 - this.altezza/2);
		this.canvas_mc.lineTo(this.larghezza/2, 0 - this.altezza/2);
		this.canvas_mc.lineTo(this.larghezza/2, altezza/2);
		this.canvas_mc.lineTo(0 - this.larghezza/2, altezza/2);
		this.canvas_mc.lineTo(0 - this.larghezza/2,this.altezza/2);
		this.canvas_mc.endFill();
		this.canvas_mc._rotation = this._rotation
	}
	
	public function moveTo(xpos:Number, ypos:Number) {
		// aggiorno le coordinate del rettangolo
		this.x = xpos;
		this.y = ypos;
	}
	
	public function clear () {
		//elimina ogni disegno presente su canvas_mc
		this.canvas_mc.clear();
	}
	
	public function free () {
		//elimina canvas_mc liberando risorse
		canvas_mc.removeMovieClip();
	}
	
	//la posizione del rettangolo è la posizione di canvas_mc
	public function get x ():Number {
		return (this.canvas_mc._x);
	}
	public function set x (xpos:Number) {
		this.canvas_mc._x = xpos;
	}

	public function get y ():Number {
		return (this.canvas_mc._y);
	}
	public function set y (ypos:Number) {
		this.canvas_mc._y = ypos;
	}
	
	public function set color (c:Number) {
		//dopo aver modificato la proprietà _color
		//viene chiamato il metodo draw per aggiornare 
		//la variazione sullo schermo
		this._color = c;
		this.draw();
	}
	public function get color ():Number {
		return this._color;
	}

	public function set alpha (c:Number) {
		//dopo aver modificato la proprietà _alpha
		//viene chiamato il metodo draw per aggiornare 
		//la variazione sullo schermo
		this._alpha = c;
		this.draw();
	}
	public function get alpha ():Number {
		return this._alpha;
	}

	//la rotazione del rettangolo è la rotazione di canvas_mc
	public function get rotation ():Number {
		return (this._rotation);
	}
	public function set rotation (r:Number) {
		this._rotation = r;
		this.canvas_mc._rotation = r;
	}
	
	//calcolo dell'area
	public function get area ():Number {
		return (this.larghezza * this.altezza);
	}
	public function set area (a:Number) {
		//manda alla finestra di ouput un messaggio di errore
		trace("Errore: proprietà a solo scrittura");
	}
	
	

}
