package gameCommon.manager 
{
	import flash.display.Sprite;
	import gameCommon.objects.BaseObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.DisplayObject;
	
	/**
	 * ...
	 * @author ...
	 */
	public class SceneManager extends Sprite
	{
		//private var objCollection:Array;
		
		public function SceneManager() 
		{
			//objCollection = new Array();
		}
		
		public function destroyChildObjects():void
		{
			var child:DisplayObject;
			var tmpBaseObject:BaseObject;
			
			for (var i:uint=0; i < this.numChildren; i++)
			{
				child = this.getChildAt(i);
				tmpBaseObject = child as BaseObject;
				if (tmpBaseObject)
				{
					tmpBaseObject.destroy();
				}				
			}
		}
		
		public function destroyScene():void
		{
			destroyChildObjects();
			
		}
	}
	
}