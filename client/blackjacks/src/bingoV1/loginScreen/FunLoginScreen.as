package bingoV1.loginScreen 
{
	/**
	 * ...
	 * @author dwijendra
	 */
	import flash.display.Sprite;
	import flash.events.Event;
	import gameCommon.screens.BaseScreen;
	import flash.events.MouseEvent;
	//import gameCommon.manager.GameManager;
	import gameCommon.smartFoxAPI.SfsMain;
	import bingoV1.GameConstants;
	import gameCommon.lib.SHA1;
	import multiLanguage.LanguageXMLLoader;
	import multiLanguage.ResizeableContainer;
	import flash.events.MouseEvent;
	import flash.net.SharedObject;
	import gameCommon.lib.SharedObjectManager;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	 
	 
	public class FunLoginScreen
	{
		
		
		public static var name:String;
		private var screenUI:*;
		public var showReal:Function;
		//private var checkClicked:Boolean;
		private static const _soName:String = "BingoV1_gs";
		public function FunLoginScreen(fun:Function) 
		{
			showReal = fun;
		}
		
		public function initialize(ui:*):void
		{
			
			//screenUI = new Resources.loginScreen();
			//addChild(screenUI);
			screenUI = ui;
			//screenUI.loginMain.check.gotoAndStop(1);
			screenUI.loginMain.userName.text = "";
			//screenUI.loginMain.password.text = "";
			screenUI.loginMain.userName.addEventListener(Event.CHANGE, disablePlayButton);
			screenUI.loginMain.register.addEventListener(MouseEvent.CLICK, redirect);
			screenUI.loginMain.realB.addEventListener(MouseEvent.CLICK, goToRealMode);
			//trace ("adding keyboard event");
			screenUI.addEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
			
			//stage.invalidate();
			//ResizeableContainer.setTextToUI(screenUI.loginMain, LanguageXMLLoader._loadedXML.LoginScreen);	
			
			//var nameSo:SharedObject = SharedObject.getLocal(_soName);
		/*	if (nameSo)
			{
				if (nameSo.data.name)
				{
					screenUI.loginMain.userName.text = nameSo.data.name;
					screenUI.loginMain.password.text = nameSo.data.pwd;
					screenUI.loginMain.check.gotoAndStop(2);
					checkClicked = true;
					
				}
			}
			disablePlayButton();
			*/
			
		}
		
			public function redirect(evt:Event):void
		{
			    var str:String = GetDisplayObject.getPath(2);
		      var request:URLRequest = new URLRequest(str);
		   // trace("string toooooooooooooooo",str);
		 
			try {
				navigateToURL(request, '_blank');
			   } 
		 catch (e:Error) {
						//trace("Error occurred!");
					}
			
		}
		public function goToRealMode(e:Event):void
		{
			showReal();
		}
		
		/*private function checkButtonClicked(e:Event):void 
		{
			var btn:* = e.currentTarget;
			checkClicked = !checkClicked;
			if (checkClicked)
			{
				btn.gotoAndStop(2);				
			}
			else
			{
				btn.gotoAndStop(1);				
			}
		}*/
		
		private function disablePlayButton(evt:Event = null):void
		{
			if (screenUI.loginMain.userName.text.length > 0)
			{
				//trace ("hererer ");
				screenUI.loginMain.playB.addEventListener(MouseEvent.CLICK, playBClicked);
				screenUI.loginMain.playB.enabled = true;
			}
			else
			{
				screenUI.loginMain.playB.removeEventListener(MouseEvent.CLICK, playBClicked);
				screenUI.loginMain.playB.enabled = false;
			}
		}
		
		public function removeListeners():void
		{
			screenUI.loginMain.userName.removeEventListener(Event.CHANGE, disablePlayButton);
			screenUI.loginMain.password.removeEventListener(Event.CHANGE, disablePlayButton);
			screenUI.loginMain.playB.removeEventListener(MouseEvent.CLICK, playBClicked);
			screenUI.removeEventListener(KeyboardEvent.KEY_UP, keyPressed);
		}
		
		private function playBClicked(e:MouseEvent = null):void 
		{
			//trace ("clicked");
			//trace (screenUI.userName.text , screenUI.password.text , " Username , password");
			//trace ("hererer------------>loginClicked ");
			var username:String = screenUI.loginMain.userName.text;
			var pwd:String = "1";
			Main.isRealPlay = false;
			//trace (" User name is ", username, " password is ", pwd , " her");
		
			var encryptedPass:String = pwd;//SHA1.hex_sha1(pwd);
			Main._userName = username;
			
			
			//SfsMain.sfsclient.login(GameConstants.zoneName+GetDisplayObject.lng,name, encryptedPass);
			SfsMain.sfsclient.login(GameConstants.zoneName+GetDisplayObject.lng, username, encryptedPass);
			name = username;
			 clearText();
			//_gameManager = new GameManager(username, pwd);
			//addChild(_gameManager);
			//removeChild(screenUI);
			//dispatchEvent( new LoginInfoEvent(username, pwd));
		}
		public function clearText():void
		{
			screenUI.loginMain.userName.text = "";
			//screenUI.loginMain.password.text = "";
			//screenUI.loginMain.userName.addEventListener(Event.CHANGE, disablePlayButton);
			//screenUI.loginMain.password.addEventListener(Event.CHANGE, disablePlayButton);
			disablePlayButton();
			//stage.invalidate();
		}
		
		private function keyPressed(evt:KeyboardEvent):void
		{
			//if (_chatEnabled == false )
			//	screenUI.chatInput.text = "";
			
			//trace ("Key pressed");
			 if (evt.keyCode == Keyboard.ENTER)
			{
				if (screenUI.loginMain.userName.text.length > 0 && screenUI.loginMain.password.text.length > 0)
					playBClicked(null);
				//submitChat();
			}			
		}
		
		
	}

}