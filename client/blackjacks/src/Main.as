package 
{
	
	
	import bingoV1.gameScreen.BingoGameScreen;
	
	import bingoV1.gameScreen.ButtonHandler;
	import bingoV1.gameScreen.CardContainer;
	import bingoV1.gameScreen.Coins;
	import bingoV1.gameScreen.CoinsHandler;
	import bingoV1.gameScreen.GamePlayScreen;
	
	import bingoV1.gameScreen.PublicChatScreen;
	
	import bingoV1.loginScreen.FunLoginScreen;

	
	import bingoV1.gameScreen.SoundInitializer;
	import bingoV1.gameScreen.SoundScreen;
	import bingoV1.gameScreen.UserList;
	import bingoV1.lobbyScreen.MainLobbyScreen;
	import bingoV1.loginScreen.ErrorLoginScreen;
	import bingoV1.loginScreen.LoginScreen;
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import gameCommon.screens.BaseNetworkScreen;
	import it.gotoandplay.smartfoxserver.data.Room;
	import it.gotoandplay.smartfoxserver.SFSEvent;
	import multiLanguage.LanguageXMLLoader;
	import multiLanguage.ResizeableContainer;
	import Resources;
	import gameCommon.smartFoxAPI.SfsMain;
	import ServerConstants;
	import bingoV1.gameScreen.PrivateChatScreen;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.text.AntiAliasType;
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	import flash.display.LoaderInfo;
	import flash.external.ExternalInterface;
	
	import flash.text.TextField;
	import flash.text.TextFieldType;
	/**
	 * ...
	 * @author 
	 */
	public class Main extends BaseNetworkScreen
	{
		private static var _loginScreen:LoginScreen;
		private static var _funloginScreen:FunLoginScreen;
		private static var _mainLobbyScreen:MainLobbyScreen;
		static public var _sfsMain:SfsMain;
		private static var _bingoGameScreen:BingoGameScreen
		
		public static var _userName:String = null;
		public static var _password:String = null;
		public static var _currentScreen:BaseNetworkScreen;
		public static var _main:Main;
		public static var isRealPlay:Boolean;
        public var _pwd:String = null;
		static public var _languageSet:Boolean = false;
		private var errorScreen:ErrorLoginScreen;
	
		private var	_cardContinerArray:Array;
		private var _coinHolder:CoinsHandler;
		public static var isFirstLogin:Boolean = true;
		//private var _cHolder:CoinsHandler;
		//private var xc:*;
		public function Main():void 
		{
			_main = this;
			_currentScreen = this;
			
		
			
			
			BallResources.initialize();
			var str:String = "1@5@10@25@50@100";
			//var scr1:*=new  Resources.scr();
			//trace("str",str)
			//addChild(scr1)
		//	_coinHolder = new CoinsHandler(str);
			//_coinHolder.addCards(str);
			//_coinHolder.setWeight(10);
			//addChild(_coinHolder)
			//_coinHolder.enableAllButtons(true);
			
		
			
			/*for (var i:int = 1 ; i <= 75 ; ++i)
			{
				var mv:* = new MovingBall(i);
				addChild(mv);
				mv.x = (int(i%15)) * MovingBall._ballDiameter;
				mv.y = (int(i / 15)) * MovingBall._ballDiameter;
			}*/
			
			//addChild(new MovingBall(1));
			
			//showMainScreen();
			//if (stage) init();
			//else addEventListener(Event.ADDED_TO_STAGE, init);
			

		}
		
		public function setLanguageByFlashVars():void
		{
		//	trace ("Language set is ", _languageSet);
			
			if (_languageSet == true )
				return;
				
			_languageSet = true;
		//	trace ("Language set is ", _languageSet);
			
			//trace ("herere in setting flash vars");
			var paramObj:Object = LoaderInfo(this.root.loaderInfo).parameters;
			if (paramObj["language"] != undefined)
			{
				GetDisplayObject.lng = paramObj["language"];
				
			}

			if ((paramObj["user_name"] != undefined)||(paramObj["user_name"] !=null))
			{
				_userName = paramObj["user_name"];
				trace("::::::::::::",_userName);
				
			}
			if ((paramObj["pwd"] != undefined )||(paramObj["pwd"] !=null))
			{
				_pwd = paramObj["pwd"];
				
			}


			GetDisplayObject.setType();
			//for (var keyStr:String in paramObj)
			//{
			//	var valueStr:String = String(paramObj[keyStr]);
				//trace ("\t" + keyStr + ":\t" + valueStr + "\n");
				//tf.appendText("\t" + keyStr + ":\t" + valueStr + "\n");
			//}			
		}
		
		public function showMainScreen():void
		{
			
			_currentScreen = this;
			//screenUI = new Resources.loginScreen();	
			if (screenUI)
			{
				removeChild(screenUI);
				screenUI = null;
			}
			screenUI=GetDisplayObject.getSymbol("loginScreen");	
			addChild(screenUI);
			//trace("search for registration button",	screenUI.LoginMain.register);
			//screenUI.register.addEventListener(MouseEvent.CLICK,redirect);
			//addGameEventListener(screenUI.Loginmain.register, MouseEvent.CLICK, redirect);
			
			addGameEventListener(screenUI, Event.ADDED_TO_STAGE, function invalidateStage():void { setForResize();/* stage.invalidate(); trace ("werwr");*/ } );
			_loginScreen = new LoginScreen(showFunScreen);
			_loginScreen.initialize(screenUI);
			setForResize();
			//_userName = "dwij1";
			if ((_pwd!=null) && (_userName!=null))
			{
				//trace (" _pwd is ", _pwd);
				_loginScreen.autoLogin(_userName, _pwd);
				//trace ("Setting _pwd to null");
				_pwd = null;
			}
		}
		public function showFunScreen():void
		{
			if (screenUI)
			{
				removeChild(screenUI);
				screenUI = null;
			}
			_currentScreen = this;
			//screenUI = new Resources.loginScreen();	
			screenUI = GetDisplayObject.getSymbol("funScreen");	
			
			addChild(screenUI);	
			//trace("search for registration button",	screenUI.LoginMain.register);
			//screenUI.register.addEventListener(MouseEvent.CLICK,redirect);
			//addGameEventListener(screenUI.Loginmain.register, MouseEvent.CLICK, redirect);
			addGameEventListener(screenUI, Event.ADDED_TO_STAGE, function invalidateStage():void { setForResize();/* stage.invalidate(); trace ("werwr");*/ } );
		
			_funloginScreen = new FunLoginScreen(showMainScreen);
			_funloginScreen.initialize(screenUI);
			 setForResize();
		}
	
		
		/*public function initBmpData():void
		{
			//var bdH:Number = DLGameScreen.levelManager._level.level_bg.height;
			var bg:* = new Resources.ballGenerator();
			//var bdH:Number = bg.height;
			//var bdW:Number = bg.width;
			//var bdW:Number = DLGameScreen.levelManager._level.level_bg.width;
			//var bmpData:BitmapData = new BitmapData(bdW,bdH, true,0x000000FF);
			//bmpData.draw(bg);
			var ng:NumberGenerator = new NumberGenerator(bg.numGenerator);
			//return bmpData;
			
			//var bitmap:Bitmap = new Bitmap(bmpData);
			//bg.addChild(bitmap);			
			addChild(bg);
		}*/
		
		override public function initialize():void
		//private function init(e:Event = null):void 
		{
			
			
			//return;
			super.initialize();
			stage.focus = this;
			stage.stageFocusRect = false;
			
			
			
			

			
		
		
		
	
		
			setLanguageByFlashVars();
			initializeGame();
			
			
			//LanguageXMLLoader.loadXML("Spanish", "v1", languageXMLLoaded);
			//addChild(new PublicChatScreen(null));
			//return;
			//initBmpData();
			//var bg:* = new Resources.ballGenerator();
			//addChild(bg);
			//var ng:NumberGenerator = new NumberGenerator(bg.numGenerator);
			//var ng:NumberGenerationScreen = new NumberGenerationScreen();
			//addChild(ng);
			
			//return;
			/*var myFont:* = new Resources.font(); 
			var myFormat:TextFormat = new TextFormat();
			myFormat.font = myFont.fontName; 
			myFormat.size = 24; 
			
			var myTextField:TextField = new TextField(); 
			myTextField.autoSize = TextFieldAutoSize.LEFT; 
			myTextField.defaultTextFormat = myFormat; 
			myTextField.embedFonts = true; 
			myTextField.antiAliasType = AntiAliasType.NORMAL; 
			myTextField.text = "The quick brown fox jumped over the lazy dog."; 
			addChild(myTextField); 
			myTextField.rotation = 40;
			return;*/
			
			//var test:Boolean = true;
			//test = !test;
			//trace (" Test " , test);
			//addChild(new PrivateChatScreen("test"));
			//return;
			/*var bkc:* = new Resources.gameScreen();
			trace (bkc.width, bkc.height);
			addChild(bkc);
			return;*/
			//addChild(new NumberGenerationScreen());
			//return;
			//var numArray:Array = [34, 23, 22, 34, 23, 22, 34, 23, 22, 34, 23, 22, 34, 23, 22, 34, 23, 22, 34, 23, 22, 34, 23, 22];
			//var card:BingoCard = new BingoCard(numArray);
			//addChild(card);
			//for (var i:int = 1; i < 76 ; ++i)
			//{
				//card.checkNumber(i.toString());
		//	}
			//return;
			
		/*	var cardS:String = "1,2,3,21,32,22,21,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57";
			var pS:String = "1,2,3,21,32,22,21,41,42,43";
			var patternWinnerScreen:PatternWinnerScreen = new PatternWinnerScreen(cardS, pS, "test", "0.01");
			addChild(patternWinnerScreen);
			return;*/
			//var text:RunningText = new RunningText();
			//addChild(text);
			//return;
			
			
		//	_mainParent = parent;
			

			//var ball:Ball = new Ball();
			//addChild(ball);
			//LanguageXMLLoader.loadXML("Dutch", "v1", languageXMLLoaded);
			//LanguageXMLLoader.loadSizeXml();
			
			//LanguageXMLLoader.loadXML("Dutch", "v1",languageXMLLoaded);
			// entry point
			//var a:Array=[{name:"vb",id:1},{name:"vbgbnng",id:6},{name:"vbt",id:5},{name:"vbth",id:4},{name:"vbr",id:3},{name:"vbw",id:2}]
			var sou:SoundInitializer = new SoundInitializer();
			//var so:SoundScreen = new SoundScreen();
			//addChild(so);
		}
		
		private function initializeGame():void
		{
			//super.initialize();
			_sfsMain = new SfsMain();
			_sfsMain.setNetworkManager(this);
			_sfsMain.initialize();
			//removeEventListener(Event.ADDED_TO_STAGE, init);

			
		}
		
		override public function resizeScreen():void
		{
			//trace ("herer resizing");
			if (screenUI)
			{
				screenUI.bck.width = stage.stageWidth;
				screenUI.bck.height = stage.stageHeight;
				
				screenUI.loginMain.x = (stage.stageWidth - screenUI.loginMain.width) / 2;
				screenUI.loginMain.y = (stage.stageHeight - screenUI.loginMain.height) / 2;
			}
			if (errorScreen)
			{
			  errorScreen.reSize();
			}
			
			/*if (_loginScreen)
			{
				_loginScreen.width = stage.stageWidth;
				_loginScreen.height = stage.stageHeight;
				_loginScreen.x = 0;
				_loginScreen.y = 0;
				trace (" Stage ", stage.stageWidth,stage.stageHeight,_loginScreen.width,_loginScreen.height);
			}*/
			
		}
		
		override public function onConnection(evt:SFSEvent):void
		{
			trace("---------------> server connect");
			    if (evt.params.success)
				{
					trace("Connection successful");
					showMainScreen();
					
					//LanguageXMLLoader.loadSizeXml();
				}
				else
				{
					trace("Connection failed")
					showConnectionErrorScreen();
				}


		}
		
		override public function onExtensionResponse(event:SFSEvent):void
		{
			//var type:String = evt.params.type
			var result:*= event.params.dataObj;
			//for (var s:* in result)
			//{
				//trace(s,"    ",result[s]);
			//}
			//trace("hi this is response++++",result[2]);
			if (result[0] == ServerConstants.LOGIN_MESSAGE)
			{
				if (result[2] == ServerConstants.LOGIN_OK)
				{
					//_loginScreen.removeScreen();
					if (screenUI!=null)
					{
					removeChild(screenUI);
					_loginScreen.removeListeners();
					}
					screenUI = null;
					
					setMainLobbyScreen(this);
				}
				else
				{
					_languageSet = true;
					errorScreen = new ErrorLoginScreen(int(result[2]));
					addChild(errorScreen);
					if (_loginScreen)
					{
					_loginScreen.clearText();	
					}
				}				
			}
			else 
			{				
			}
		}
		
		override public function removeScreen():void
		{
			//trace ("Remove screen called");
			super.removeScreen();
			if (screenUI)
			{
				removeChild(screenUI);
				
			}
			screenUI = null;
		}
		
		/*override public function initialize():void
		{
			//this.height = stage.stageHeight;
			//this.width = stage.stageWidth;
		}*/
		
		static private function changeScreen(currentScreen:BaseNetworkScreen, newScreen:BaseNetworkScreen):void
		{
			var parent:* = currentScreen.parent;
			currentScreen.removeScreen();
			parent.addChild(newScreen);
						
			_sfsMain.setNetworkManager(newScreen);
			_currentScreen = newScreen;
		}
		
		static public function showGameScreen(room:Room):void
		{
			_bingoGameScreen = new BingoGameScreen(room);
			changeScreen(_mainLobbyScreen, _bingoGameScreen);	
			_mainLobbyScreen = null;
		}
		static public function showAlterScreen(room:Room):void
		{
			_bingoGameScreen = new BingoGameScreen(room);
			changeScreen(_currentScreen, _bingoGameScreen);	
			_mainLobbyScreen = null;
		}
		
		static public function setMainLobbyScreen(oldScreen:BaseNetworkScreen,jdf:Boolean = false):void
		{
			_mainLobbyScreen = new MainLobbyScreen(jdf);
			_sfsMain.setNetworkManager(_mainLobbyScreen);
			//if (oldScreen == null)
			//	changeScreen(this, _mainLobbyScreen);
			//else
			changeScreen(oldScreen, _mainLobbyScreen);
			//addChild(_mainLobbyScreen);
			//stage.invalidate();
		}
	//	static public function setAnotherScreen(oldScreen:BaseNetworkScreen,str:String):void
		//{
			//oldScreen.removeScreen();
		//	_mainLobbyScreen = new MainLobbyScreen();
			//_sfsMain.setNetworkManager(_mainLobbyScreen);
			
		//	 SfsMain.sfsclient.joinRoom(str);
			
		//}
		
		
		
		static public function showConnectionErrorScreen():void
		{
			_languageSet = true;
			changeScreen(_currentScreen, _main);
			//var cbs:* = new Resources.connectionBrokenScreen();	
			var cbs:* = GetDisplayObject.getSymbol("connectionBrokenScreen");	
			//ResizeableContainer.setTextToUI(cbs, LanguageXMLLoader._loadedXML.ConnectionErrScreen);
			_main.initialize();
			_main.addChild(cbs);
			if (_main.stage)
			{
				cbs.width = _main.stage.stageWidth;
				cbs.height = _main.stage.stageHeight;
				//cbs.x = (_main.stage.stageWidth - cbs.width) / 2;
				//cbs.y = (_main.stage.stageHeight - cbs.height) / 2;
			}
			_main.addGameEventListener(cbs.closeB, MouseEvent.CLICK, function(evt:MouseEvent):void { _main.removeChild(cbs); _sfsMain.connect() } );
			
			//_sfsMain.connect();
			//_currentScreen.removeScreen();
		}
		
		static public function logout(evt:SFSEvent = null):void
		{
			_languageSet = true;
			changeScreen(_currentScreen, _main);
			//_currentScreen.removeScreen();
			_main.initialize();
			_main.showMainScreen();
		}
	}	
}