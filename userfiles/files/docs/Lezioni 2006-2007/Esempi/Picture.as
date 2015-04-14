/**
	Classe Picture
	autore: John Doe
	versione: 0.53
	data modifica: 6/24/2005
	copyright: Macromedia, Inc.
	La classe Picture viene utilizzata come contenitore per un'immagine e il relativo URL.
*/
class Picture {
	private var __infoObj:Object;
public function Picture(src:String) {
	this.__infoObj = new Object();
	this.__infoObj.src = src;
	}
	public function showInfo():Void {
		trace(this.toString());
	}
	private function toString():String {
		return "[Picture src=" + this.__infoObj.src + "]";
	}
	public function get src():String {
		return this.__infoObj.src;
	}
	public function set src(value:String):Void {
		this.__infoObj.src = value;
	}
}
