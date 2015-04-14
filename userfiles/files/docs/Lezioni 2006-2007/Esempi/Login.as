class Login {
	private var __username:String;
	public function Login(username:String) {
		this.__username = username;
	}
	public function get userName():String {
		return this.__username;
	}
	
	public function set userName(value:String):Void {
		this.__username = value;
	}
	
}
