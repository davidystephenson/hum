import flash.display.MovieClip;
import flash.events.Event;
import flash.media.Sound;
import flash.media.SoundChannel;
import haxe.Timer;

class Orchestra extends MovieClip {
    public var canvas:MovieClip;
    public var rowNum:Int;
    public var colNum:Int;
    public var red:Int;
    public var blue:Int;
    public var instrument:SoundChannel;
    public var notes:Array<Dynamic>;
    public var hums:Array<Hum>;
    public var timer:Timer;
    public var position:Int;

    public function new(myCanvas:MovieClip) {
        super();
        canvas = myCanvas;

        // colNum is the number of columns in a hum- how many notes will be played before the cycle repeats
        colNum = 8;

        // Position is the column that will be played next
        position = 0;

        // Set hex values for colors
        blue = 0x0000FF;
        red = 0xFF0000;

        // Create the scale of notes utilizing classes contained in the external lib.swf, which is included during compilation by build.hxml
        notes = new Array<Dynamic>();
        notes[0] = new C5();
        notes[1] = new B4();
        notes[2] = new As4();
        notes[3] = new A4();
        notes[4] = new Gs4();
        notes[5] = new G4();
        notes[6] = new Fs4();
        notes[7] = new F4();
        notes[8] = new E4();
        notes[9] = new Ds4();
        notes[10] = new D4();
        notes[11] = new Cs4();
        notes[12] = new C4();
        /// Set the number of rows equal to number of notes
        rowNum = notes.length;

        // Create the array which will contain hums
        hums = [];

        // Create the instrument, which will be used by playColumn()
        instrument = new SoundChannel();

        // Create the timer, running three times a second, which plays a column of notes
        timer = new Timer(333);
        timer.run = playColumn;

        canvas.addChild(this);
    } // public function new(myCanvas:MovieClip)

    public function playColumn() {
        // Run by the timer
        
        // Turn off highlighting
        for(hum in 0...hums.length) for(row in 0...rowNum) for(column in 0...colNum) hums[hum].boxes[row][column].alpha = 1;

        // Play the current column
        for(hum in 0...hums.length) for(row in 0...rowNum) {
            // Determine the column to highlight. Due to latency, the user hears the previous column
            var highlight = position - 1;

            /// If negative, we want to  highlight last column
            if(highlight < 0) highlight = colNum - 1;

            // Highlight the appropriate column
            hums[hum].boxes[row][highlight].alpha = 0.75; 

            // Play each box in the current column
            if(hums[hum].score[row][position]) instrument = notes[row].play(); 
        }
        
        // Increment the column to be played
        position = (position + 1) % colNum;
    } // public function playColumn()

    public function newHum(myX:Float, myY:Float, mySize:Float) {
        hums.push(new Hum(this, myX, myY, mySize));
    } // public function newHum(myX:Float, myY:Float, mySize:Float)
} // class Orchestra extends MovieClip
