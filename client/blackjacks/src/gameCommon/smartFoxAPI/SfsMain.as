package gameCommon.smartFoxAPI 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import gameCommon.screens.BaseNetworkScreen;
	import Resources;
	import flash.display.*;
	import flash.events.MouseEvent;
	import flash.text.*;
//import gameEvents.*;
	
	/* smartfoxserver libraries */
	import it.gotoandplay.smartfoxserver.SmartFoxClient;
	import it.gotoandplay.smartfoxserver.SFSEvent;
	import it.gotoandplay.smartfoxserver.data.Room;
	import it.gotoandplay.smartfoxserver.data.User;


	/**
	 * ...
	 * @author Rahul
	 */
	public class SfsMain 
	{
		private var _bns:*;
	



       //  public static const _serverIp:String = "83.140.191.218";	
       // public static const _serverIp:String = "192.168.1.112";	
      public static const _serverIp:String = "83.140.191.139";	
         //public static const _serverIp:String = "83.140.191.218";	
        // public static const _serverIp:String = "192.168.1.110";	
    // public static const _serverIp:String = "83.140.191.167";	
	  //public static const _serverIp:String = "127.0.0.1"
        public static const _serverPort:int = 9339;
		public static const _serverZone:String = "sampleZone";
		public static const _extensionName:String = "gameExt";
		public static var _onConnectionDone:String = "onConnectionDone";
		public static var sfsclient:SmartFoxClient;
		
		public function SfsMain() 
		{
			sfsclient = new SmartFoxClient(false);
			//initialize();
			
		}
		public function setNetworkManager(classScreen:*):void
		{
			_bns = classScreen;
		}
		public function initialize():void
		{
			// Create server instance
			
			
			//_bns.initializeParam(_sfsclient,_serverIp, _serverPort, _serverZone, _extensionName, _onConnectionDone);
									
			// Add event listeners
			sfsclient.addEventListener(SFSEvent.onConnection, onConnection);
			sfsclient.addEventListener(SFSEvent.onLogin, onLogin);
			sfsclient.addEventListener(SFSEvent.onRoomListUpdate, onRoomListUpdate);
			sfsclient.addEventListener(SFSEvent.onUserCountChange, onUserCountChange);
			sfsclient.addEventListener(SFSEvent.onJoinRoom, onJoinRoom);
			sfsclient.addEventListener(SFSEvent.onJoinRoomError, onJoinRoomError);
			//sfsclient.addEventListener(SFSEvent.onRoomAdded, onRoomAdded);
			//sfsclient.addEventListener(SFSEvent.onRoomDeleted, onRoomDeleted);
			//sfsclient.addEventListener(SFSEvent.onCreateRoomError, onCreateRoomError);
			//sfsclient.addEventListener(SFSEvent.onPublicMessage, onPublicMessage);
			//sfsclient.addEventListener(SFSEvent.onPrivateMessage, onPrivateMessage);
			sfsclient.addEventListener(SFSEvent.onUserEnterRoom, onUserEnterRoom);
			sfsclient.addEventListener(SFSEvent.onConnectionLost, onConnectionLostHandler);
			sfsclient.addEventListener(SFSEvent.onExtensionResponse, onExtensionResponse);
			sfsclient.addEventListener(SFSEvent.onPublicMessage, onPublicMessageHandler);
			sfsclient.addEventListener(SFSEvent.onPrivateMessage, onPrivateMessageHandler);
			sfsclient.addEventListener(SFSEvent.onLogout, onLogoutHandler);
			sfsclient.addEventListener(SFSEvent.onUserLeaveRoom, onUserLeaveRoomHandler);
			sfsclient.addEventListener(SFSEvent.onUserVariablesUpdate, onUserVariablesUpdateHandler);
			sfsclient.addEventListener(SFSEvent.onRoomVariablesUpdate, onRoomVariableUpdate);
			// Connecto to server
				connect()
		}
		
		private function onPrivateMessageHandler(evt:SFSEvent):void 
		{
			_bns.onPrivateMessageHandler(evt);
		}
		
		private function onRoomVariableUpdate(evt:SFSEvent):void 
		{
			_bns.onRoomVariableUpdate(evt);
		}
		
		public function connect():void // (1)
		{
			trace("<============== client trying to connect to server");
			sfsclient.connect(_serverIp, _serverPort)
		}
				
		public function onConnection(evt:SFSEvent):void              //   (1b)--boolean variable
		{
			
			
			_bns.onConnection(evt);
		}
		public function onConnectionLostHandler(evt:SFSEvent):void
		{
			_bns.onConnectionLostHandler(evt);
		}
		
		public function onLogoutHandler(evt:SFSEvent):void
		{
			_bns.onLogoutHandler(evt);	
		}
		
		public function onUserLeaveRoomHandler(evt:SFSEvent):void
		{
			_bns.onUserLeaveRoomHandler(evt);
		}
			
		
		public function onLogin(evt:SFSEvent):void     
		{
		   _bns.onLogin(evt);   
		}
			
		/*
		* Handler the room list
		* 
		* Before we can use the components in the "view_chat" screen of the viewstack
		* we have to wait for them to initialize.
		*
		* This happens once only, so we keep a flag called "chatViewInited" to check
		* if this is the first time we show the chat screen
		*
		* The populateRoomList method is automatically called by the view_chat Canvas component
		* when it fires the creationComplet event
		*/
		public function onRoomListUpdate(evt:SFSEvent):void   //(3)
		{
			_bns.onRoomListUpdate(evt);
		}
			
		/*
		* Handler a join room event
		*/
		public function onJoinRoom(evt:SFSEvent):void
		{
			_bns.onJoinRoom(evt);
			trace("on join room called");
			
		}
			
		/*
		* Handle error while joining a room
		*/
		public function onJoinRoomError(evt:SFSEvent):void
		{
		     _bns.onJoinRoomError(evt);
		}
			
		/*
		* Handle an error while creating a room
		*/
		public function onCreateRoomError(evt:SFSEvent):void
		{
			_bns.onCreateRoomError(evt);
		}
			
		/*
		* Handle a new room in the room list
		*/
		public function onRoomAdded(evt:SFSEvent):void
		{
			_bns.onRoomAdded(evt);
		}
		public function onStartButtonClicked():void
		{
			
		}
		public function onUserEnterRoom(evt:SFSEvent):void
		{
			_bns.onUserEnterRoom(evt);
		}
		
		public function onUserVariablesUpdateHandler(evt:SFSEvent):void
		{
			
			_bns.onUserVariablesUpdateHandler(evt);
		}
		
		public function onUserCountChange(evt:SFSEvent):void
		{
			_bns.onUserCountChange(evt);
		}
		
		public function sendMsgToServer(msg:String):void
		{
			
		}
		
		public function onExtensionResponse(evt:SFSEvent):void
		{
			/*var result:*= evt.params.dataObj;
			var paramObj:Object = evt.params.dataObj;
			
			for (var s:* in result)
			{
				trace(s,"    ",result[s]);
			}*/
			_bns.onExtensionResponse(evt);
		}
		
		public function onPublicMessageHandler(evt:SFSEvent):void
		{
			_bns.onPublicMessageHandler(evt);
		}

	}
}