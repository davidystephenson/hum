import flash.display.MovieClip;
import flash.events.Event;
import flash.media.Sound;
import flash.media.SoundChannel;
import haxe.Timer;

class Hum extends MovieClip {
	public var canvas:MovieClip;
	public var boxes:Array<Box>;
	public var rowNum:Int;
	public var colNum:Int;
	public var column:Int;
	public var span:Int;
	public var depth:Int;
	public var red:Int;
	public var blue:Int;
	public var instrument:SoundChannel;
	public var instruments:Array<SoundChannel>;
	public var score:Array<Array<Dynamic>>;
	public var notes:Array<Dynamic>;
	public var timer:Timer;

	public function new(myCanvas:MovieClip) {
		super();
		canvas = myCanvas;

		// Determine how many notes in a single cycle
		colNum = 16;
		column = 0;

		// Determine the size of the Prism. Currently this is the size of the embedded flash object. Width and height are reserved names, so span is used for width and depths is used for height.
		span = 970;
		depth = 600;

		// Set hex values for colors
		blue = 0x0000FF;
		red = 0xFF0000;
			
		// Create the scale of notes utilizing classes contained in the external lib.swf, which is included during compilation by build.hxml
		notes = new Array<Dynamic>();
		notes[0] = new C5();
		notes[1] = new B4();
		notes[2] = new A4();
		notes[3] = new G4();
		notes[4] = new F4();
		notes[5] = new E4();
		notes[6] = new D4();
		notes[7] = new C4();
		/// Set the number of rows equal to number of notes
		rowNum = notes.length;

		// Create the score. This is read and modified by the boxes, and read by the instrument during playColumn
		score = new Array<Array<Dynamic>>();
		for(i in 0...rowNum) score[i] = [];
		/// Set the default score values to 0;
		for(row in 0...rowNum) for (column in 0...colNum) score[row][column] = 0;

		// Create the boxes; one for each column in reach row. Boxes are fed their location. 
		boxes = new Array<Box>();
		for(row in 0...rowNum) for(column in 0...colNum) boxes.push(new Box(this, row, column)); 

		// Create the instrument, which will be used by playColumn()
		instrument = new SoundChannel();

		// Create the timer, running once a second
		timer = new Timer(200);
		timer.run = playColumn;

		canvas.addChild(this);
	} // public function new(myCanvas:MovieClip)

	public function playColumn() {
		// Run by the timer

		// Play the box in the current column in each row
		for(row in 0...rowNum) if(score[row][column]) instrument = notes[row].play();
		
		// Increment the the column to be played
		column = (column + 1) % colNum;
	} // public function playColumn()

	/*
	public function playNextColumn() {
		for(i in 0...rowNum) if(score[i][column]) position[i] = 0;
		if(column == colNum - 1) column = 0; else column++;
		for(box in boxes) box.update();
	} // public function playNextColumn()
	*/
} // class Prism extends MovieClip
