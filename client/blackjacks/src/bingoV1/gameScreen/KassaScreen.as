package bingoV1.gameScreen 
{
	import flash.events.MouseEvent;
	import gameCommon.screens.BaseScreen;
	import multiLanguage.ResizeableContainer;
	import multiLanguage.LanguageXMLLoader;
	import flash.events.MouseEvent;
	import gameCommon.smartFoxAPI.SfsMain;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	/**
	 * ...
	 * @author Siddhant
	 */
	public class KassaScreen extends BaseScreen
	{	
		public var _cashScreen:Function;
		private var bgs:Function;
		public function KassaScreen(cscreen:Function,logout:Function) 
		{
			bgs = logout;
			_cashScreen = cscreen;
			//screenUI = new Resources.kassaScreen();
			if (Main.isRealPlay)
			{
			  screenUI = GetDisplayObject.getSymbol("kassaScreen");
			  addGameEventListener(screenUI.jugar_B, MouseEvent.CLICK,cash);
			}
			else
			{
				screenUI = GetDisplayObject.getSymbol("FunKassaScreen");
				addGameEventListener(screenUI.registerB, MouseEvent.CLICK,redirect);
			}
			addChild(screenUI);
			//ResizeableContainer.setTextToUI(screenUI, LanguageXMLLoader._loadedXML.KaasaScreen);
			addGameEventListener(screenUI.logoutB, MouseEvent.CLICK, function (evt:MouseEvent):void { SfsMain.sfsclient.logout(); } );
			addGameEventListener(screenUI.closeB, MouseEvent.CLICK, function (evt:MouseEvent):void { removeScreen(); } );
			
			
			
		}
		public function cash(e:MouseEvent):void 
		{
			_cashScreen();
		}
		
		public function logout(e:MouseEvent):void 
		{
			bgs();
		}
			
		public function redirect(evt:MouseEvent):void
		{
			  var str:String = GetDisplayObject.getPath(2);
		      var request:URLRequest = new URLRequest(str);
		    //trace("string toooooooooooooooo",str);
			try
			  {
				      navigateToURL(request, '_blank');
			  } 
		      catch (e:Error)
		       {
						trace("Error occurred!");
			   }
			
		}
		
	}

}