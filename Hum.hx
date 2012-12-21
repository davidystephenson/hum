import flash.display.MovieClip;
import flash.events.Event;
import flash.media.Sound;
import flash.media.SoundChannel;
import haxe.Timer;

class Hum extends MovieClip {
    public var canvas:MovieClip;
    public var boxes:Array<Array<Box>>;
    public var rowNum:Int;
    public var colNum:Int;
    public var position:Int;
    public var size:Int;
    public var red:Int;
    public var blue:Int;
    public var instrument:SoundChannel;
    public var instruments:Array<SoundChannel>;
    public var score:Array<Array<Dynamic>>;
    public var notes:Array<Dynamic>;
    public var timer:Timer;

    public function new(myCanvas:MovieClip, myX, myY, mySize) {
    super();
    canvas = myCanvas;
    x = myX;
    y = myY;

    // Determine the size of the Hum. Hums are square, so only one variable is needed.
    size = mySize;

    // colNum is the number of columns - how many notes will be played before the cycle repeats
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

    // Create the score. This is read and modified by the boxes, and read by the instrument during playColumn
    score = new Array<Array<Dynamic>>();
    for(row in 0...rowNum) score[row] = [];
    /// Set the default score values to 0;
    for(row in 0...rowNum) for(column in 0...colNum) score[row][column] = 0;

    // Create the boxes; one for each column in reach row. Boxes are fed their location. 
    boxes = new Array<Array<Box>>();
    for(row in 0...rowNum) boxes[row] = [];
    for(row in 0...rowNum) for(column in 0...colNum) boxes[row][column] = new Box(this, row, column); 

    // Create the instrument, which will be used by playColumn()
    instrument = new SoundChannel();

    // Create the timer, running once a second
    timer = new Timer(200);
    timer.run = playColumn;

    canvas.addChild(this);
    } // public function new(myCanvas:MovieClip)

    public function playColumn() {
    // Run by the timer
    
    // Turn off highlighting
    for(row in 0...rowNum) for(column in 0...colNum) boxes[row][column].alpha = 1;

    // Play the current column
    for(row in 0...rowNum) {
        // Determine the column to highlight. Due to latency, the user hears the previous column
        var highlight = position - 1;

        /// If negative, highlight last column
        if(highlight < 0) highlight = colNum - 1;

        // Highlight the appropriate column
        boxes[row][highlight].alpha = 0.75; 

        // Play each box in the current column
        if(score[row][position]) instrument = notes[row].play(); 
    }
    
    // Increment the column to be played
    position = (position + 1) % colNum;
    } // public function playColumn()

    /*
    public function playNextColumn() {
    for(i in 0...rowNum) if(score[i][column]) position[i] = 0;
    if(column == colNum - 1) column = 0; else column++;
    for(box in boxes) box.update();
    } // public function playNextColumn()
    */
} // class Prism extends MovieClip
