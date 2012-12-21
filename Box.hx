import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.geom.ColorTransform;

class Box extends MovieClip {
	public var hum:Hum;
	public var row:Int;
	public var column:Int;
	public var selected:Bool;
	public var size:Float;

	public function new(myHum:Hum, myRow:Int, myColumn:Int) {
		super();
        hum = myHum;
		row = myRow;
		column = myColumn;

		// Boxes are not selected by default
		selected = false;
		
		// Check the score to see if the Box is selected
		if(hum.score[row][column]) { graphics.beginFill(hum.red); selected = true; }
		else { graphics.beginFill(hum.blue); selected = false; }

		// Each Box should be an equal portion of the hum
        /// Determine if there is less room for height or width to fit all rows and columns
		size = Math.min(hum.depth / hum.rowNum, hum.span / hum.colNum);
        /// Draw the square
		graphics.drawRect(0, 0, size - 1, size -1);
        /// Place the box
		x = column * size;
		y = row * size;

		addEventListener(MouseEvent.MOUSE_DOWN, toggle);
		hum.canvas.addChild(this);
	} // public function new(grid:MovieClip, columnNumber:Int, rowNumber:Int)

	public function toggle(event:MouseEvent) {
		var my_color:ColorTransform = new ColorTransform();
		if(selected) {
			selected = false;
			hum.score[row][column] = 0;
			my_color.color = hum.blue;
		} else {
			selected = true;
			hum.score[row][column] = 1;
			my_color.color = hum.red;
		}
		transform.colorTransform = my_color;
	} // public function toggle(event:MouseEvent)
} // class Box extends MovieClip

