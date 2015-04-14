/**
	Classe DataIt
	autore: Bruno Migliaretti
	versione: 1.0
	data modifica: 01/12/2006
	copyright: Accademia di Belle Arti di Urbino
	Questo codice definisce una classe DataIt che estende la classe predefinita Date 
	traducendone l'output in italiano.
*/

class DataIt extends Date {
	//creo una proprietà mesi che contiene i nomi dei mesi
	private var mesi:Array = new Array("gennaio", "febbraio", "marzo", "aprile", 
						   "maggio", "giugno", "luglio", "agosto", 
						   "settembre", "ottobre", "novembre", "dicembre");

	//e una proprietà giorni che contiene i nomi dei giorni della setimana
	private var giorni:Array = new Array("domenica", "lunedì", "martedì", 
							 "mercoledì", "giovedì", "venerdì", "sabato");
	
	//scrivo una semplice metodo che aggiunge uno "0" 
	//davanti ad un numero se è composto da una sola cifra
	private function zeroPrima(n:Number):String {
		var s:String = n.toString();
		if (s.length == 1) {
			s = "0" + s;
		}
		return (s);
	}
	
	//ridefinisco il metodo toString()
	public function toString():String {
		var giorno_sett:String = giorni[this.getDay()];
		var giorno:Number = this.getDate();
		var mese:String = mesi[this.getMonth()];
		var anno:Number = this.getFullYear();
		var ora:String = zeroPrima(this.getHours());
		var minuti:String = zeroPrima(this.getMinutes());
		var secondi:String = zeroPrima(this.getSeconds());
		return( giorno_sett + " " + giorno + " " + mese + " " + anno +
	                     " " + ora +":" + minuti + ":" + secondi);
	}
}
