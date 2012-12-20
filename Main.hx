import flash.Lib;
import flash.display.MovieClip;

class Main extends MovieClip {

	public var console:ConsoleSender;
	public var canvas:MovieClip;
	public var hum:Hum;

	public function new() {
		super();
		
		console = new ConsoleSender();
		canvas = flash.Lib.current;
		hum = new Hum(canvas);

	} // public function new()

	static function main() {
		Lib.current.stage.addChild(new Main());
	} // static function main()
} // class Main
