package gameCommon.graphics 
{
	/**
	 * ...
	 * @author Vipul
	 */
	public class DrawUtils
	{
		
		public function DrawUtils() 
		{
			
		}
		
		static public function drawRectangle(_sprite:*,pwidth:Number,pheight:Number,lineWidth:int = 3,lineColor:uint = 0x000000,fillColor:uint = 0xAAAAAA,xpos:Number  = 0,ypos:Number = 0):void
		{
			//_sprite = new Sprite();
            //addChild(_sprite);
            _sprite.graphics.lineStyle(lineWidth,lineColor);
            _sprite.graphics.beginFill(fillColor);
            _sprite.graphics.drawRect(xpos, ypos,pwidth ,pheight);
			//_sprite.visible = false;
		}
		
	}

}