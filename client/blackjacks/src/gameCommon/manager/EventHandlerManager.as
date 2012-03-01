package gameCommon.manager 
{
	import flash.events.EventDispatcher;
	public class EventHandlerManager
	{
		private var listenerCollector:Array;

		public function EventHandlerManager():void
		{
			listenerCollector = new Array();
		}

		public function addListener(dispatcher:EventDispatcher, eventName:String,listener:Function):void
		{
			dispatcher.addEventListener(eventName,listener);
			registerListener( { dispatcher:dispatcher, eventName:eventName, listener:listener } );
		}

		public function removeListener(dispatcher:EventDispatcher, eventName:String,listener:Function):void
		{
			dispatcher.removeEventListener(eventName,listener);
			unregisterListener( { dispatcher:dispatcher, eventName:eventName, listener:listener } );
		}

		private function registerListener(obj:Object): void
		{
			for (var i:int = 0; i < listenerCollector.length; i++)
			{				
				if (listenerCollector[i].dispatcher == obj.dispatcher && listenerCollector[i].eventName == obj.eventName && listenerCollector[i].listener == obj.listener)
				{
					return;
				}				
			}			
			listenerCollector.push(obj);
		}

		private function unregisterListener(obj:Object): void
		{
			for (var i:Number = 0; i < listenerCollector.length; i++)
			{				
				if (listenerCollector[i].dispatcher == obj.dispatcher && listenerCollector[i].eventName == obj.eventName && listenerCollector[i].listener == obj.listener)
				{
					listenerCollector.splice(i, 1);
					return;
				}				
			}
		}

		public function removeListeners(): void
		{
			for (var i:Number = 0; i < listenerCollector.length; i++)
			{				
				if (listenerCollector[i].dispatcher.hasEventListener(listenerCollector[i].eventName))
				{
					listenerCollector[i].dispatcher.removeEventListener(listenerCollector[i].eventName, listenerCollector[i].listener);
				}				
			}
		}
	}	
}