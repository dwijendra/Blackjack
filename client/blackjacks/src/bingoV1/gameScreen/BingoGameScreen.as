package bingoV1.gameScreen 
{
	import adobe.utils.CustomActions;
	import adobe.utils.ProductManager;
	import com.gskinner.motion.plugins.CurrentFramePlugin;
	import flash.display.InteractiveObject;
	import flash.display.SpreadMethod;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.display.Loader;
	import flash.net.URLRequest; 
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextRun;
	import it.gotoandplay.smartfoxserver.data.Room;	
	import it.gotoandplay.smartfoxserver.data.User;	
	import gameCommon.screens.BaseNetworkScreen;
	import it.gotoandplay.smartfoxserver.SFSEvent;
	import multiLanguage.ResizeableContainer;
	import multiLanguage.LanguageXMLLoader;
	import gameCommon.smartFoxAPI.SfsMain;
	import flash.events.MouseEvent;
	import flash.utils.*;
	import bingoV1.gameScreen.SoundScreen;
	import gameCommon.lib.SoundPlayer;
	import bingoV1.gameScreen.PublicChatScreen;
	import bingoV1.lobbyScreen.MainLobbyScreen;
    import flash.net.navigateToURL;
	import flash.system.Security;
	import com.gskinner.motion.GTween;
	import org.flashdevelop.utils.FlashConnect;
   
	/**
	 * ...
	 * @author Siddhant
	 */
	public class BingoGameScreen extends BaseNetworkScreen
	{
		
	
		public var _joinedUser:User;
		public var _joinedRoom:Room;
		public var _goldenTimeText:Number = 0; 
		
		public var  bg:int = 0;
		public static  var chatStatus:int;
		
		public var _cashRequestScreen:CashRequest;
		public var _gameAmount:String;
		private const _cashResponse:int = 121;
		private const _cashBackResponse:int = 124;
		private const BanFromChat:int = 101;
		private const AdminMsgToAll:int = 102;
		private const AdminPersonalMsg:int = 103;
		private const moveToLobby:int = 100;
		private const  setBackground:int = 26;
		private const JackpotTime:int = 24;
		private const WelcomeMsg:int = 23;
		private const BUserList:int = 22;
		private const BallGenSpeed:int = 201; //ball speed according to generation speed
		private const Balance_info:int = 21;
		private const TIME_LEFT:int = 0;
		private const DRAW_RES:int = 10;
		private const WIN_RES:int = 6;
		private const LOSS_RES:int = 7;
		private const TURN:int = 1;
		private const USER_TIMER:int = 13;
		private const CHAT:int = 100;
		private const GAME_STATE:int = 12;
		private const CARD_NUMBERS:int = 2;
		private const DEAL_RES:int = 11;
		private const NEW_NUMBER:int = 3;
		private const DOUBLE_RES:int = 4;
		private const SPLIT_RES:int = 5;
		private const PLAYER_LIST:int = 8;
		private const PLAYER_JUST_ADDED:int = 9;
		private const TIMER_STATE:int = 0;
		private var  _automate:int = 1;
		private var _funPlayer:int = 0;
		private var _pattern:int = 20;
		public var _cardContainer:CardContainer;
		private var _currentState:int;
		private const DyanamicBonus:int = 104;
		private const SETBACKGROUND:int = 202;
		private var _btnHandler:ButtonHandler;
		
		public var onLineUserList:Array;
  
        private var _userTypeArray:Array;
		public var _totalUserArray:Array;
		private var ulist:UserList;
		public var totalBetAmount:Number = 0.0;
        private var PlayerInGameArray:Array;
	
		
		
		
		public var currentTargetedChat:*;
		public static var _gameState:int;

		//to get user id by name
		//private var _nameIdMap:Object;
		private var _soundScreen:SoundScreen;
		private var _newNumGenerator:*;
		private var _tempArray:Array;
		
	//	private var _gameAmountSymbol:*;
		private var _soundScreenEnabled:Boolean;
		
		//we will have a container where all those to be resized as per screen are kept together
		private var _fullResizableContainer:Sprite;
		private var _sizeRetentionContainer:Sprite;
		//private var _publicChatScreen:PublicChatScreen;
		public  var _publicChatScreen:PublicChatScreen;
		
		public static const origWidth:Number = 1024;
		public static const origHeight:Number = 768;
		
		
		private var _selfUser:User;
	
	
		

		
		
		  //-------------------------------------------------------------------------------------------
		  private var _buttonHandler:ButtonHandler;
		  private var _kasaScreen:KassaScreen;
		 // private var _cardContainer:CardContainer;
		   private var _adminContainer:CardContainer=null;
		  private var _coinHolder:CoinsHandler;
		  private const betB:int = 0;
		  private const refrashB:int = 1;
		  private const dealB:int = 2;
		  private const hitB:int = 3;
		  private const standB:int = 4;
		  private const doubleB:int = 5;
		  private const splitB:int = 6;
		  private var _cardContinerArray:Array;
		//  private var flag:Boolean = false;
		  private var flags:Boolean = false;
		  private var _winSym:Array;
		  private var dealResFlags:Boolean = false;
		  private var _totatUserAmount:Number=0;
		  private var _timeIntervalID:uint;
		  private var _screenUserName:String;
		 
		  private var _userTurn:int = 0;
	
		  public static var coinflag:Boolean = true;
		  private var _currentX:Number;
		  private var _currentY:Number;
		  private var _coinContainerArr:Array;
		  private var _adminSprite:Sprite;
		  private var _spriteArray:Array;
		  private var userIndex:int = -1;
		
		  private var _coinSpriteVar:int = 0;
		  private var betOk:Boolean = false;
		  private var  _winCoin:Array = new Array();
		  private var _coinSendP:Point ;
		  private var _coinPos:Array;
		  private var _userPos:Array;
		  public static var _maxBetAmount:Number;
		  public static var _minBetAmount:Number;
		  private var amountArray:Array;
		  private var _splitAmountArr:Array;
		  
		
		  
	
		public function BingoGameScreen(roomObj:Room) 
		{
			//trace (" user name ", SfsMain.sfsclient.myUserName);
		//	Security.loadPolicyFile("http://media.myglobalgames.com/crossdomain.xml");
			_fullResizableContainer = new Sprite();
			addChildAt(_fullResizableContainer, 0);
		
			_sizeRetentionContainer = new Sprite();
			addChildAt(_sizeRetentionContainer, 1);
			
			_joinedRoom = roomObj;
			SfsMain.sfsclient.activeRoomId = _joinedRoom.getId();		
			_selfUser = _joinedRoom.getUser(Main._userName);
			SfsMain.sfsclient.myUserId = _selfUser.getId();
			chatStatus =  int(_selfUser.getVariable("chatS"));
		 
			screenUI = new Resources.background_Duch();
			
			addGameEventListener(screenUI.closeB, MouseEvent.CLICK, function ():void {
				
			   SfsMain.sfsclient.logout(); } );
			
			
			_publicChatScreen = new PublicChatScreen(this);
		    _publicChatScreen.name = "PublicChat1";
		    _sizeRetentionContainer.addChild(_publicChatScreen);
			_publicChatScreen.x = screenUI.publicChatP.x;
			_publicChatScreen.y = screenUI.publicChatP.y;
				_publicChatScreen.visible = false;
			_fullResizableContainer.addChild(screenUI);
		
			_soundScreen = new SoundScreen(this);
        
			PrivateChatManager.intialize(this);
			
			_buttonHandler = new ButtonHandler(this);
		     screenUI.addChild(_buttonHandler);
			 _buttonHandler.x = screenUI.buttonP.x;
			  _buttonHandler.y = screenUI.buttonP.y;
			_buttonHandler.enableAllButtons(false);
			
			var str:String = "1@5@10@25@50@100";
			amountArray = str.split("@");
			_coinHolder = new CoinsHandler(str,this);
			_coinHolder.x = screenUI.buttonP.x;
		    _coinHolder.y = screenUI.buttonP.y - _coinHolder.height;
			
		
			
		    screenUI.addChild(_coinHolder);
			_coinHolder.visible = false;
		    _coinContainerArr = new Array();
		   _splitAmountArr = new Array();
		   _winSym = new Array();
	
	         _screenUserName = Main._userName;
			setRoomPropertiesFromVariables(_joinedRoom.getVariables());
			
			setGlow();
			sendGetStateRequest();
			addGameEventListener(screenUI.kassaButton, MouseEvent.CLICK, infoButtonClicked);
			addGameEventListener(screenUI.lobbyB, MouseEvent.CLICK, lobbyButtonClicked);
			//userClickEventForBet();
		
	   
		   setResizePos(1,1);
		   
		}
		private function setResizePos(h:Number, v:Number):void
		{
			_coinPos = new Array();
			_userPos = new Array();
			_coinSendP=new Point(screenUI.coinsendP.x*h ,screenUI.coinsendP.y*v);
			for (var j:int = 1; j <= 3; j++ )
			{
				_coinPos[j] = new Point(screenUI["coinPos" + j].x * h,screenUI["coinPos" + j].y * v);
				_userPos[j] = new Point(screenUI["pt" + j].x * h,screenUI["pt" + j].y * v);
			}
			//trace("resize")
		}
		private function userClickEventForBet():void
		{
		    trace(userIndex,"=============================userindex");
			  if (userIndex == 0)
			  {
				 _coinContainerArr[userIndex+1] = new Array();
				if(totalBetAmount >=_minBetAmount && totalBetAmount <=_maxBetAmount)
			    addGameEventListener(screenUI.coinPos1, MouseEvent.CLICK, addCoinOnScreen);
				screenUI["clickglow" + 1].visible = true;
				 _currentX = screenUI.coinPos1.x;
			    _currentY = screenUI.coinPos1.y;
			  }
			 else
			 {
				 screenUI["clickglow" + userIndex].visible = false;
				 removeGameEventListener(screenUI["coinPos" + userIndex], MouseEvent.CLICK, addCoinOnScreen);
				 //userIndex++;
				  if (userIndex < 3)
				  {
				     screenUI["clickglow" + (userIndex+1)].visible = true;
				    _coinContainerArr[userIndex+1] = new Array();
					if(totalBetAmount >=_minBetAmount && totalBetAmount <=_maxBetAmount)
				     addGameEventListener(screenUI["coinPos" + (userIndex+1)], MouseEvent.CLICK, addCoinOnScreen);
				     _currentX = screenUI["coinPos"+(userIndex+1)].x;
			         _currentY = screenUI["coinPos"+(userIndex+1)].y;
				  }
			 }
		}
		private function setGlow():void
		{
			
			for (var j:int = 1; j <= 3; j++ )
			{
				screenUI["userPos" + j].gotoAndStop(1);
				screenUI["clickglow"+j].visible=false;
			}
			
			
		}
		
		public function logout():void
		{
			
			SfsMain.sfsclient.logout();
		}
		
		private function addCoinOnScreen(evt:MouseEvent):void
		{
		     
				var objName:String = evt.currentTarget.name;
				
				var posInd:int = int(objName.substring(7));
			
				
		     	var coin:Coins = new Coins(_coinHolder._selectedCoinAmt, _coinHolder);
			   
			
			    _coinContainerArr[posInd].push(coin);
				 //  trace("kjklsjda",_coinHolder._selectedCoinAmt, posInd, _coinContainerArr[posInd],userIndex);
				showCoins(posInd);

		}
		private function showCoins(ind:int):void
		{
			removeGameEventListener(screenUI["coinPos" + ind], MouseEvent.CLICK, addCoinOnScreen);
			
	       showCoinsAgain(ind);
			
			check(ind);
		}
		private function showCoinsAgain(id:int):void
		{
			 _currentX = screenUI["coinPos"+id].x;
			  _currentY = screenUI["coinPos" + id].y-10;
		//	trace("sahkd",_coinContainerArr[id])
			if (_coinContainerArr[id])
			{
				for (var i:int = 0; i < _coinContainerArr[id].length; i++ )
				{
					_coinContainerArr[id][i].x = _currentX;
					_coinContainerArr[id][i].y = _currentY;
					_coinContainerArr[id][i].goto(2);
					 _currentY -= 20;
				
					screenUI.addChild(_coinContainerArr[id][i]);
				}
				
			}
		}
		private function check(idx:int):void
		{
			if (_coinContainerArr[idx])
			{
				var totalBet:int = 0;
				
			    for (var i:int = 0; i < _coinContainerArr[idx].length; i++ )
				{
					totalBet += _coinContainerArr[idx][i].getAmount();
				}
				
			}
			
			totalBetAmount = totalBet;
			//trace(totalBet,"bet kita ba")
			setCoinAgain(idx);
			showCoinsAgain(idx);
			setEventAgain();
			
		}
		private function setCoinAgain(id:int):void
		{
			var amt:Number = totalBetAmount;
			
			refrashBClicked();
			setDealVisible();
			totalBetAmount = amt;
			 adjustCoins(amt,id);
			//trace(_coinContainerArr[id],"kya hi h")
		}
		
		private function adjustCoins(amt:Number,id:int):Number
		{
			if (amt <= 4)
			{
			       for (var j1:int = 0; j1 < amt; j1++)
			        {
						 var coin1:Coins = new Coins(1, _coinHolder);
					    _coinContainerArr[id].push(coin1)
					}
			    return 0;
			}
			else
			{
			for (var j:int = amountArray.length - 1; j > 0; j--)
			   {
				if (amt >= amountArray[j] )
				  {
					  amt = amt - amountArray[j];
					  var coin:Coins = new Coins(amountArray[j], _coinHolder);
					  _coinContainerArr[id].push(coin)
					 
					  break;
				  }
			   }
			 
			return adjustCoins(amt,id);
			}
			
		}
		public function  setEventAgain():void
		{
			if ((totalBetAmount + _coinHolder._selectedCoinAmt) > _maxBetAmount && betOk )
			    removeGameEventListener(screenUI["coinPos" + (userIndex+1)], MouseEvent.CLICK, addCoinOnScreen);
			else
			    addGameEventListener(screenUI["coinPos" +  (userIndex+1)], MouseEvent.CLICK, addCoinOnScreen);
		}
		private function hideCoins():void 
		{
			
		     
		 if (_coinContainerArr)
			{
				 
				if(_coinContainerArr[userIndex+1])
				  for (var k:int = 0; k < _coinContainerArr[userIndex+1].length; k++ )
				  {
					
				      screenUI.removeChild(_coinContainerArr[userIndex+1][k]);
					 
				  }
				       _coinContainerArr[userIndex+1] = new Array();
				
			}
			 
		
			
			
		}
	    private function hideCoins1(id:int):void
		{
			 if (_coinContainerArr)
			{
				
				if(_coinContainerArr[id])
				  for (var k:int = 0; k < _coinContainerArr[id].length; k++ )
				  {
					
				      screenUI.removeChild(_coinContainerArr[id][k]);
				  }
				       _coinContainerArr[id] = new Array();
				
			}
		}
		
		override public function resizeScreen():void 
		{
			
			if (stage)
			{
				var stageWidth:Number = stage.stageWidth;
				var stageHeight:Number = stage.stageHeight;
				
				var hsf:Number = stageWidth / origWidth;
				var vsf:Number = stageHeight / origHeight;
				_fullResizableContainer.height = stageHeight;
				_fullResizableContainer.width = stageWidth;
				 
				setResizePos(hsf, vsf);
				if (_kasaScreen)
				{
					_kasaScreen.x = screenUI.kasaScreenP.x*hsf;
					_kasaScreen.y = screenUI.kasaScreenP.y * vsf;
					_kasaScreen.scaleX = hsf;
					_kasaScreen.scaleY = vsf;
				}
				
			
				if (_publicChatScreen)
				{
					_publicChatScreen.x = 0;// screenUI.publicChatP.x * hsf;
					_publicChatScreen.y = 0;// screenUI.publicChatP.y * vsf;
					_publicChatScreen.resizeScreen(hsf, vsf);
				}
				if (ulist)
				{
					ulist.x =screenUI.userList.x*hsf;
					ulist.y = (screenUI.userList.y - 10) * vsf;
					ulist.resizeScreen(hsf, vsf);
				}
				if (_cashRequestScreen)
				{
					//_cashRequestScreen.resizeScreen(hsf, vsf);
				    _cashRequestScreen .x = ((screenUI.width - _cashRequestScreen.width) / 2) * hsf;
				    _cashRequestScreen .y = ((screenUI.height - _cashRequestScreen.height) / 2) * vsf;
				   
				    
				}
			  
				
				
		
			}
		}
		
		private function setSoundScreen(hsf:Number,vsf:Number):void
		{
			if (_soundScreen == null)
				return;
		//	var screenPoint:Point = new Point(screenUI.soundP.x * hsf, screenUI.soundP.y * vsf);
			//var localPos:Point = _sizeRetentionContainer.globalToLocal(screenUI.localToGlobal(screenPoint));
		//	_soundScreen.x = screenPoint.x;// localPos.x;
		//	_soundScreen.y = screenPoint.y;// localPos.y;
			
		}
		override public function onJoinRoom(evt:SFSEvent):void
		{
			//trace ( " Room Joined");
			var joinedRoom:Room = evt.params.room;
			if (joinedRoom.getName() != "Lobby1")
			{
				//now this screen is to be removed and BingoGame to be added
				var main:Main = this.parent as Main;
				Main.showAlterScreen(joinedRoom);				
			}		
			else
			{
				
				goToLobby();
			}
		}
	
	public function removeCashScreen():void
	{
		if (_cashRequestScreen)
			{
				_sizeRetentionContainer.removeChild(_cashRequestScreen);
				 _cashRequestScreen = null;
			}
	}
	
	public function cashScreen():void
	{
	///	_kasaScreen.removeScreen();
		//	_kasaScreen = null;
			
		if (_cashRequestScreen==null)
			{
		         _cashRequestScreen = new CashRequest(this);
		        _sizeRetentionContainer.addChild( _cashRequestScreen);
				  _cashRequestScreen.x = (this.width - _cashRequestScreen.width) / 2;
				   _cashRequestScreen.y = (this.height - _cashRequestScreen.height) / 2;
			}
			else 
			removeCashScreen();
	}	
	
	private function declarationButtonClicked(e:MouseEvent):void
	{
		var str:String = GetDisplayObject.getDeclarationArray();
		//trace(str);
		var request:URLRequest = new URLRequest(str);
	     	try {
				navigateToURL(request, "_blank");
			   } 
		 catch (e:Error) {
						trace("Error occurred!");
					}
	}
		
	private function infoButtonClicked(evt:MouseEvent):void
	{
		//trace ("Kaasa button clicked");
		cashScreen();
	
	}
	
		private function soundButtonClicked(evt:MouseEvent):void
		{
		
			   if (_soundScreenEnabled == false)
			   {
					var btn:* = evt.currentTarget;
					_sizeRetentionContainer.addChild(_soundScreen);	
					var stageWidth:Number = stage.stageWidth;
					var stageHeight:Number = stage.stageHeight;
				
					var hsf:Number = stageWidth / origWidth;
					var vsf:Number = stageHeight / origHeight
					setSoundScreen(hsf, vsf);
				
					_soundScreenEnabled = true;
			   }
			    else
			   {
			  
			   
				   _soundScreen.parent.removeChild(_soundScreen);
				   _soundScreenEnabled = false;
			   }
			
		}
		public function removeSoundScreen():void
		{
			_soundScreen.parent.removeChild(_soundScreen);
			//_fullResizableContainer.removeChild(_soundScreen);
			_soundScreenEnabled = false;
		}
	
		
		private function lobbyButtonClicked(evt:MouseEvent):void
		{
			
			Main.setMainLobbyScreen(this);
		}
		
		override public function initialize():void
		{
			super.initialize();	
			//SoundInitializer.playWelcomeSound();
			
			var ci:* = _publicChatScreen._chatInput;
			stage.focus = ci;
			ci.setSelection(ci.length,ci.length);
			//ResizeableContainer.setTextToUI(screenUI, LanguageXMLLoader._loadedXML.GameRoom.Room);	
			ulist = new UserList(screenUI.sliderPos.x - screenUI.userList.x, screenUI.sliderPos.y - screenUI.userList.y,this);
			IgnoreUserManager.initialize(ulist);
			var ist:String = _selfUser.getVariable("IU");
			IgnoreUserManager.parseIgnoreString(ist);
			//_fullResizableContainer.addChild(ulist);
			_sizeRetentionContainer.addChildAt(ulist,0); //resizing issue test
			ulist.x =screenUI.userList.x;
			ulist.y = screenUI.userList.y;
			setForResize();
			
        
		}		

		override public function onExtensionResponse(event:SFSEvent):void
		{
			//_roomInfoArray = new Array();
			var result:*= event.params.dataObj;
			var resNum:int = int (result[0]);
		// trace("ku", resNum, result);
			switch (resNum)
			{
				
				
				case TIME_LEFT:

						showTimer(result[2])
				break;
				
				case GAME_STATE:
				
					//trace ("Game State String is ", result[2]);
					       parseGameStateString(result[2]);
					
				break;
				case DEAL_RES:
				                  dealResponse(result[2]);
				         //   trace("ky",DEAL_RES, result[2]);
				break;
				case LOSS_RES:
				              //   trace("dealer winner",result[2])
								  
								  var lossArr:Array = result[2].split(":");
								  showWinner(lossArr,LOSS_RES);
								
							
				break;
				case CARD_NUMBERS:
				          //  trace("CARD_NUMBERS", CARD_NUMBERS, result[2]);
							//_timeIntervalID = setTimeout(setCardsOnScreen, 200, result[2]);
							setCardsOnScreen(result[2]);
							
				
				break;
				
				case PLAYER_LIST:
				  // trace("setUser in GAME_STATE called.........PLAYER_LIST..........................................",PLAYER_LIST,result[2]);
				    updatePlayerList(result[2]);
				  
				  break;
				
				case PLAYER_JUST_ADDED:
				               var plAr:Array = result[2].split(",");
							    userIndex = plAr[1];
				              ulist.setuserInGame(plAr[0], 1);
						   
						   if(plAr[0] != _screenUserName)
				              setBetRespectivePlayer(plAr); 
							 
						        
							// trace("userindexnjknk", userIndex);
								userClickEventForBet();
			   // trace("setUser in GAME_STATE called...................................................",PLAYER_JUST_ADDED,result[2]);
				break;
				case CHAT:
				           //  trace(result[2], "on exteion");
							 _publicChatScreen.addChatMessage(result[2], false);
							 
				break;
				
				case USER_TIMER:
				
					//  trace (" USER_TIMER", result[2]);
					   var _userArr:Array = result[2].split("-");
					   screenUI.timerTxt.text =" 00:"+((_userArr[0]>9)?_userArr[0]:"0"+_userArr[0]);
					   screenUI.currentUser.text = _userArr[1];
				
				break;
				case TURN:              //trace("kya aa raha h  turn", TURN, result[2])
				                         var aa:Array = result[2].split("-");
										 if(aa[0]==1)
									     screenUI["userPos" + aa[3]].gotoAndStop(2);
										 if (aa[0] == 0)
										  screenUI["userPos" + aa[3]].gotoAndStop(1);
										  
										  ulist.getUserByName(aa[1])._userTurn = aa[0];
										  
								if ((aa[0] == 0) && (aa[1] == _screenUserName))
								  {
								    _buttonHandler.enableAllButtons(false);
								  }	 	  
				                 if ((aa[0] == 1) && (aa[1] == _screenUserName))
								    {
							
								           enableGameStateButtons();
									    if (ulist.splitCondition() == 1 && _totatUserAmount>0)
			                                _buttonHandler.enableButton(splitB, true); 
										if (_winSym)
			                                 {
												for (var jj:int = 0; jj < _winSym.length; jj++)
												{
													if(_winSym[jj])
			                                         screenUI.removeChild(_winSym[jj]);
			                                        // _winSym[jj] = null;
												}
												_winSym = new Array();
		                                  	}
									
									}
								
								
				break;
				   
				case DRAW_RES:
				             //   trace("kya aa raha h DRAw", DRAW_RES, result[2])
								 var resArr:Array = result[2].split(":");
								   showWinner(resArr,DRAW_RES);
								
								
				break;
				case WIN_RES:
				               //   trace("kya aa raha hwin", WIN_RES, result[2])
								   var resArr1:Array = result[2].split(":");
								   if (resArr1[1])
								   { //trace("kya aa raha hwin", WIN_RES, result[2])
								    showWinner(resArr1, WIN_RES);
								   }
								
								  
				break;
				case DOUBLE_RES:
				     // trace("DOUBLE_RES--------------------------->",DOUBLE_RES,result[2])
					        ulist.setDoubleCond(result[2]);
					
				break;
				
				case SPLIT_RES:
				    //  trace("split cards--------------------->", result[2])
					      
					     var splitArray1:Array = result[2].split("@");
						 ulist.setSplitFun(result[2]);
						 _buttonHandler.enableButton(splitB, false);
						 setSplitBet(splitArray1.length-1,splitArray1[1].split(",")[4]);
						// setDoubleBet(splitArray1[1].split(",")[0],splitArray1[1].split(",")[4])
					  // noOfBingoWinner = splitArray1[0].split(",").length;
						//setBingoWinner(splitArray1);
					
					
				    break;	
				case Balance_info:
				   var splitArray2:Array = result[2].split(",");
				        setBalance(splitArray2);
				   break;
				case BUserList:
					IgnoreUserManager.parseIgnoreString(result[2]);
					
				 break;
				 case WelcomeMsg:
				// trace(" welcomne msg from server", result[2], "yes");
				 _publicChatScreen.addChatMessage("" + ":" + result[2], false);
				
				break;
				
				//case moveToLobby:
				//goToLobby();
				 // break;
				case DyanamicBonus:
				 _publicChatScreen.addChatMessage("-1"+":"+result[2],false);
				break;
				case AdminMsgToAll:
				 _publicChatScreen.addChatMessage("myglobalgames"+" "+":"+" "+result[2],true);
				break;
				case BanFromChat:
				if (int(result[2])==1)
				{
					 //_publicChatScreen.addChatMessage(""+":"+Main._userName+"is banned from chat"+result[2],false);
				}
				if (int(result[2])==0)
				{
					// _publicChatScreen.addChatMessage(""+":"+Main._userName+"is able to chat chat"+result[2],false);
				}
				chatStatus = int(result[2]);
				break;
				case AdminPersonalMsg:
				  // PrivateChatManager._pcManager.addChatMessage("", result[2]);
				   _publicChatScreen.addChatMessage("myglobalgames"+" "+":"+" "+result[2],true);
				 //_publicChatScreen.addChatMessage(""+":"+"Dyanamic BONUS Amount"+result[2],false);
				break;
				case  setBackground:
				//trace("Loader is called" );
				 // FileLoader.loadFile(result[2], loadGame);-----------------
				break;
				case _cashResponse:
			//	trace("hihhihiiiiiiiiiiiiiiiiiiiiiiiiiiBGS",result[2]);
				    _cashRequestScreen.addCash(result[2]);
				  break;
				  case _cashBackResponse:
			
				    _cashRequestScreen.updateCash(result[2]);
				  break;
				  
				
			}
		
		}
		public function goToLobby():void 
		{
			
			Main.setMainLobbyScreen(this,true);
			
		}
		public function showTimer(timeValue:int):void
		{
			//trace("+++++++++++++++timer is called+++++++++++",timeValue);
			if (timeValue < 0)
			   timeValue = 0;
			 var hour:int = timeValue / 3600;
			 var rest:int = timeValue % 3600;
			 var minute:int = rest / 60;
			var second:int = rest % 60;
			//screenUI.watch.gotoAndStop(60 - second);
		
			   if (minute < 10)
			   {
				  if(second <10)
				   screenUI.timer.text = "0"+hour.toString() + ":0" + minute.toString() + ":0" + second.toString();
				  else
				   screenUI.timer.text ="0"+ hour.toString() + ":0" + minute.toString() + ":" + second.toString();
				 // if (hour == 0 && minute == 0)
					//SoundInitializer.playLastTimerSounds(second);
			   }
			   else
			   {
				    if(second <10)
				   screenUI.timer.text = "0"+hour.toString() + ":" + minute.toString() + ":0" + second.toString();
				  else
				   screenUI.timer.text ="0"+ hour.toString() + ":" + minute.toString() + ":" + second.toString();
				  // screenUI.time.text = hour.toString()+":0"+ minute.toString() + ":" + second.toString();
			   }
			
		}		
		
		
		//---------------------------------------------------------------------------------------------start blackjack
		
		private function setSplitBet(arrLength:int,uIndex:int):void
		{
			
		//trace("uindex", uIndex);
			_splitAmountArr[uIndex] = new Array();
			
			for (var i1:int = 0; i1 < arrLength; i1++ )
			{
				 _splitAmountArr[uIndex][i1] = new Array();
				   for (var i:int = 0; i < _coinContainerArr[uIndex].length; i++ )
			       {
				    _splitAmountArr[uIndex][i1].push( new Coins(_coinContainerArr[uIndex][i]._coinsAmount, _coinHolder));
					
			       }
			}
			// trace("kya aaya", _coinContainerArr[uIndex].length)
			   
				hideCoins1(uIndex);
				
				//trace("kya aayajjjjjjjjj",_coinContainerArr[userIndex].length)
			var _currX:Number = screenUI["coinPos" + uIndex].x;
			var _currY:Number = screenUI["coinPos" + uIndex].y;
			for (var j:int = 0; j < arrLength; j++ )
			{
				   for (var k:int = 0; k < _splitAmountArr[uIndex][j].length; k++ )
			       {
					   
				      _splitAmountArr[uIndex][j][k].x = _currX+20;
					  _splitAmountArr[uIndex][j][k].y = _currY;
					  _splitAmountArr[uIndex][j][k].goto(2);
					  screenUI.addChild(_splitAmountArr[uIndex][j][k]);
					  _currX += 20;
					
			       }
				   
			}
			
	        
			
		}
	    private function showWinner(arrUser:Array,str:int):void
		{
			var uName:String = arrUser[0];
			var amt:Number = arrUser[1];
			var _ind:int = arrUser[5];
			var _pos:int = arrUser[4];
			var strs:String = "";
			
			if (_winSym)
			{
			 // screenUI.removeChild(_winSym);
			 // _winSym = null;
			}
			  
			  if (uName == _screenUserName)
				{		 
				  
				  _buttonHandler.enableAllButtons(false);
				   if (ulist.splitCondition() == 1)
				    {
						//trace("fullfied split condition");
						_buttonHandler.enableButton(hitB, true);
						_buttonHandler.enableButton(standB, true);
						_buttonHandler.enableButton(doubleB, true);
					}
				
					 
				}
			//	setForResize();
				if (str == WIN_RES)
				{
				  strs = uName+" Win";
				  coinsMoveToPlayerWithwinAmt(uName,_ind,amt,_pos);
				}
				if (str == DRAW_RES)
				{
				  strs = "Draw";
				   coinsMoveToPlayer(uName,_ind,_pos);
				}
				 if (str == LOSS_RES)
				 {
				  strs = uName +" Loss"//; "Dealer Win";
				   coinsMoveTodealer(uName,_ind,_pos);
				  
				 }
				  
				_winSym[_ind] = new Resources.winSym();
			     _winSym[_ind].txt.text = strs;
			    _winSym[_ind].x = _userPos[_ind].x-_winSym[_ind].width;// (screenUI.width - _winSym.width) / 2;
			    _winSym[_ind].y =  _userPos[_ind].y;// (screenUI.height - _winSym.height) / 2;
		           screenUI.addChild(_winSym[_ind]);
				//trace("sdhk++++++++"+_ind,_userPos[_ind],_winSym[_ind].width)
			
		}
		
		private function coinsMoveTodealer(_uName:String,_index:int,pos:int):void
		{
		      // trace("kya coinsMoveTodealera ah", _index,pos,_coinContainerArr[_index].length,_splitAmountArr[_index][pos].length) ;
		   if (ulist.getUserByName(_uName)._splitEnable)
		   {
			  // trace("kya split1",_index,_splitAmountArr[_index],_splitAmountArr[_index][pos])
			   for (var j:int=0; j < _splitAmountArr[_index][pos].length;j++)
		          _splitAmountArr[_index][pos][j].animation(_coinSendP.x + j * 20, _coinSendP.y);
			
		   }
		   else
		   {
			     for ( j=0; j < _coinContainerArr[_index].length;j++ )
		           _coinContainerArr[_index][j].animation(_coinSendP.x+j*20,_coinSendP.y);
		   }
	
		}
		private function coinsMoveToPlayer(_uName:String,_index:int,pos:int):void
		{
			// trace("kya coinsMoveToPlayer ah", _index,pos,_coinContainerArr[_index].length) ;
			if (ulist.getUserByName(_uName)._splitEnable)
			{
			   // trace("kya split2",_index,_splitAmountArr[_index],_splitAmountArr[_index][pos])
		          for (var j:int=0; j < _splitAmountArr[_index][pos].length;j++)
		          _splitAmountArr[_index][pos][j].animation(_coinSendP.x + j * 20, _coinSendP.y);
				
			}
			else
			{  for (j=0; j < _coinContainerArr[_index].length;j++ )
			     _coinContainerArr[_index][j].animation(_userPos[_index].x + j * 20, _userPos[_index].y);
			}
		}
		private function coinsMoveToPlayerWithwinAmt(_uName:String,_index:int,_amt:Number,pos:int):void
		{      
			 //trace("kya coinsMoveToPlayerWithwin ah", _index,pos,_coinContainerArr[_index].length) ;
			if (ulist.getUserByName(_uName)._splitEnable)
			{
		        //  trace("kya split3",_index,_splitAmountArr[_index],_splitAmountArr[_index][pos])
					   for (var j:int = 0; j < _splitAmountArr[_index][pos].length; j++)
					   {
		                _splitAmountArr[_index][pos][j].animation(_userPos[_index].x + j * 20, _userPos[_index].y);
						_amt = _splitAmountArr[_index][pos][j]._coinsAmount;
					    setWinCoin(_index, _amt, j);
					   }
				      
			}
			else
			{      for (j = 0; j < _coinContainerArr[_index].length; j++ )
				   {
			        _coinContainerArr[_index][j].animation(_userPos[_index].x + j * 20, _userPos[_index].y);
				    _amt  =  _coinContainerArr[_index][j]._coinsAmount;
			         setWinCoin(_index, _amt, j);
				   }
			}
			
		}
		private function setWinCoin(ind:int,betAmt:Number,position:int):void
		{
			
			
			 var coin:Coins = new Coins(betAmt, _coinHolder);
			  coin.goto(2);
			 _winCoin[ind][position]=coin;
			 _winCoin[ind][position].x = screenUI.coinsendP.x-50;
			 _winCoin[ind][position].y = screenUI.coinsendP.y;
			  screenUI.addChild(_winCoin[ind][position]);
			 _winCoin[ind][position].animation(_userPos[ind].x+(position+1)*20+20,_userPos[ind].y);
				
		
		}
		private function removeWinCoin():void
		{
			if (_winCoin)
			 for (var j:int = 1; j < _winCoin.length; j++ )
			 {
				
			     for (var jj:int = 0; jj < _winCoin[j].length; jj++ )
				 {  
			           screenUI.removeChild(_winCoin[j][jj]);
				 }
				
			 }
			  _winCoin = new Array();
			 for (var k:int = 1; k < 4; k++ )
			 {
			     _winCoin[k]=new Array()
				
			 }
		
			
		}
		private function moveCards():void
		{
			
			if (_adminContainer && flags)
			{
				
			 _fullResizableContainer.removeChild(_adminContainer);
			  _adminContainer = null;
			   flags = false;
			}
			  removeUserCards();
				_timeIntervalID = 0;
		}
		public function showUserCards(containerArray:Array,index:int=1):void
		{
		  
		//	trace("index value",index,_spriteArray)
			 _spriteArray[index] = new Sprite();
			 for (var j:int = 0; j <  containerArray.length; j++ )
			      {
						 containerArray[j].x = screenUI.cardgenP.x + j * 120;
						 containerArray[j].y = screenUI.cardgenP.y;
				        _spriteArray[index].addChild(containerArray[j])
			       }
				  
				 screenUI.addChildAt(_spriteArray[index],1); 
			
		}
		public function removeUserCards():void
		{
			
			if(_spriteArray)
			for (var j:int = 1; j < 4; j++ )
			{
				if (_spriteArray[j])
				{
			    screenUI.removeChild(_spriteArray[j]); 
			    _spriteArray[j] = null;
				}
			}
			_spriteArray = new Array();
		}
		private function setCardsOnScreen(str:String):void
		{
		//	trace("acrd ARr", str);
			         var cardArr:Array = str.split(":")
							if (cardArr[0] == "SYSTEM")
							{
								 if (flags && _adminContainer)
								 {
									 removeZeroCard();
									
							         addCards(cardArr)
								 }
								  else
								  {
									 
								    showCard(cardArr)
									_adminContainer.addNewCard(0);
									
								  }
							}
							else
							{
							  ulist.setCardInGame(cardArr);
							     if ((ulist.splitCondition() == 1) && (cardArr[0] == _screenUserName) && (_totatUserAmount > 0))
								 {
			                            _buttonHandler.enableButton(splitB, true); 
								 }    
							  if(ulist.getUserByName(cardArr[0])._doubleEnable)
							   {
								//  trace("kya ho raha h", cardArr[1]);
								   var arr:Array = new Array(cardArr[0], cardArr[6], cardArr[1]);
								     setDoubleBet(Number(cardArr[1])/2, cardArr[6]);
								   if(cardArr[0]==_screenUserName)
								    _buttonHandler.enableAllButtons(false);
							   }
							}
						
		}
		private function setDoubleBet(betAmt:Number,posInd:int):void
		{
			   
				///trace("bet amount",betAmt)
				adjustCoins(betAmt,posInd);
				 showCoinsAgain(posInd);
		}
		
		
		public function dealBClicked():void
		{
			  var amt:String = (totalBetAmount).toString();
			
		      var sendParam:Array=[ServerConstants.DEAL,amt];
		      SfsMain.sfsclient.sendXtMessage("gameExt", ServerConstants.DEAL, sendParam, "str");
		}
		private function dealResponse(res:String):void
		{
			var resArr:Array = res.split(",");
			 if (Number(resArr[1]) >= 1)
			  {
				  
				 for (var j:int = 1; j < 4; j++ )
				 {
				  removeGameEventListener(screenUI["coinPos" +j], MouseEvent.CLICK, addCoinOnScreen);
				 }
				   screenUI["userName" + resArr[1]].text = resArr[0];
				  _buttonHandler.enableButton(dealB, false);
				  _buttonHandler.enableButton(refrashB, false)
				  _buttonHandler.enableButton(betB, false)
				   if (coinflag == false)
				   {
					   showBetScreen();
				   }
				  betOk = true;
					
			  }
			  if (resArr[1] == "-1")
			  { 
				  betOk = false;
				      if(_totatUserAmount>0)
			          _buttonHandler.enableButton(dealB, true);
			        else
			          _buttonHandler.enableButton(dealB, false);
				      _buttonHandler.enableButton(betB, true)
				     _buttonHandler.enableButton(refrashB, true)
			  }
			
		}
		private function setBetRespectivePlayer(_info:Array):void
		{
		
			if (_info[0] != null)
			{
			
				 userIndex = _info[1];
				 // trace("uindex", userIndex);
				 hideCoins1(userIndex);
			     //trace(_coinContainerArr[userIndex],"kdsfklsd")
			     // _coinContainerArr[userIndex] = new Array();
				 adjustCoins(_info[2], _info[1]);
				 showCoinsAgain(_info[1]);
			     screenUI["userName" + _info[1]].text = _info[0] ;
			     _coinSpriteVar = _info[1];
			}
			
		}
		private function removeRespectiveCoins():void
		{
			if (_coinContainerArr)
			{
				for (var j:int = 1; j < _coinContainerArr.length; j++ )
				{
				  if(_coinContainerArr[j])
				  for (var k:int = 0; k < _coinContainerArr[j].length; k++ )
				  {
					 
				      screenUI.removeChild(_coinContainerArr[j][k]);
					 
				  }
				       _coinContainerArr[j] = null;
				}
			}
			if (_splitAmountArr)
			{
				for (j = 1; j < _splitAmountArr.length; j++ )
				{
				  if(_splitAmountArr[j])
				  for (k = 0; k <_splitAmountArr[j].length; k++ )
				  {
					 if(_splitAmountArr[j][k])
					 for (var l:int = 0; l <_splitAmountArr[j][k].length; l++ )
				      {
				      screenUI.removeChild(_splitAmountArr[j][k][l]);
					  }
					 
				  }
				       _splitAmountArr[j] = null;
				}
			}
			_coinSpriteVar = 0;
			_splitAmountArr = new Array();
			_coinContainerArr = new Array();
			   for (var jk:int = 1; jk < 4; jk++ )
				{
					_coinContainerArr[jk] = new Array();
					_splitAmountArr[jk] = new Array();
				}
			
		}
		private function showCard(infoArr:Array):void
		{
			var str:int = infoArr[2];
			var name:String = infoArr[0];
			var weightC:String = "";// infoArr[2]
	        if (int(infoArr[3]) == int(infoArr[4]))
			   weightC = infoArr[3];
		    else
			  weightC = infoArr[3] + "/" + infoArr[4];
			
			var no:int = (str - 1) % 52 + 1;
			
			if (name == "SYSTEM" )
			{
				//_adminSprite = new Sprite();
				_adminContainer = new CardContainer(0);
				_adminContainer.setWeight(weightC);
				_adminContainer.addCards(no.toString());
				_adminContainer.x = screenUI.cardgenP.x;
			    _adminContainer.y = screenUI.cardgenP.y;
				
				_fullResizableContainer.addChildAt(_adminContainer,1);
			
				flags = true;
			}
			
		
		}
		private function  removeZeroCard():void
		{
			//trace("kya hua")
			_adminContainer.removeCard("0");
		}
		private function addCards(cardArr:Array):void
		{
			var str:int = cardArr[2];
		//	var name:String = cardArr[0];
			var weightC:String;
			if (Number(cardArr[3]) == Number(cardArr[4]))
			weightC = cardArr[3];
			else
			weightC = cardArr[3] + "/" + cardArr[4];
			
			var no:int = (str - 1) % 52 + 1;
		 _adminContainer.addNewCard(no);
		 _adminContainer.setWeight(weightC);
		}
		
		
		public function refrashBClicked():void
		{
			totalBetAmount = 0;
			 //addGameEventListener(screenUI["coinPos" + (userIndex+1)], MouseEvent.CLICK, addCoinOnScreen);
			 hideCoins();
			 setEventAgain();
			 
			   enableTimerStateButtons();
			   _buttonHandler.enableButton(refrashB, false);
		}
	
		
		public function setBalance(balanceA:Array):void
		{						 
			screenUI.cashAmount.text ="€ "+Number(balanceA[0]).toFixed(2);
			screenUI.gameAmount.text = "€ "+Number(balanceA[1]).toFixed(2);
			_totatUserAmount = Number(balanceA[0]) + Number(balanceA[1]);
		
			
		}
		
		
		private function setstate(sa:Array,type:int):void
		{
			
			var nameArray:Array = sa[0].split(",");
			var winnigCardArray:Array = sa[1].split(",");
			var totalCardArray:Array = sa[2].split(",");
			var winAmount:String= sa[3];
			if (nameArray[0] != "")
			{
				for (var i:int = 0; i < nameArray.length; i++ )
				{
					ulist.setWinner(nameArray[i],int(winnigCardArray[i]), totalCardArray[i], winAmount, type);
				}				
			}			
		}
		
		
		
		private function parseGameStateString(sstring:String):void
		{
		//	trace("parse")
		//	if(SoundScreen._femaleSounDClicked)
		//	      SoundPlayer.playSound("femaleWelcomeMusic");
		//    else
		//         SoundPlayer.playSound("maleWelcomeMusic");
			var sa:Array = sstring.split(":");
	        _spriteArray = new Array();
			var isUserInGame:Boolean  = false;
			var isAnyUserInGame:Boolean  = false;
			for (var jj:int = 0; jj < sa.length - 1; jj++ )
			{
				if (sa[jj])
				{
				 ulist.setCardInformation(sa[jj])
				 ulist.showUserCards();
				 userIndex = sa[jj].split("@")[1].split(",")[4];
				 trace("sa[jj].split[0]",sa[jj].split("@")[0]);
				 if (sa[jj].split("@")[0]==Main._userName)
				 {
					 isUserInGame =true;
				 }
				 isAnyUserInGame = true;
				 // screenUI["userName" + sa[jj].split("@")[1].split(",")[4]].text = sa[jj].split("@")[0];
			     //if ((ulist.getUserByName(sa[jj].split("@")[0])._utype == 1) && (Number(sa[jj].split("@")[1].split(",")[0]) > 0))
						var arr:Array=new Array(sa[jj].split("@")[0],userIndex,sa[jj].split("@")[1].split(",")[0],sa[jj].split("@")[1].split(",")[5])
						setBetRespectivePlayer(arr);
						 
				//  trace("userindex",userIndex,jj);
				
				}
				
				
			}
			if (!isUserInGame && isAnyUserInGame)
			{
				userIndex++;
				//trace("user index +++++++",userIndex,"nponbv",noOfUserInGame);
			}
			userClickEventForBet();
		
			 if (ulist && _gameState == 0)
			  {
			   
			    if (ulist.getUserByName(_screenUserName)._utype == 2 )
				{
			       _buttonHandler.enableAllButtons(false );
				   
				}
				if (ulist.getUserByName(_screenUserName)._utype == 1 )
				{
			        enableGameStateButtons();
				}
			
				
			  }
			  if (ulist && _gameState == 1)
			  {
			   
			       if (ulist.getUserByName(_screenUserName)._utype == 2 )
				      {
			         _buttonHandler.enableAllButtons(false );
				     if(_totatUserAmount>0)
				     _buttonHandler.enableButton(betB,true)
			         }
				    if (ulist.getUserByName(_screenUserName)._utype == 1 )
				     {
						 betOk = true;
			           _buttonHandler.enableAllButtons(false );
					    for (var j:int = 1; j < 4; j++ )
				             {
				               removeGameEventListener(screenUI["coinPos" +j], MouseEvent.CLICK, addCoinOnScreen);
				             }
				     }
				
				
			  }
			   
			if (sa[sa.length-1])
			{
				//trace(sa[sa.length - 1], "ky hahhha")
				// var str:String = sa[sa.length - 1].replace("@", ":");
				// var str2:String = str.replace(",", ":");
				// trace(str2,"hajskajsdd")
				 var weightC:String = "";
				_adminContainer = new CardContainer(0);
				
				var info:Array = sa[sa.length-1].split("@");
				var no:Array = info[1].split(",");
				//trace(no,"ky hahhha")
				if (no[3])
				{
					//trace(no[3].split("-")[0])
				   if(no[3].split("-")[1]==null)
				      no[3] +="-0";
				
					  
					  _adminContainer.addCards(no[3]); 
					  
				  if (int(no[1]) == int(no[2]))
			         weightC = no[1];
		            else
			        weightC = no[1] + "/" + no[2];
				 _adminContainer .setWeight(weightC);
				 _adminContainer.x = screenUI.cardgenP.x;
			    _adminContainer.y = screenUI.cardgenP.y;
				//_fullResizableContainer(_adminContainer);
				_fullResizableContainer.addChildAt(_adminContainer,1);
				//screenUI.addChild(_adminContainer);
				if(_gameState==0)
			        flags = true;
				}
				
			}
			
		setForResize();
		
		}
		private function updatePlayerList(str:String):void
		{
			PlayerInGameArray = new Array();
			PlayerInGameArray = str.split(",");
		
			 makeList();
			
		}
		private function DisplayPlayerList():void
		{
			_totalUserArray = new Array();
			_userTypeArray = new Array();
			var PlayerInGame:Array = new Array();
		
			for (var s:int = 0; s < PlayerInGameArray.length;s++ )
			{
				 PlayerInGame[s] = PlayerInGameArray[s];
			}
			//var PlayerInGame:Array = PlayerInGameArray;
			
			if (PlayerInGameArray.length>=1)
			{
				
				for (var i:int = 0; i < onLineUserList.length; i++)
				{
					var typ:int = getUserType(onLineUserList[i]);
					//trace("TypeError",typ)
					if (typ == 1)
					{
						typ = 10;
					}

					var k:int = PlayerInGame.indexOf(onLineUserList[i]); 
					if (k < 0)
					{
						typ += 2;
					    var obj:Object = { name:onLineUserList[i], type:typ.toString()};
						_totalUserArray.push(obj);
					   
					}
					else
					{
						typ += 1;
						 var obj1:Object = { name:onLineUserList[i], type:typ.toString() };
						_totalUserArray.push(obj1);
						PlayerInGame.splice(k,1);
					}
				
				}
				
			}
			else
			{
				for (var l:int = 0; l < onLineUserList.length; l++)
				{
					var typ1:int = getUserType(onLineUserList[i]);
					if (typ1 == 1)
					{
						typ1 = 10;
					}
					if (onLineUserList[l] != "")
					{
						typ1 += 2;
					  var obj2:Object = { name:onLineUserList[i], type:typ1.toString() };
						_totalUserArray.push(obj2);
					}
					
				}
				
			}
			
		   for (var j:int = 0; j < PlayerInGame.length; j++ )
			{
				
				if (PlayerInGame[j] != "")
				{
					  var obj3:Object = { name:PlayerInGame[j], type:"3" };
						_totalUserArray.push(obj3);
			
				}
			}
		
			if (_totalUserArray[_totalUserArray.length - 1] == "")
			{
				_totalUserArray.splice([_totalUserArray.length - 1],1)
			}
			ulist.addUsers(_totalUserArray);				
		}
				
		private function setRoomPropertiesFromVariables(roomVars:Array):void
		{
			
			for (var varName:String in roomVars)
			{
				
				
			   if ( varName == "mnb")
				{
					trace ( "mimnmum players are ", roomVars[varName]);
			      _minBetAmount = Number(_joinedRoom.getVariable(varName));
				   totalBetAmount = _minBetAmount;
				//  trace ( "mimnmum bet are ", _minBetAmount, totalBetAmount );
				  if(_coinHolder)
				  _coinHolder.setSelectedCoin(totalBetAmount);
				}
				else if ( varName == "mxb")
				{
					 _maxBetAmount = Number(_joinedRoom.getVariable(varName));
					 trace ( "max bets are ", _maxBetAmount );
				}
				else if ( varName == "rs")
				{
					
					var intStatus:int = int (_joinedRoom.getVariable(varName));
					
					_gameState = intStatus;
					
					if (intStatus == 1)
					{
					
						showTimerStateScreens();	
					}
					else
					{
						showGameStateScreens();		
						
					}
					
					
				}
			
				
			}		
			if (currentTargetedChat)
				stage.focus = currentTargetedChat;
		}
		
		
		
		override public function onRoomVariableUpdate(evt:SFSEvent):void
		{
			
			var changedVars:Array = evt.params.changedVars;
		
			setRoomPropertiesFromVariables(changedVars);
		}
	
		

	    override public function onUserEnterRoom(evt:SFSEvent):void
		{
			var i:int = 0;
			if(int(evt.params.user.getVariable("Utype"))==1)
			{
				i=10
			}	
			//trace("in userEnterRoom function is called",evt.params.user.getName());
			ulist.setuserInGame(evt.params.user.getName(), i);
			 if (currentTargetedChat)
			{
			    stage.focus = currentTargetedChat;	
			}
			//makeList();
		//	trace("on user enter room called........................................",evt.params.userName)
							
		}
		override public function onUserLeaveRoomHandler(evt:SFSEvent):void
		{
			
			
		     ulist.setuserInGame(evt.params.userName, 3);
			  if (currentTargetedChat)
			  {
			   stage.focus = currentTargetedChat;	
			  }
		
		}
		private  function makeList():void
		{
			onLineUserList = new Array();
		     var users:Array = _joinedRoom.getUserList();
			// _nameIdMap = new Object();
			 
			for (var u:String in users)
			{				
				onLineUserList.push(users[u].getName());
				//_nameIdMap[users[u].getName()] = users[u].getId();
			}
			DisplayPlayerList();
			if (currentTargetedChat)
				 stage.focus = currentTargetedChat;
		}
		
		public function getUserType(name:String):int
		{
			var user:User = _joinedRoom.getUser(name);
			//trace("user name",name);
			if (user)
			{
				//trace("tracedin ", int(user.getVariable("Utype")), user.getName(), "tracedin ");
				var i:int = int(user.getVariable("Utype"));
			//	trace("user in game room ",i, user.getName(), "tracedin ");
				return i;
			}
			else
			{
				//trace("user no in game room");
			    return 0;	
			}
		}
		
		public function getIdFromUserName(name:String):int
		{
			var user:User = _joinedRoom.getUser(name);
			if (user)
				return user.getId();
			return -1;	
			
		}
	
		private function setDealVisible():void
		{
			//coinflag = true;
			
			if (_gameState == 1)
			{
			 if(_totatUserAmount>0)
			 _buttonHandler.enableButton(dealB, true);
			 else
			 _buttonHandler.enableButton(dealB, false);
			 _buttonHandler.enableButton(refrashB, true)
			 
			}
		}
		
		private function enableTimerStateButtons():void
		{	
			
			   _buttonHandler.enableAllButtons(false);
			
			 if (_totatUserAmount > 0)
			 {
				_buttonHandler.enableButton(betB, true);
			   
			 }
		}
		
		private function enableGameStateButtons():void
		{			
			
			
			  _buttonHandler.enableButton(refrashB, false)
			  _buttonHandler.enableButton(dealB, false);
		      _buttonHandler.enableButton(hitB, true); 
		      _buttonHandler.enableButton(standB, true); 
			  if(_totatUserAmount>0)
			  _buttonHandler.enableButton(doubleB, true); 
			 // _buttonHandler.enableButton(splitB, true); 
			
		}
		private function showGameStateScreens():void
		{
			
			  if (ulist)
			  {
			   
			    if (ulist.getUserByName(_screenUserName)._utype == 2)
				   {
			       _buttonHandler.enableAllButtons(false );
				    hideCoins();
					       for (var j:int = 1; j < 4; j++ )
				             {
				               removeGameEventListener(screenUI["coinPos" +j], MouseEvent.CLICK, addCoinOnScreen);
				             }
				   }
				if (ulist.getUserByName(_screenUserName)._utype==1 && ulist.getUserByName(_screenUserName)._userTurn==1)
			          enableGameStateButtons();
				
				
			  }
					
			setGlow();
			
				          
			
		
		}
		
		private function showTimerStateScreens():void
		{
			
			
			 screenUI.timerTxt.text = "Wait";
			 screenUI.currentUser.text = "Wait";
			 _timeIntervalID = setTimeout(moveCards,400);
			 userIndex = 0;
			  if (_adminContainer)
			    _adminContainer.sendBackCard();
			  if (ulist)
				  ulist.sendBack();
			 setGlow();
			
			removeRespectiveCoins();
			
			 userClickEventForBet();
			
			
			
			if (_winSym)
			    {
	              for (var jj:int = 0; jj < _winSym.length; jj++)
					{
					    if(_winSym[jj])
			            screenUI.removeChild(_winSym[jj]);
			               // _winSym[jj] = null;
					}
					_winSym = new Array();
		      	}
			 enableTimerStateButtons(); 
			 removeWinCoin();
			 
			 for (var j:int = 1; j <= 3; j++ )
			 {
				 screenUI["userName" + j].text = "EMPTY";
			 }
		}
		
		
		public function  showBetScreen():void
		{
			if (coinflag)
			{
			   _coinHolder.visible = true;
			}
			else
			{
				_coinHolder.visible = false;
			}
			coinflag = !coinflag;
			
		}
		
		public function sendGetStateRequest():void
		{
			var sendParam:Array=["12"];
			SfsMain.sfsclient.sendXtMessage("gameExt", "12",sendParam,"str");
		}
	
		
		override public function onPublicMessageHandler(evt:SFSEvent):void
		{
			var userVar:User = evt.params.sender;
			var uType:int = int(userVar.getVariable("Utype"));
			var isUserAdmin:Boolean = false;
			if (uType == 1)
				isUserAdmin = true;
				if (IgnoreUserManager.isUserBlocked(userVar.getName()))
				return;
	//	trace (" Is user admin ", isUserAdmin,MainLobbyScreen._UserType);	
			_publicChatScreen.addChatMessage(evt.params.sender.getName() + " : " + evt.params.message,isUserAdmin);
		}
		
		override public function onPrivateMessageHandler(evt:SFSEvent):void
		{
			//trace("User " + evt.params.sender.getName() + " sent the following private message: " + evt.params.message);
			if (evt.params.sender.getName() == Main._userName)
		    return;
			PrivateChatManager._pcManager.addChatMessage(evt.params.sender.getName(), evt.params.message);
		
		}
		
		public function getPrivateChatPos():Point
		{
			var rPoint:Point = new Point(screenUI.pcStartP.x, screenUI.pcStartP.y);
			if (stage)
			{				
				var stageWidth:Number = stage.stageWidth;
				var stageHeight:Number = stage.stageHeight;
			
				
				var hsf:Number = stageWidth / origWidth;
				var vsf:Number = stageHeight / origHeight;
				rPoint.x *= hsf;
				rPoint.y *= vsf;
			}
			return rPoint;
		}		
	}
}