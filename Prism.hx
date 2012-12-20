import flash.display.MovieClip;
import flash.events.Event;
import flash.media.Sound;
import flash.media.SoundChannel;
import haxe.Timer;

class Prism extends MovieClip {
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
		
		// Initialize basic variables
		canvas = myCanvas;
		rowNum = 8;
		colNum = 16;
		boxes = new Array<Box>();
		column = 0;
		span = 970;
		depth = 600;
		blue = 0x0000FF;
		red = 0xFF0000;
		instrument = new SoundChannel();
		instruments = [];

		// Create the score
		score = new Array<Array<Dynamic>>();
		for(i in 0...rowNum) score[i] = [];
		/// Set the default score values to 0;
		for(row in 0...rowNum) for (column in 0...colNum) score[row][column] = 0;
		
		// Create the notes
		notes = new Array<Dynamic>();
		/// Set the score values;
		notes[0] = new C5();
		notes[1] = new B4();
		notes[2] = new A4();
		notes[3] = new G4();
		notes[4] = new F4();
		notes[5] = new E4();
		notes[6] = new D4();
		notes[7] = new C4();

		// Create the boxes
		for(row in 0...rowNum) for(column in 0...colNum) boxes.push(new Box(this, row, column)); 

		// Create the timer, running once a second
		timer = new Timer(200);
		timer.run = tick;

		canvas.addChild(this);
	} // public function new(canvas:MovieClip)

	public function tick() {
		for(row in 0...rowNum) if(score[row][column]) instrument = notes[row].play();
		column = (column + 1) % colNum;
	}

	/*
	public function playNextColumn() {
		for(i in 0...rowNum) if(score[i][column]) position[i] = 0;
		if(column == colNum - 1) column = 0; else column++;
		for(box in boxes) box.update();
	} // public function playNextColumn()
	*/
} // class Prism extends MovieClip
