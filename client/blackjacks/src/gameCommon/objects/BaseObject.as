package gameCommon.objects 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import gameCommon.manager.EventHandlerManager;
	
	/**
	 * ...
	 * @author ...
	 */
	public class BaseObject extends MovieClip
	{
		private var eventCollecter:EventHandlerManager;
		
		public function BaseObject() 
		{
			eventCollecter = new EventHandlerManager();
		}
		
		public function addObject(parent:DisplayObjectContainer):void
		{
			parent.addChild(this);
		}
		
		public function removeObjectFromStage():void
		{
			if (this.parent)
			{
				this.parent.removeChild(this);
			}
		}
		
		public function destroy():void
		{
			eventCollecter.removeListeners();
			//trace ("Object Destroyed");
		}
		
		public function addGameEventListener(eventName:String, listener:Function):void
		{
			eventCollecter.addListener(this,eventName, listener);
		}
		
		public function removeGameEventListener(eventName:String, listener:Function):void
		{
			eventCollecter.removeListener(this,eventName, listener);
		}
	
	}
	
}