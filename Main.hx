import flash.Lib;
import flash.display.MovieClip;

class Main extends MovieClip {
    public var console:ConsoleSender;
    public var canvas:MovieClip;
    public var orchestra:Orchestra;

    public function new() {
        super();
        
        // Prep debugging
        console = new ConsoleSender();

        // Declare the canvas
        canvas = flash.Lib.current;

        // Create the orchestra, which will contain, manage, and play hums
        orchestra = new Orchestra(canvas);

        // Create two hums
        orchestra.newHum(0, 0, 300);
        orchestra.newHum(600, 0, 300);
        orchestra.newHum(300, 0, 300);
    } // public function new()

    static function main() {
        Lib.current.stage.addChild(new Main());
    } // static function main()
} // class Main
