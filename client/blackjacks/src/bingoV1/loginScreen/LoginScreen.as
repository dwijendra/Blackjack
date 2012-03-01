package bingoV1.loginScreen 
{
	//import events.LoginInfoEvent;
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
	/**
	 * ...
	 * @author 
	 */
	public class LoginScreen extends Sprite
	{
		public static var name:String;
		private var screenUI:*;
		private var checkClicked:Boolean;
		private static const _soName:String = "BingoV1_gs";
		public var showFun:Function;
		public function LoginScreen(fun:Function) 
		{
			checkClicked = false;
			showFun = fun;
				//screenUI=GetDisplayObject.getSymbol("loginScreen");	
			   // addChild(screenUI);	
				//initialize(screenUI);
			
		}
		
		public function initialize(ui:*):void
		{
			
			//screenUI = new Resources.loginScreen();
			//addChild(screenUI);
			screenUI = ui;
			screenUI.loginMain.check.gotoAndStop(1);
			screenUI.loginMain.password.displayAsPassword = true; 
			screenUI.loginMain.userName.text = "";
			screenUI.loginMain.password.text = "";
			screenUI.loginMain.userName.addEventListener(Event.CHANGE, disablePlayButton);
			screenUI.loginMain.password.addEventListener(Event.CHANGE, disablePlayButton);
			screenUI.loginMain.check.addEventListener(MouseEvent.CLICK, checkButtonClicked);
			screenUI.loginMain.funPlay.addEventListener(MouseEvent.CLICK, gotoFunMode);
			
			screenUI.loginMain.register.addEventListener(MouseEvent.CLICK, redirect);
			//trace ("adding keyboard event");
			screenUI.addEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
			
			//stage.invalidate();
			//ResizeableContainer.setTextToUI(screenUI.loginMain, LanguageXMLLoader._loadedXML.LoginScreen);	
			
			var nameSo:SharedObject = SharedObject.getLocal(_soName);
			if (nameSo)
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
			
		}
		
		public function redirect(evt:Event):void
		{
			  var str:String = GetDisplayObject.getPath(2);
		      var request:URLRequest = new URLRequest(str);
		  //  trace("string toooooooooooooooo",str);
			try
			  {
				      navigateToURL(request, '_blank');
			  } 
		      catch (e:Error)
		       {
						//trace("Error occurred!");
			   }
			
		}
		
		private function checkButtonClicked(e:Event):void 
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
		}
		public function gotoFunMode(e:Event):void
		{
			showFun();
		}
		
		private function disablePlayButton(evt:Event = null):void
		{
			if (screenUI.loginMain.userName.text.length > 0 && screenUI.loginMain.password.text.length > 0)
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
		public function autoLogin(name:String,pwd:String):void
		{
			Main.isRealPlay = true;
			screenUI.loginMain.userName.text = name;
			screenUI.loginMain.password.text = pwd;
			var encryptedPass:String = pwd;
			Main._userName = name;
			Main._password =encryptedPass;
			SfsMain.sfsclient.login(GameConstants.zoneName+GetDisplayObject.lng,name, encryptedPass);
			
		}
		
		private function playBClicked(e:MouseEvent = null):void 
		{
			//trace ("clicked");
			//trace (screenUI.userName.text , screenUI.password.text , " Username , password");
			//trace ("hererer------------>loginClicked ");
			var username:String = screenUI.loginMain.userName.text;
			var pwd:String = screenUI.loginMain.password.text;
			//Main.isRealPlay = true;
			//trace (" User name is ", username, " password is ", pwd , " her");
		   
			var userNameSo:SharedObject = SharedObject.getLocal(_soName);
			if (checkClicked)
			{
				
				userNameSo.data.name = username;
				userNameSo.data.pwd = pwd;
				SharedObjectManager.saveSharedObject(userNameSo);
			}
			else
			{
				userNameSo.clear();
			}
			pwd= SHA1.hex_sha1(pwd);
			//var lng:String = GetDisplayObject.lng;
			autoLogin(username, pwd);
			
			//SfsMain.sfsclient.login(GameConstants.zoneName+GetDisplayObject.lng, username, encryptedPass);
			name = username;
			
			//_gameManager = new GameManager(username, pwd);
			//addChild(_gameManager);
			//removeChild(screenUI);
			//dispatchEvent( new LoginInfoEvent(username, pwd));
		}
		public function clearText():void
		{
			screenUI.loginMain.userName.text = "";
			screenUI.loginMain.password.text = "";
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