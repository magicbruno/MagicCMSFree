/**
	Classe JukeBox
	autore: Bruno Migliaretti
	versione: 1.0
	data modifica: 01/12/2006
	copyright: Accademia di Belle Arti di Urbino
	Questo codice definisce una classe JukeBox che estende la classe predefinita Sound 
	e consente di gestire una lista di brani musicali.
*/

class JukeBox extends Sound {
	private var song_array:Array = new Array();		//lista dei brani del JukeBox
	private var titles_array:Array = new Array();	//lista dei titoli del JukeBox
	
	public function addSong (titolo:String, nomeFile:String):Number {
		//aggiungo in coda ai due array il titolo del brano
		//e il file musicale corrispondente
		this.titles_array.push(titolo);
		this.song_array.push(nomeFile);
		//restituisco l'indice del brano inserito
		return (song_array.length - 1);
	}

	public function playSong (songId:Number) {
		//il file memorizzato nella proprietà url dell'oggetto con indice songId
		//viene caricato ed eseguito
		this.loadSound(song_array[songId], true);
	}

	public function getTitleList():Array {
		//in questo modo titles_array e accessibile solo in lettura e 
		//può essere modificato solo usando il metodo addSong
		return titles_array;
	}
}
