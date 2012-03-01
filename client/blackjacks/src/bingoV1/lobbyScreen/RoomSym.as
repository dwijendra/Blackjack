package bingoV1.lobbyScreen 
{
	import flash.events.MouseEvent;
	import gameCommon.screens.BaseScreen;
	import multiLanguage.LanguageXMLLoader;
	import multiLanguage.ResizeableContainer;
	import gameCommon.smartFoxAPI.SfsMain;
	import gameCommon.lib.SoundPlayer;
	
	/**
	 * ...
	 * @author vipul
	 */
	public class RoomSym extends BaseScreen
	{
		private var _roomInfo:Object;
		private var _roomName:String;
		public static const _symbolHeight:Number = 70;
		
		public function RoomSym(roomInfo:Object,roomName:String) 
		{
			_roomInfo = roomInfo;
			_roomName = roomInfo.RN;
			initializeUI();
			
		}
		public function initializeUI():void
		{
			super.initialize();
			//trace("hgdsgjfgjsdgjfgjgfsdj");
			//screenUI = new Resources.roomSymbolClass();
			  screenUI = GetDisplayObject.getSymbol("roomSymbolClass");
			addChild(screenUI);
			//screenUI.buttonMode = true;
			screenUI.room.gotoAndStop(1);
			//ResizeableContainer.setTextToUI(screenUI, LanguageXMLLoader._loadedXML.Lobby.Room);
			updateRoomName();
			addGameEventListener(screenUI, MouseEvent.CLICK, joinRoom);
			buttonMode = true;
			//mouseChildren = false;
		}
		
		private function joinRoom(evt:MouseEvent):void
		{
			//trace ("heererererttttttttttttttttttttttttttttttttttttt");
			//SfsMain.sfsclient.joinRoom(_roomName);
			//SoundPlayer.playSound("buttonClick");
			var sendParam:Array=[1,_roomName];
			SfsMain.sfsclient.sendXtMessage("LobbyExtension","1", sendParam, "str");
		}
		private function updateRoomName():void
		{
			if (_roomInfo.id == 25)
			{
				screenUI.room.gotoAndStop(7);
			}
			else
			 screenUI.room.gotoAndStop(_roomInfo.rid);
			screenUI.room.txt.text = _roomInfo.rid.toString();
			var tym:int = int(_roomInfo.tm);
			 if (tym < 0)
			   tym = 0;
			
			screenUI.numCards.text ="00:"+(tym>9?tym:"0"+tym);
		
		
		
			screenUI.desc.text = _roomName;
			screenUI.totaluser.text = _roomInfo.mp;
		} 
		
		
		public function updateStatus(roomInfo:Object):void
		{ 
			var tym:int = int(roomInfo.tm);
			 if (tym < 0)
			   tym = 0;
                   
			screenUI.numCards.text ="00:"+(tym>9?tym:"0"+tym);
			screenUI.status_sym.gotoAndStop(roomInfo.rs + 1);
		}
		
		public function updateCurrentUsers(roomInfo:Object):void
		{
			//trace("this is the room update equation"+roomInfo.cpl);
			
			screenUI.curUser.text = roomInfo.cpl;
			//trace(roomInfo.cpl,"))))))))))))current player(((((((((",roomInfo.mp);
			//if ((int(roomInfo.cpl) == int(roomInfo.mp))&& MainLobbyScreen._UserType!=1)
			//{
				///removeGameEventListener(screenUI, MouseEvent.CLICK, joinRoom);
			//}
		}
	}

}