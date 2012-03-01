package bingoV1.gameScreen 
{
	import gameCommon.screens.BaseScreen;
	import flash.events.MouseEvent;
	import multiLanguage.ResizeableContainer;
	import multiLanguage.LanguageXMLLoader;
	import GetDisplayObject;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	/**
	 * ...
	 * @author Siddhant
	 */
	public class UserClickedScreen extends BaseScreen
	{
		private var _currentName:String;
		private var _bingoUser:BingoUser;
		private var _username:String;
		private var _addFalg:Boolean = false;
		
		public function UserClickedScreen(userName:String) 
		{
			//_bingoUser = bingouser;
			_username = userName;
			//screenUI = new Resources.userClickedScreen();
			  screenUI = GetDisplayObject.getSymbol("userClickedScreen");
			addGameEventListener(screenUI.closeB, MouseEvent.CLICK, hideUI);			
			//addGameEventListener(screenUI.privateChatB, MouseEvent.CLICK, privateChatClicked);
			addGameEventListener(screenUI.blockB, MouseEvent.CLICK, blockUserClicked);
			addGameEventListener(screenUI.profileB, MouseEvent.CLICK, profileButtonClicked);
			 // addGameEventListener(screenUI.showCardB, MouseEvent.CLICK, showCardClicked);
			//ResizeableContainer.setTextToUI(screenUI, LanguageXMLLoader._loadedXML.UserClickedScreen);
			
		}
		private function profileButtonClicked(e:MouseEvent):void
		{
			var str:String = GetDisplayObject.getProfileArray()+_username;
		trace(str);
		var request:URLRequest = new URLRequest(str);
	     	try {
				navigateToURL(request, "_blank");
			   } 
		 catch (e:Error) {
						trace("Error occurred!");
					}
		}
		private function blockUserClicked(evt:MouseEvent):void
		{
			//block the user
			//if (_bingoUser.
			//_bingoUser.setUserBlocked(!_bingoUser._isBlocked);
			IgnoreUserManager.addIgnoredUser(_bingoUser._userName, !_bingoUser._isBlocked);
			hideUI();
		}
		
		private function privateChatClicked(evt:MouseEvent):void
		{
			//things to be done
			//remove the current UI
			hideUI();
			PrivateChatManager._pcManager.addChatMessage(_currentName, "");			
		}
		
		private function hideUI(evt:MouseEvent = null):void
		{
			//trace ("hide UI called");
			removeGameEventListener(screenUI.privateChatB, MouseEvent.CLICK, privateChatClicked);
			removeChild(screenUI);			
		}
		
		public function setName(name:String):void
		{
			_currentName = name;			
		}
		
		public function showUI(bingoUser:BingoUser):void
		{
			_currentName = bingoUser._userName;
			_bingoUser = bingoUser;
			addChild(screenUI);		
			if (bingoUser._isBlocked == false)
			{
				//screenUI.block_res.text = "Blokker";
				addGameEventListener(screenUI.privateChatB, MouseEvent.CLICK, privateChatClicked);
			}
			else
			{}
				
				
		}
		public function showCardClicked(evt:MouseEvent):void
		{
			removeGameEventListener(screenUI.showCardB, MouseEvent.CLICK, privateChatClicked);
			removeChild(screenUI);	
			//UserList.checkPlayerCardRemoved(_bingoUser);
			//_bingoUser.showBingoUserCrads();
		}
	}

}