/*
	Classe User
	autore: John Doe
	versione: 0.8
	data modifica: 08/21/2005
	copyright: Macromedia, Inc.
	Questo codice definisce una classe User personalizzata per 
	Creare nuovi utenti e specificare le relative informazioni di login.
*/

class User {
	// Variabili di istanza private
	private var __username:String;
	private var __password:String;

	// Funzione di costruzione
	public function User(p_username:String, p_password:String) {
		this.__username = p_username;
		this.__password = p_password;
	}

	public function get username():String {
		return this.__username;
	}

	public function set username(value:String):Void {
		this.__username = value;
	}

	public function get password():String {
		return this.__password;
	}

	public function set password(value:String):Void {
		this.__password = value;
	}
}
