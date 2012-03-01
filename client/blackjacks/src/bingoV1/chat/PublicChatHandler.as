package bingoV1.chat 
{
	import bingoV1.gameScreen.BingoGameScreen;
	import gameCommon.screens.BaseScreen;
	import flash.events.KeyboardEvent;
	import gameCommon.smartFoxAPI.SfsMain;
	
	/**
	 * ...
	 * @author vipul
	 */
	public class PublicChatHandler extends BaseScreen
	{
		private var _bgs:BingoGameScreen;
		
		public function PublicChatHandler(bingoGameScreen:BingoGameScreen,ui:*) 
		{
			_bgs = bingoGameScreen;
			screenUI = ui;
			addGameEventListener(screenUI.chatText, KeyboardEvent.KEY_DOWN, sendMsg);
		}
		
		private function sendMsg(evt:KeyboardEvent):void
		{
			if (screenUI.chatText.text.length > 1)
			{
				if (Key.getAscii() == 13)
				{
					var sendParam:Array = [screenUI.chatText.text];
					SfsMain.sfsclient.sendXtMessage("chatExt", "0", sendParam, "str");
				}
			}
		}
		public function publicChat():void
		{
			
		}
		
	}

}