package bingoV1.gameScreen 
{
	/**
	 * ...
	 * @author Siddhant
	 */
	import bingoV1.gameScreen.PrivateChatScreen;
	import CustomSlider;
	import bingoV1.gameScreen.IgnoreUserManager;

	
	public class PrivateChatManager
	{
		private var _nameWindowMap:Object;
		static public var _pcManager:PrivateChatManager;
		public var _numWindow:int;
		public var _bingoGameScreen:BingoGameScreen;
		
		//static private var _startX:Number;
		//static private var _startY:Number;
		
		public function PrivateChatManager(bgs:BingoGameScreen) 
		{
			_nameWindowMap = new Object();	
			_numWindow = 0;
			_bingoGameScreen = bgs;
		}
		
		static public function intialize(bgs:BingoGameScreen):void
		{
			_pcManager = new PrivateChatManager(bgs);
			//_startX = startx;
			//_startY = startY;
		}
		
		public function addChatMessage(userName:String, msg:String):void
		{
			var startX:Number = _bingoGameScreen.getPrivateChatPos().x;
			var startY:Number = _bingoGameScreen.getPrivateChatPos().y;
			if (userName!="")
			{
			if (IgnoreUserManager.isUserBlocked(userName))
				return;
			}
				
			if (_nameWindowMap[userName] == null)
			{
				var privateChat:PrivateChatScreen = new PrivateChatScreen(this,userName);
				
				
				_nameWindowMap[userName] = privateChat;
				_bingoGameScreen.addChild(privateChat);
				if (msg.length > 0)
					privateChat.addChatMessage(userName+": "+msg);				
				privateChat.y = startY;
				privateChat.x = startX - privateChat.width * _numWindow;
				_numWindow++;
			}			
			else
			{
				var chat:PrivateChatScreen = _nameWindowMap[userName] as PrivateChatScreen;
				chat.addChatMessage(userName+": "+msg);
			}
		}
		
		public function privateChatClosed(userName:String):void
		{
			if (_nameWindowMap[userName] != null)
			{
				_nameWindowMap[userName] = null;
				--_numWindow;
			}			
		}
	}

}