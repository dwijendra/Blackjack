package bingoV1.loginScreen 
{
	import flash.events.MouseEvent;
	import gameCommon.screens.BaseScreen;
	import multiLanguage.ResizeableContainer;
	import multiLanguage.LanguageXMLLoader;
	import flash.external.ExternalInterface;
	import br.com.stimuli.loading.loadingtypes.URLItem;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	/**
	 * ...
	 * @author vipul
	 */
	public class ErrorLoginScreen extends BaseScreen
	{
		public var type: int = 0;
		
		public function ErrorLoginScreen(i:int) 
		{
			type = i;
		}
		override public function initialize():void
		{
			//screenUI = new Resources.errorloginScreen();
			trace("type is +++++++++++++++++++",type);
			if (type == 0)
			{
			  screenUI = GetDisplayObject.getSymbol("errorloginScreen");
			}
			if (type == -1)
			{
				screenUI = GetDisplayObject.getSymbol("bannedScreen");
			}
			if (type==3)
			{
				screenUI = GetDisplayObject.getSymbol("nonActiveScreen");
			}
			reSize();
			addChild(screenUI);
			addGameEventListener(screenUI.crossB, MouseEvent.CLICK, closeScreen);
			addGameEventListener(screenUI.backB, MouseEvent.CLICK, closeScreen);
			addGameEventListener(screenUI.password, MouseEvent.CLICK,redirect);
			
			//ResizeableContainer.setTextToUI(screenUI, LanguageXMLLoader._loadedXML.LoginerrScreen);	
		}
		//movieClipName.addEventListener(MouseEvent.CLICK, callLink);

		private function redirect(evt:MouseEvent):void
		{
		var str:String = GetDisplayObject.getPath(1);
		var request:URLRequest = new URLRequest(str);
		//trace("string toooooooooooooooo",str);
		 
			try {
				navigateToURL(request, '_blank');
			   } 
		 catch (e:Error) {
						//trace("Error occurred!");
					}
			//ExternalInterface.call('openpage("'+str+'");',str)
		}
		
		
		private function closeScreen(evt:MouseEvent):void
		{
			removeGameEventListener(screenUI.crossB, MouseEvent.CLICK, closeScreen);
			removeGameEventListener(screenUI.backB, MouseEvent.CLICK, closeScreen);
			removeChild(screenUI)
		}
		public function reSize():void
		{
			screenUI.x = (stage.stageWidth - screenUI.width) / 2;
		    screenUI.y = (stage.stageHeight - screenUI.height) / 2;
		}
		
	}

}