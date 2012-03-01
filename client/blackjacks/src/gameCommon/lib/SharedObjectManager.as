package gameCommon.lib 
{	
	import flash.net.SharedObject;
	import flash.events.NetStatusEvent;
	import flash.net.SharedObjectFlushStatus;
	/**
	 * ...
	 * @author ...
	 */
	public class SharedObjectManager 
	{
		
		public function SharedObjectManager() 
		{
			
		}		
		
		static public function getSharedObjectByName(name:String):SharedObject
		{
			var mySo:SharedObject = SharedObject.getLocal(name);
			/*try
			{
				mySo = SharedObject.getLocal("samegame");
			}
			catch (e:Error)
			{
				mySo = new SharedObject();
				mySo.setProperty("samegame");
				mySo.flush();
			}*/
			return mySo;
		}
		
		static public function saveSharedObject(mySo:SharedObject):void 
		{
			//namesaveB.visible = false;
			//playernI.editable = false;
			//playerName = playernI.text;
			//changepB.enabled = true;
			//if (playerName.length > 0)
			//	playB.enabled = true;
			//else
			//	playB.enabled = false;

			//mySo.data.playerName = playernI.text;
			//GameDataSingleton.playerName = playerName;
			var flushStatus:String = null;
			try {
				flushStatus = mySo.flush(10000);
			} catch (error:Error) {
			}
			if (flushStatus != null) {
				switch (flushStatus) {
					case SharedObjectFlushStatus.PENDING:
						mySo.addEventListener(NetStatusEvent.NET_STATUS, onFlushStatus);
						break;
					case SharedObjectFlushStatus.FLUSHED:
						break;
				}
			}
		}

		static private function onFlushStatus(event:NetStatusEvent):void 
		{
			var myso:SharedObject = event.target as SharedObject;
			switch (event.info.code) {
				case "SharedObject.Flush.Success":
				break;
				case "SharedObject.Flush.Failed":
				break;
			}

			myso.removeEventListener(NetStatusEvent.NET_STATUS, onFlushStatus);
		}
	}
	
}