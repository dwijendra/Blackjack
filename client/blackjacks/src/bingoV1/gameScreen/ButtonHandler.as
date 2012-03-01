package bingoV1.gameScreen 
{
	import flash.events.MouseEvent;
	import bingoV1.lobbyScreen.MainLobbyScreen;
	import gameCommon.screens.BaseScreen;
	import gameCommon.smartFoxAPI.SfsMain;

	/**
	 * ...
	 * @author Siddhant
	 */
	public class ButtonHandler extends BaseScreen
	{
		private var _gameScreen:BingoGameScreen;
		private var _coinHandler:CoinsHandler;
		
		private var _roomId:int;
		private const buttonNameArray:Array = ["bet_btn","renew_btn","deal_btn", "hit_btn","stand_btn", "double_btn", "split_btn"];
		private const functionNameA:Array = ["betBClicked","renewBClicked","dealBClicked", "hitBClicked", "standBClicked","doubleBClicked", "splitBClicked"];
        private var flag:Boolean = true;
		
		public function ButtonHandler(bingoGameScreen:BingoGameScreen) 
		{
			_gameScreen = bingoGameScreen;
	     	_roomId = int(_gameScreen ._joinedRoom.getVariable("rid"));
			  screenUI = new Resources.buttonScreen();
			 addChild(screenUI);
			 
			//enableAllButtons(true);
		}
		
		public function enableAllButtons(enable:Boolean):void
		{
			for (var i:int = 0; i < buttonNameArray.length;++i)
			   {
					enableButton(i, enable);
			   }
		}
		public function enableButton(btnNum:int, enabled:Boolean):void
		{
			//trace("trace aya hta",enabled)
			            if (enabled)
						{
							screenUI[buttonNameArray[btnNum]].buttonMode = true;
						  screenUI[buttonNameArray[btnNum]].coinMask.visible=false;
						  screenUI[buttonNameArray[btnNum]].addEventListener(MouseEvent.CLICK, this[functionNameA[btnNum]]);
						}
						else
						{
							screenUI[buttonNameArray[btnNum]].buttonMode = false;
							screenUI[buttonNameArray[btnNum]].coinMask.visible=true;
							screenUI[buttonNameArray[btnNum]].removeEventListener(MouseEvent.CLICK, this[functionNameA[btnNum]]);
						}      
		}
		public function betBClicked(evt:MouseEvent):void
		{
			_gameScreen.showBetScreen();
		}
		
	
		
		public function renewBClicked(evt:MouseEvent):void
		{
			_gameScreen.refrashBClicked();
			//trace("renewClicked");
		}
		public function standBClicked(evt:MouseEvent):void
		{
			//	trace("standClicked", ServerConstants.STAND);
			   var sendParam:Array=[ServerConstants.STAND];
		       SfsMain.sfsclient.sendXtMessage("gameExt", ServerConstants.STAND, sendParam, "str");
		}
		public function dealBClicked(evt:MouseEvent):void
		{
			//trace("dealClicked", ServerConstants.DEAL);
			
			_gameScreen.dealBClicked();
		}
		
		public function buyCards(evt:MouseEvent):void
		{
			screenUI[buttonNameArray[2]].removeEventListener(MouseEvent.CLICK, this[functionNameA[2]]);
		
			
		}
		
		public function hitBClicked(evt:MouseEvent):void
		{
			
		      var sendParam:Array=[ServerConstants.HIT];
		     SfsMain.sfsclient.sendXtMessage("gameExt", ServerConstants.HIT, sendParam, "str");
		     enableButton(5, false)
			 enableButton(6, false)
			
		}
		
	
		public function doubleBClicked(evt:MouseEvent):void
		{
			 var sendParam:Array = [ServerConstants.DOUBLE];
		    // trace("doubleClicked", ServerConstants.DOUBLE);
		     SfsMain.sfsclient.sendXtMessage("gameExt", ServerConstants.DOUBLE, sendParam, "str");
			// enableAllButtons(false);
		}
		public function splitBClicked(evt:MouseEvent):void
		{
		     var sendParam:Array = [ServerConstants.SPLIT];
			// trace("splitClicked", ServerConstants.SPLIT);
		     SfsMain.sfsclient.sendXtMessage("gameExt", ServerConstants.SPLIT, sendParam, "str");
		}
		
		
	}
}