import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.geom.ColorTransform;

class Box extends MovieClip {
	public var prism:Prism;
	public var row:Int;
	public var column:Int;
	public var selected:Bool;
	public var size:Float;

	public function new(myPrism:Prism, myRow:Int, myColumn:Int) {
		super();

		//Initialize basic variables	
		prism = myPrism;
		row = myRow;
		column = myColumn;
		selected = false;

		//Check the score to see if the Box is on
		if(prism.score[row][column]) { graphics.beginFill(prism.red); selected = true; }
		else { graphics.beginFill(prism.blue); selected = false; }

		// Each Box should be an equal portion of the Prism
		size = Math.min(prism.depth / prism.rowNum, prism.span / prism.colNum);
		graphics.drawRect(0, 0, size - 1, size -1);
		x = column * size;
		y = row * size;

		addEventListener(MouseEvent.MOUSE_DOWN, toggle);
		prism.canvas.addChild(this);
	} // public function new(grid:MovieClip, columnNumber:Int, rowNumber:Int)

	public function toggle(event:MouseEvent) {
		var my_color:ColorTransform = new ColorTransform();
		if(selected) {
			selected = false;
			prism.score[row][column] = 0;
			my_color.color = prism.blue;
		} else {
			selected = true;
			prism.score[row][column] = 1;
			my_color.color = prism.red;
		}
		transform.colorTransform = my_color;
	} // public function toggle(event:MouseEvent)
} // class Box extends MovieClip

