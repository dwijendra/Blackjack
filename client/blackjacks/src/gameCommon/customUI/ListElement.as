package gameCommon.customUI 
{
	import gameCommon.objects.BaseObject;
	import flash.filters.GlowFilter;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ListElement extends BaseObject
	{
		public var ui:*;
		public var _index:int;
		
		public function ListElement(i:int) 		
		{
			_index = i;
			buttonMode = true;
		}
		
		public function setUI(pui:*):void
		{
			ui = pui;
			addChild(ui);
			mouseChildren = false;
		}		
		
		public function glow():void
		{
		    var color:Number = 0x33CCFF;
            var alpha:Number = 0.8;
            var blurX:Number = 35;
            var blurY:Number = 35;
            var strength:Number = 2;
            var inner:Boolean = false;
            var knockout:Boolean = false;

			var glowFilter:GlowFilter = new GlowFilter(color, alpha, blurX, blurY, strength);
			filters = [glowFilter];
		}
		
		public function removeGlow():void
		{
			filters = [];
		}
	}
	
}