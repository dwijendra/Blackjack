package bingoV1.chat 
{
	import flash.display.Sprite;
	import gameCommon.screens.BaseScreen;
	import flash.events.KeyboardEvent;
	import bingoV1.loginScreen.LoginScreen;
	/**
	 * ...
	 * @author vipul
	 */
	public class PrivateChatHandler extends BaseScreen
	{
		private var _name:String;
		private var _chatHolder:Sprite;
		private var _chatTextSprite:*;
		private var _currentY:Number = 0.0;
		private static const _chatTextheight:Number = 20.0;
		
		public function PrivateChatHandler(name:String) 
		{
			
		}
		override public function initialize():void
		{
			super.initialize();
			//screenUI = new Resources.privateChatScreen();
			  screenUI = GetDisplayObject.getSymbol("privateChatScreen");
			addChild(screenUI);
			_chatHolder = new Sprite();
			addChild(_chatHolder);
			_name = name;
			addGameEventListener(screenUI.chstText, KeyboardEvent.KEY_DOWN, sendMsg);
		}
		
		private function sendMsg(evt:KeyboardEvent):void
		{
			if (screenUI.chatText.text.length > 1)
			{
				if (Key.getAscii() == 13)
				{
					var sendParam:Array = [_name, screenUI.chatText.text];
					SfsMain.sfsclient.sendXtMessage("chatExt", "1", sendParam, "str");
				}
			}
		}
		private function onChatextensionResponse(name:String,msg:String):void
		{
		   
			_chatTextSprite = new Resources.chatTextSprite();
			_chatHolder.addChild(_chatTextSprite);
			_chatTextSprite.name.text = name + ":";
			_chatTextSprite.msg.text = msg;
			
			_chatTextSprite.y = _currentY;
			_currentY += _chatTextheight;
		}
		
	}

}