import flash.Lib;
import flash.display.MovieClip;

class Main extends MovieClip {

	public var console:ConsoleSender;
	public var canvas:MovieClip;
	public var hum:Hum;

	public function new() {
		super();
		
        // Prep debugging
		console = new ConsoleSender();

        // Declare the canvas
		canvas = flash.Lib.current;

        // Create a Hum
		hum = new Hum(canvas);

	} // public function new()

	static function main() {
		Lib.current.stage.addChild(new Main());
	} // static function main()
} // class Main
