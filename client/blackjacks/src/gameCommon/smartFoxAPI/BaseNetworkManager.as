package gameCommon.smartFoxAPI 
{
	import it.gotoandplay.smartfoxserver.SFSEvent;
	/**
	 * ...
	 * @author vipul
	 */
	public interface BaseNetworkManager 
	{
		 function onConnection(evt:SFSEvent):void;              //   (1b)--boolean variable
		 function onUserEnterRoom(evt:SFSEvent):void
		 function onConnectionLostHandler(evt:SFSEvent):void;
		 function onLogoutHandler(evt:SFSEvent):void;
		
		 function onUserLeaveRoomHandler(evt:SFSEvent):void;
		 function onLogin(evt:SFSEvent):void;     
		 function onRoomListUpdate(evt:SFSEvent):void ; 
		 function onJoinRoom(evt:SFSEvent):void;
		
		 function onJoinRoomError(evt:SFSEvent):void;
		
		function onCreateRoomError(evt:SFSEvent):void;
		
		function onRoomAdded(evt:SFSEvent):void;
		
		function onStartButtonClicked():void;
		
		function onUserVariablesUpdateHandler(evt:SFSEvent):void;
		
		function onUserCountChange(evt:SFSEvent):void;
		
		function sendMsgToServer(msg:String):void;
		
		function onExtensionResponse(evt:SFSEvent):void;
		
		function onPublicMessageHandler(evt:SFSEvent):void;
		function onPrivateMessageHandler(evt:SFSEvent):void;
		
		function onRoomVariableUpdate(evt:SFSEvent):void;
		
	}
	
}