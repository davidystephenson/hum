import flash.display.MovieClip;
import flash.events.Event;
import flash.media.Sound;
import flash.media.SoundChannel;

class Hum extends MovieClip {
    public var orchestra:Orchestra;
    public var size:Float;
    public var score:Array<Array<Dynamic>>;
    public var boxes:Array<Array<Box>>;

    public function new(myOrchesta:Orchestra, myX:Float, myY:Float, mySize:Float) {
        super();
        orchestra = myOrchesta;
        x = myX;
        y = myY;

        // Determine the size of the Hum. Hums are square, so only one variable is needed.
        size = mySize;

        // Create the score. This is read and modified by the boxes, and read by the instrument during playColumn
        score = new Array<Array<Dynamic>>();
        for(row in 0...orchestra.rowNum) score[row] = [];
        /// Set the default score values to 0;
        for(row in 0...orchestra.rowNum) for(column in 0...orchestra.colNum) score[row][column] = 0;

        // Create the boxes; one for each column in reach row. Boxes are fed their location. 
        boxes = new Array<Array<Box>>();
        for(row in 0...orchestra.rowNum) boxes[row] = [];
        for(row in 0...orchestra.rowNum) for(column in 0...orchestra.colNum) boxes[row][column] = new Box(orchestra, this, row, column); 

        orchestra.addChild(this);
    } // public function new(myCanvas:MovieClip)

} // class Prism extends MovieClip
