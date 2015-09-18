package
{
	import flash.display.Sprite;
	import flash.text.TextField;
	
	public class YPoint extends Sprite
	{
		public function YPoint()
		{
			super();
		}
		public function inits(col:uint=0xFF0000, num:int = 0):void
		{
			this.graphics.beginFill(col,1);
			this.graphics.drawCircle(0,0,10);
			this.graphics.endFill();
			var txt:TextField = new TextField();
			this.addChild(txt);
			
			txt.x = -5;
			txt.y = -10;
			txt.textColor = 0xCCCCCC;
			txt.text = num.toString();
			txt.width =  10;
			txt.height =  20;
			txt.mouseEnabled = false;
		}
	}
}