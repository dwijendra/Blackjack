package gameCommon.lib 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Siddhant
	 */
	public class BitmapUtility
	{
		
		public function BitmapUtility() 
		{
			
		}
		
		static public function createEmptyBitmapData(width:Number, height:Number):BitmapData
		{
			var intWidth:int = int(width);
			var intHeight:int = int (height);
			//trace ("In creating width and height are ", intWidth,intHeight);
			var bitmapData:BitmapData = new BitmapData(intWidth,intHeight, true, 0x00000000);
			return bitmapData;
		}
		
		static public function clearBitmapData(bmpData:BitmapData):void
		{
			var rect:Rectangle = new Rectangle(0, 0, bmpData.width, bmpData.height);
			bmpData.fillRect(rect, 0x00000000);
		}
		
		static public function drawSpriteOnBitmapData(bmpData:BitmapData, sprite:MovieClip):void
		{
			
		}
		
	}

}