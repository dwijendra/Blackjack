package bingoV1.gameScreen 
{
	import bingoV1.gameScreen.PrivateChatManager;
	import gameCommon.screens.BaseScreen;
	import flash.events.MouseEvent;
	import multiLanguage.ResizeableContainer;
	import multiLanguage.LanguageXMLLoader;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.text.TextFieldAutoSize;
	import bingoV1.DraggableObject;
	//import CustomSlider;
	import gameCommon.customUI.ScrollPane;
	import gameCommon.smartFoxAPI.SfsMain;
	import gameCommon.lib.ChatRenderer;
	/**
	 * ...
	 * @author Siddhant
	 */
	public class PrivateChatScreen extends BaseScreen
	{
		private var _userName:String;
		private var _chatManager:PrivateChatManager;
		private var _scrollPane:ScrollPane;
		private var _chatRenderer:ChatRenderer;
		public var _screen:*;
		private var _initX:Number;
		private var _initY:Number;
		private var _xMovement:Number;
		private var _yMovement:Number;
		public function PrivateChatScreen(manager:PrivateChatManager,userName:String) 
		//public function PrivateChatScreen(userName:String) 
		{
			_userName = userName;
			_chatManager = manager;	
			//screenUI = new Resources.privateChatScreen();
			  screenUI = GetDisplayObject.getSymbol("privateChatScreen");
			    _screen = screenUI;
			//	new DraggableObject(screenUI);
			//trace("fsadjkklsdjfklsdf")
			addGameEventListener(screenUI.closeB, MouseEvent.CLICK, closeClicked);
			addGameEventListener(screenUI.ignoreB, MouseEvent.CLICK, ignoreClicked);
			addGameEventListener(screenUI.dragsym, MouseEvent.MOUSE_DOWN, objectClicked);
			
			
			screenUI.userName.text = userName;
			addChild(screenUI);
			
			var cr:ChatRenderer = new ChatRenderer(screenUI.chatDisplay, screenUI.chatInput, submitChat,14);
			addChild(cr);
			_chatRenderer = cr;
			screenUI.chatDisplay.autoSize = TextFieldAutoSize.CENTER;
			screenUI.chatDisplay.wordWrap = true;
			screenUI.chatDisplay.text = "";
			screenUI.chatInput.text = ""
			//new CustomSlider(0, 100, screenUI.chatDisplay, null, 0);
			var sp:ScrollPane = new ScrollPane(200, 95, _chatRenderer, screenUI.chatSlider);
			//sp.x = screenUI.chatDisplay.x;
			//sp.y = screenUI.chatDisplay.y;
			addChild(sp);
			_scrollPane = sp;
			//sp.x += 10;
			//screenUI.chatDisplay.textFormat	
			
			/*var format:TextFormat = new TextFormat();
            format.font = "Verdana";
            format.color = 0xFF0000;
            format.size = 10;
            format.underline = true;*/

           // label.defaultTextFormat = format;

			
			//ResizeableContainer.setTextToUI(screenUI, LanguageXMLLoader._loadedXML.PrivateChatScreen);
			//addGameEventListener(this, KeyboardEvent.KEY_UP, keyPressed);
			//addGameEventListener(screenUI,KeyboardEvent.KEY_UP, keyPressed);
		}
		
		/*private function keyPressed(evt:KeyboardEvent):void
		{
			trace ("Key pressed");
			 if (evt.keyCode == Keyboard.ENTER)
			{
				//submitChat();
			}			
		}*/
		private function objectClicked(evt:MouseEvent):void
		{
			_initX = evt.stageX;
			_initY = evt.stageY;
			
			addGameEventListener( stage, MouseEvent.MOUSE_MOVE, mouseMoved);
			addGameEventListener( stage, MouseEvent.MOUSE_UP, mouseReleased);
		}
		private function mouseReleased(evt:MouseEvent):void
		{
			
			removeGameEventListener(stage, MouseEvent.MOUSE_MOVE, mouseMoved);		
			removeGameEventListener(stage, MouseEvent.MOUSE_UP, mouseReleased);	
		
		}
		
		private function mouseMoved(evt:MouseEvent):void
		{
		 
			_xMovement = evt.stageX - _initX;
			_yMovement = evt.stageY - _initY;
			
			_initX = evt.stageX;  
			_initY = evt.stageY;			
			
			x += _xMovement;
			y += _yMovement;			
			
			stage.invalidate();
		}
		private function submitChat(msg:String):void
		{
			msg += "\n";
			if (screenUI.chatInput.text.length > 0 && Main.isRealPlay && BingoGameScreen.chatStatus==1)
			{
				//send private message
				//addChatMessage(screenUI.chatInput.text);
				
				
				var userId:int = _chatManager._bingoGameScreen.getIdFromUserName(_userName);
				if (userId == -1)
					return;
				
					//trace ("Sending private message");
				addChatMessage(Main._userName+": "+msg);
				SfsMain.sfsclient.sendPrivateMessage(msg, userId);
				screenUI.chatInput.text = "";
			}
			
		}
		
		private function ignoreClicked(evt:MouseEvent):void
		{			
			trace("fsadjkklsdjfklsdf")
			IgnoreUserManager.addIgnoredUser(_userName,true);
		}
		
		private function closeClicked(evt:MouseEvent):void
		{			
			trace("hiat")
			removeScreen();
			_chatManager.privateChatClosed(_userName);
		}
		
		public function addChatMessage(msg:String):void
		{      var uType:int;
			//screenUI.chatDisplay.text += _userName + " : " + msg;
				var xyz:Array = msg.split(":");
				if (xyz[0]!="")
				{
				  uType = _chatManager._bingoGameScreen.getUserType(xyz[0]);
				//  trace("hi this is typed%%%%%%%%%%",_chatManager._bingoGameScreen.getUserType(xyz[0]),xyz[0] );
				}
				if (xyz[0]=="" || uType==1)
				{
					// trace("hi this is typed", uType );
				     screenUI.chatDisplay.htmlText +=  "<font color='#b93fba' size='13'>" + msg + "</font>"; 
				}
				else
				{
					screenUI.chatDisplay.htmlText+=  "<font color='#000000' size='13'>" + msg + "</font>"; 
				}
			
			_chatRenderer.parseForEmoticons();
			_scrollPane.setFullScroll();
			//trace ("Message Added is ",msg);
		}		
	}

}