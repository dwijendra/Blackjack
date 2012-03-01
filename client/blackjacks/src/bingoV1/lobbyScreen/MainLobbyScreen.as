package bingoV1.lobbyScreen 
{
	import gameCommon.screens.BaseNetworkScreen;
	import it.gotoandplay.smartfoxserver.data.Room;
	import multiLanguage.ResizeableContainer;
	import multiLanguage.LanguageXMLLoader;
	import flash.events.*;
	import it.gotoandplay.smartfoxserver.SFSEvent;
	import gameCommon.smartFoxAPI.SfsMain;
	import it.gotoandplay.smartfoxserver.data.Room;
	import gameCommon.customUI.ScrollPane;
	import gameCommon.lib.SoundPlayer;
	import bingoV1.gameScreen.CashRequest;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Siddhant
	 */
	public class MainLobbyScreen extends BaseNetworkScreen
	{	
		private var _lastClicked:*;
		private var _roomInfoArray:Array;
		private var _roomNameArray:Array;
		private var _roomList:Array;
		private var _roomBundle:RoomList;
		private var _addRooms:Boolean;
		public static var GOLDEN_ROOM:String="";
		private var _lobbyMainWidth:Number;
		private var _lobbyMainHeight:Number;
		private var _array:Array =new Array();
		private var  _filterSymb:Array = new Array();
		private var _lobbyRoomJoined:Boolean;
		public  static var _UserType:int;
		public var _cashRequestScreen:CashRequest;
		public var joinedRoom:Room;
		public var rect:Sprite;
		
		public function MainLobbyScreen(lobbyRoomJoined:Boolean) 
		{
			_lobbyRoomJoined = lobbyRoomJoined;
			
		}	
		override public function initialize():void
		{
			super.initialize();
			//_lobbyRoomJoined = false;
			//screenUI = new Resources.roomBG();
			  screenUI = GetDisplayObject.getSymbol("roomBG");
			_lobbyMainWidth = screenUI.lobbyMain.width;
			_lobbyMainHeight = screenUI.lobbyMain.height;
			addChild(screenUI);
			//screenUI.lobbyMain.refresh_res.buttonMode = true;
			//addGameEventListener(screenUI.lobbyMain.refresh_res, MouseEvent.CLICK, refreshClicked);
		//	stopAllButton();
			//ResizeableContainer.setTextToUI(screenUI.lobbyMain, LanguageXMLLoader._loadedXML.Lobby.Others);	
			SfsMain.sfsclient.getRoomList();
			
			setForResize();
			if (Main.isFirstLogin)
			{
			   AddCashRequestScreen();
			}
		}
		public function AddCashRequestScreen():void
	    {
			     addLayerTodisableAllButton();
	      	if (_cashRequestScreen==null)
		     	{
		            _cashRequestScreen = new CashRequest(this,true);
					addChild( _cashRequestScreen);
					
				}
       	}
		public function addLayerTodisableAllButton():void
	    {
		 rect = new Sprite();
		 rect.alpha = 0;
		 
		 //rect.height = screenUI.height;
		 //rect.width = screenUI.width;
		 //_shapeSprite.addChild(_wrongRectSprite);
         rect.graphics.lineStyle(2, 0x0000FF);
         rect.graphics.beginFill(0x0000FF);
         rect.graphics.drawRect(0, 0,screenUI.width, screenUI.height);
	     screenUI.addChild(rect);
	}
	public function removeLayerToEnableAllButton():void
	{
		// rect = new Rectangle(0,0,screenUI.width,screenUI.height);
	   // screenUI.addChild(rect);
	    screenUI.removeChild(rect);
	}
	public function removeCashScreen():void
	{
		if (_cashRequestScreen)
			{
				removeChild(_cashRequestScreen);
				removeLayerToEnableAllButton();
				Main.isFirstLogin = false;
				 _cashRequestScreen = null;
			}
		
	}
		
		private function refreshClicked(evt:MouseEvent):void
		{
			//trace("+++++++++++++++refresh button is clicked++++++++++++");
			//SoundPlayer.playSound("buttonClick");
			var sendParam:Array=[7,"Lobby1"];
			SfsMain.sfsclient.sendXtMessage("zoneExt", "7", sendParam, "str");
			//SfsMain.sfsclient.getRoomList();			
		}
		override public function resizeScreen():void
		{
			//trace ("here in resize");
			//this.height = stage.stageHeight;
			//this.width = stage.stageWidth;
			
			if (screenUI)
			{
				screenUI.bck.width = stage.stageWidth;
				screenUI.bck.height = stage.stageHeight;
				
				screenUI.lobbyMain.x = (stage.stageWidth - _lobbyMainWidth) / 2;
				screenUI.lobbyMain.y = (stage.stageHeight - _lobbyMainHeight) / 2;
				
			   if ( _cashRequestScreen)
			   {
				    _cashRequestScreen.x = screenUI.lobbyMain.x-25;
					_cashRequestScreen.y = screenUI.lobbyMain.y+50;
			   }
				
			}
		}
		
		private function stopAllButton():void
		{
			/*for (var i:int = 2; i <= 10;++i )
			{
				var str:String = "btn" + i;
				screenUI.lobbyMain[str].gotoAndStop(2);
				screenUI.lobbyMain[str].buttonMode = true;
				screenUI.lobbyMain[str].visible = false;
				//addGameEventListener(screenUI.lobbyMain[str], MouseEvent.CLICK,openRoomList);
			}*/
		//	addGameEventListener(screenUI.lobbyMain.btn1, MouseEvent.CLICK, openRoomList);
			screenUI.lobbyMain.btn1.buttonMode = true;
		//	screenUI.lobbyMain.btn1.color.gotoAndStop(1);
		//	_lastClicked = screenUI.lobbyMain.btn1;
		}
		private function addfilterButton():void
		{
			var k:int = 1;
			for (var l:int = 2; l < _array.length; l++)
			{
				screenUI.lobbyMain.removeChild(_array[l]);
				_array[l] = null;
			}
			var posy:Number = screenUI.lobbyMain.btn1.y + 25;
			var posx:Number = screenUI.lobbyMain.btn1.x;
			for (var i:int = 0; i < _filterSymb.length;i++)
			{
		     	var symb:*= new Resources.filtersym();
			    symb.color.gotoAndStop(2);
				symb.txt.text = Number(_filterSymb[i]).toFixed(2);
				//symb.txt.text = _filterSymb[i];
				symb.buttonMode = true;
				symb.visible = true;
				symb.x = posx;
				symb.y = posy;
				_array[i] = symb;
				addGameEventListener(symb, MouseEvent.CLICK, openRoomList);
				screenUI.lobbyMain.addChild(symb);
				posy += 25;					
			}				
		}
			
		
		
		override public function onJoinRoom(evt:SFSEvent):void
		{
			
		       joinedRoom = evt.params.room;
			_UserType = int(joinedRoom.getUser(Main._userName).getVariable("Utype"));
			//trace ( " Room Joined jau ho ++++++++"+joinedRoom.getName());
			if (joinedRoom.getName() != "Lobby1")
			{
				//now this screen is to be removed and BingoGame to be added
			//trace("hi how are u ",joinedRoom.getName());
				var main:Main = this.parent as Main;
				Main.showGameScreen(joinedRoom);				
			}	
			else
			{
				SfsMain.sfsclient.getRoomList();
			}
		}
		
		override public function onRoomListUpdate(evt:SFSEvent):void
		{
			//trace ("Room List Upd
			//trace ("Lobby room joined is  what is this ++++++++outside" + _lobbyRoomJoined);
			if (!_lobbyRoomJoined )
			{
				var sendParam:Array = [1, "Lobby1"];
				//trace ("Lobby room joined is  what is this ++++++++Inside" + _lobbyRoomJoined);
			    SfsMain.sfsclient.sendXtMessage("LobbyExtension", "1", sendParam, "str");
				//trace("jai hind________________jai bharat");
				//SfsMain.sfsclient.joinRoom("Lobby1");
				_lobbyRoomJoined = true;
			}
			//SfsMain.sfsclient.joinRoom(2);
			 _roomNameArray = new Array();
			 _roomList = evt.params.roomList;
			 for (var r:String in evt.params.roomList)
			 {
				// trace(evt.params.roomList[r].getVariable("rid"), "--------->  roomName");
					
					
					if ( int(evt.params.roomList[r].getVariable("rid"))==25)
					{
						
					   GOLDEN_ROOM=evt.params.roomList[r].getName();
					}
					if (evt.params.roomList[r].getName()!="Lobby1")
					{
					_roomNameArray.push(evt.params.roomList[r].getName());
					}
			 }
			 if (_roomList)
			 {
			   setRoomVariables(_roomList);
			 }
			setRooms();
			addAllRooms();
		//	addfilterButton();
			upDateRoom();
             
		}
		public function addAllRooms():void
		{
			//trace("kitan aaya",_roomInfoArray.length)
			for (var i:int = 0; i < _roomInfoArray.length;++i  )
			 {
				
				 _roomBundle.addRoom(_roomInfoArray[i], _roomNameArray[i]);
				
			 }
			 _roomBundle.showRooms();
			// SfsMain.sfsclient.joinRoom(_roomNameArray[0]);
		}
		public function addFiltersRoom(cardPrice:String):void
		{
			//setRoomVariables(_roomList);
			setRooms();
			for (var i:int = 0; i < _roomInfoArray.length;++i  )
			 {
				
				 if(Number(_roomInfoArray[i].cp)==Number(cardPrice))
						_roomBundle.addRoom(_roomInfoArray[i],_roomNameArray[i]);
			 }
			 _roomBundle.showRooms();
		}
		override public function onExtensionResponse(event:SFSEvent):void
		{
		
			var result:*= event.params.dataObj;

			/*for (var s:* in result)
			{
				trace(s,"    ",result[s]);
			}*/
			if ((int)(result[0])==8)
			{
				//for updating room variable
				
			}
			if ((int)(result[0]) == ServerConstants.ROOM_MESSAGE)
			{
				
				var roomvar:Array = result[2].split("*");
				//trace("room var "+roomvar.length)
				for (var rv:int = 0; rv < roomvar.length;rv++)
				{
					var rvArray:Array = roomvar[rv].split(",");
					//trace(rv,"rid is",roomvar[rv]);
					var info:Object = {rid:rvArray[0],cpl:rvArray[1],rs:rvArray[2],mp:rvArray[3],tm:rvArray[4]};
					_roomBundle.updateRoom(info);
				}
				
			}
			else if (result[0] == ServerConstants.ROOM_UPDATE_MESSAGE)
			{
				SfsMain.sfsclient.getRoomList();
			}			
		}
		
		private function setRoomVariables(roomList:Array):void
		{
			_roomInfoArray = new Array();
			
			for (var i:int = 0; i < roomList.length;++i )
			{
				
				//trace("BEFORE VARIABLE");
				if (roomList[i])
				{
					if (roomList[i].getName() != "Lobby1")
					{
						 
						    var roomName:String = roomList[i].getName();
							var roomNo:int = int(roomList[i].getVariable("rid"));
							var maxPlayer:String = roomList[i].getVariable("mp" );
							var currentPlayer:String = roomList[i].getVariable("cpl");
							var roomStatus:int = int(roomList[i].getVariable("rs"));
							var timer:int = int(roomList[i].getVariable("tm"));
							var maxBet:Number = Number(roomList[i].getVariable("mxb"));
							var minBet:Number = Number(roomList[i].getVariable("mxb"));
							_roomInfoArray.push( {tm:timer, rid:roomNo, mp:maxPlayer, cpl:currentPlayer, rs:roomStatus,RN:roomName,mxb:maxBet,mnb:minBet } );
							
					}
				}
					
			}
		
			
			 
			
			
		}
		private function upDateRoom():void
		{
		     for (var i:int = 0; i < _roomInfoArray.length;++i )
			 {
				 _roomBundle.updateRoom(_roomInfoArray[i]);
			 }
		}
		private function openRoomList(evt:MouseEvent):void
		{
			// trace("value to filter is clicked==============================");
		//	SoundPlayer.playSound("buttonClick");
			_lastClicked.color.gotoAndStop(2);
			var btn:*= evt.currentTarget;
			
			_lastClicked = btn;
			btn.color.gotoAndStop(1);
			var btnName:String = evt.currentTarget.name;
			//var btn:*= evt.currentTarget;
			if (btnName == "btn1")
			{
				 addAllRooms();
			}
			else
			{
				 //trace("value to filter is",btn.txt.text);
				 addFiltersRoom(btn.txt.text);
				
			}
			
		}
		
		private function setRooms():void
		{
			 if (_roomBundle)
			 {
				 //screenUI.lobbyMain.removeChild(_roomBundle);
				 //removeChild(_roomBundle);
				 _roomBundle.parent.removeChild(_roomBundle);
				 _roomBundle = null;
			 }
		     _roomBundle = new RoomList();
			// addChild(_roomBundle);
			 _roomBundle.x = screenUI.lobbyMain.roomp.x;
			 _roomBundle.y = screenUI.lobbyMain.roomp.y;
			 
			 var visibleWidth:Number = screenUI.lobbyMain.roompEnd.x - screenUI.lobbyMain.roomp.x;
			 var visibleHeight:Number = screenUI.lobbyMain.roompEnd.y - screenUI.lobbyMain.roomp.y;
			 
			// trace (screenUI.lobbyMain.slider.bidSlider , " ASDFASDF ");
			 var sp:ScrollPane = new ScrollPane(visibleWidth, visibleHeight, _roomBundle, screenUI.lobbyMain.slider.bidSlider);
			//sp.x = screenUI.chatDisplay.x;
			//sp.y = screenUI.chatDisplay.y;
			 screenUI.lobbyMain.addChild(sp);
		}	
		
	}
}