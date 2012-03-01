package gameCommon.screens 
{
	import flash.events.Event;
	import gameCommon.screens.BaseScreen;
	import gameCommon.smartFoxAPI.BaseNetworkManager;
	import it.gotoandplay.smartfoxserver.SFSEvent;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	/**
	 * ...
	 * @author vipul
	 */
	public class BaseNetworkScreen extends BaseScreen implements BaseNetworkManager
	{
		protected var resize:Boolean;
		
		public function BaseNetworkScreen() 
		{			
		}
		
		override public function initialize():void
		{						
			super.initialize();
			resize = false;
			addGameEventListener(stage,Event.RENDER, renderScreen);
			
			//return;
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			addGameEventListener(stage, Event.RESIZE, waitForRender);
			setForResize();
			//stage.invalidate();
		}
		
		protected function setForResize():void
		{
			//trace ("set for resize called");
			resize = true;
			if (stage)
				stage.invalidate();
		}
		
		private function renderScreen(e:Event):void 
		{
			if (resize)
			{
				resizeScreen();
				resize = false;
			}
		}
		
		public function waitForRender(e:Event):void 
		{
			resize = true;
			if (stage)
				stage.invalidate();
			//trace ("here in resize");
			//stage.addEventListener(Event.RENDER, resizeScreen);			
		}
		
		public function resizeScreen():void 
		{
		//	trace ("herer resizing");
			//stage.removeEventListener(Event.RENDER, resizeScreen);
			if (stage)
			{
				this.height = stage.stageHeight;
				this.width = stage.stageWidth;
				this.x = 0;
				this.y = 0;
				//trace (this.height, this.width, stage.stageHeight, stage.stageWidth, this.x, this.y);			
			}
		}
		
		public function onConnection(evt:SFSEvent):void              
		{
			var ok:Boolean = evt.params.success;
			
		}
		public function onConnectionLostHandler(evt:SFSEvent):void
		{
			//trace ("Connection error screen to be shown");		
			Main.showConnectionErrorScreen();
		}
		
		public function onLogoutHandler(evt:SFSEvent):void
		{
			Main.logout();
		}
		
		public function onUserLeaveRoomHandler(evt:SFSEvent):void
		{
			
		}
		public function onLogin(evt:SFSEvent):void     
		{
		  
		}
		public function onUserEnterRoom(evt:SFSEvent):void
		{
			
		}
			
		public function onRoomListUpdate(evt:SFSEvent):void   //(3)
		{
			
		}
		public function onJoinRoom(evt:SFSEvent):void
		{
			
		}
			
		
		public function onJoinRoomError(evt:SFSEvent):void
		{
		   
		}
			
		
		public function onCreateRoomError(evt:SFSEvent):void
		{
		
		}
			
		
		public function onRoomAdded(evt:SFSEvent):void
		{
			
		}
		public function onStartButtonClicked():void
		{
			
		}
		
		public function onUserVariablesUpdateHandler(evt:SFSEvent):void
		{
			
		}
		
		public function onUserCountChange(evt:SFSEvent):void
		{
			
		}
		
		public function sendMsgToServer(msg:String):void
		{
			
		}
		
		public function onExtensionResponse(event:SFSEvent):void
		{
			
		}
		
		public function onPublicMessageHandler(evt:SFSEvent):void
		{
			
		}
		public function onPrivateMessageHandler(evt:SFSEvent):void
		{
			
		}
		public function onRoomVariableUpdate(evt:SFSEvent):void
		{
			
		}
		

		
	}

}