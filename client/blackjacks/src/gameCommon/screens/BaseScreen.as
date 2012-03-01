package gameCommon.screens 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import gameCommon.manager.EventHandlerManager;
	import flash.events.EventDispatcher;
	//import gameCommon.manager.EventHandlerManager;
	
	/**
	 * ...
	 * @author ...
	 */
	public class BaseScreen extends Sprite
	{
		protected var eventHandlerManager:EventHandlerManager;
		protected var screenUI:*;
		public function BaseScreen() 
		{
			eventHandlerManager = new EventHandlerManager();
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);			
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.focus=this;
			initialize();
		}
		
		public function initialize():void
		{
		}
		
		private function cleanListeners():void
		{
			eventHandlerManager.removeListeners();
			cleanOnExit();
		}
		
		public function cleanOnExit():void
		{
			
		}
		
		public function removeScreen():void
		{
			if (this.parent)
				this.parent.removeChild(this);
				
			cleanListeners ();	
		}
		public function addGameEventListener(dispatcher:EventDispatcher,eventName:String, listener:Function):void
		{
			eventHandlerManager.addListener(dispatcher,eventName, listener);
		}
		
		public function removeGameEventListener(dispatcher:EventDispatcher,eventName:String, listener:Function):void
		{
			eventHandlerManager.removeListener(dispatcher,eventName, listener);
		}
	
	}
	
}