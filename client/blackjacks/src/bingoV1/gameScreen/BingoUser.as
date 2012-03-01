package bingoV1.gameScreen 
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import gameCommon.screens.BaseScreen;
	import bingoV1.lobbyScreen.MainLobbyScreen;
	
	/**
	 * ...
	 * @author vipul
	 */
	public class BingoUser extends BaseScreen
	{
		//public var _userId:int;
		public var _userName:String;
		public var _utype:int;
		public var _userHeight:Number;
		public var _userWidth:Number = 166.4;
		public var _isBlocked:Boolean;
		static private var _userClickedScr:UserClickedScreen;
		private var _blockSymbol:*;
		private var _isAdmin:Boolean = false;
		private var _containerArray:Array;
		private var _cardString:String;
		//private var _screenUi:*;
		private var _coinPos:Array = ["coinPos1", "coinPos2", "coinPos3"];
		public  var _splitCondition:int = 0;
		private var _bgs:BingoGameScreen;
		private var _index:int;
		public var _doubleEnable:Boolean = false;
		public var _userTurn:int;
		public var _splitEnable:Boolean = false;
	
		public function BingoUser(userobj:Object,bgs:BingoGameScreen) 
		{
			//_userId = userId;
			_userName = userobj.name;
			_utype = int(userobj.type);
			_bgs = bgs;
			//_cardString = userobj.card;
			
				setState(_utype);
			_isBlocked = false;
			
		}
		public function setState(state:int):void
		{
			if (state>=10)
			{
				state = state-10;
				_isAdmin = true;
			}
			if (screenUI != null)
			{
			     removeChild(screenUI);
				 screenUI = null;
			}
			if (state == 1)
			{
			   screenUI = new Resources.OnInGame();
			   _userWidth = 135;
			    _userHeight = 25;
				addUserClickedScreen();
			}
			if (state == 2)
			{
			   screenUI = new Resources.OnNotInGame;
			    _userWidth = 135;
			    _userHeight = 25;
				addUserClickedScreen();
				
			}
			if (state == 3)
			{
			   screenUI = new Resources.OffInGame();
			    _userWidth = 135;
			   _userHeight = 25;
			   removeUserClickedScreen();
			   
			}
			if (state == 4)
			{
			   //screenUI = new Resources.PWinner();
			     screenUI = GetDisplayObject.getSymbol("PWinner");
			    _userWidth = 172;
			  _userHeight = 60;
			  addUserClickedScreen();
			}
			if (state == 5)
			{
			   // screenUI = new Resources.BWinner();
			     screenUI = GetDisplayObject.getSymbol("BWinner");
				 _userWidth = 172;
			     _userHeight = 60;
			   addUserClickedScreen();
			}
			screenUI.width = _userWidth;
			screenUI.height = _userHeight;
			addChild(screenUI);
			//trace("this is the user name ",_userName)
			if (_isAdmin)				
				screenUI.userName.htmlText = "<font color='#CC0099'>" + _userName +"</font>";
			else
				screenUI.userName.text = _userName;
			    screenUI.userName.mouseEnabled = false;
			_utype = state;
					
		}
		
		override public function initialize():void
		{
			super.initialize();
			//addUserClickedScreen();
		
			//adding private chat option screen

		}
		
		public function get weight():int
		{
			var returnVal:int = 0;
			if (_utype == 4 || _utype == 5)
			{
				returnVal += _utype * 100;
			}
			return returnVal;
		}
		
		private function addUserClickedScreen():void
		{
			
			if (_userName != Main._userName)
			{
				addGameEventListener(this, MouseEvent.CLICK, userClicked);
				buttonMode = true;
			}
			if (_userName == Main._userName)
			{
			  addGameEventListener(this, MouseEvent.CLICK, showBingoUserCrads);
			}
		
		}
		
		private function removeUserClickedScreen():void
		{
			removeGameEventListener(this, MouseEvent.CLICK, userClicked);
			buttonMode = false;
		}
		
		public function userClicked(evt:MouseEvent):void
		{
			//trace ("User Clicked");
			if (_userClickedScr == null)
				_userClickedScr = new UserClickedScreen(_userName);
			 this.parent.parent.parent.addChild(_userClickedScr);	
			//if (_userClickedScr)
			{
				//_userClickedScr.setName(_userName);
				_userClickedScr.showUI(this);
				_userClickedScr.x = this.parent.x + this.x; //- _userClickedScr.width;
				_userClickedScr.y =  this.parent.y + this.y;				
			}		
		}
		
		public function setName(noOfWinningCard:int,noOfTotalCard:String,WinningAmount:String):void
		{
			screenUI.winningCards.text= noOfWinningCard.toString();
			screenUI.totalCards.text = noOfTotalCard;
		    screenUI.winningAmount.text = ((Number(WinningAmount)*noOfWinningCard).toFixed(2)).toString();
			
		}
		public function setCardCointainer(str:String):void
		{
		         var weightC:String = "";
			if(BingoGameScreen._gameState==0)	 
			  _containerArray = new Array();
			var info:Array = str.split("@");
		  _splitCondition = 0;
			for (var j:int = 1; j < info.length; j++ )
			{
			
				var no:Array = info[j].split(",");
				var betAmt:int = no[0];
			    _index = no[4];
				if (no[3])
				{
			
		            if (int(no[1]) == int(no[2]))
			           weightC = no[1];
		            else
			           weightC = no[1] + "/" + no[2];
					var cont:CardContainer = new CardContainer(_index);
				    cont.addCards(no[3]);
			
					cont.setWeight(weightC);
				    _containerArray.push(cont);
				  _splitCondition= cont.splitCondition();
				}
			
			}
		
			
		}
		public function sendBack():void 
		{
			if (_containerArray)
			{
			for (var j:int = 0; j < _containerArray.length; j++ )
			{
				_containerArray[j].sendBackCard();
			}
			}
		}
		
		public function setCardInGame(arry:Array):void
		{
			//trace("arrr",arry)
			_splitCondition = 0;
			var str:int = arry[2];
			var name:String = arry[0];
			var weightC:String = "";// infoArr[2]
	        if (int(arry[3]) == int(arry[4]))
			   weightC = arry[3];
		    else
			  weightC = arry[3] + "/" + arry[4];
			  var no:int = (str - 1) % 52 + 1;
			  var index:int = int(arry[5]);
			  _index = int(arry[6]);
			//  trace(_index,"index");
			  //  trace(_containerArray[index],"container aar ynkfkljdfkljgjsdfk",index)
			  if (_containerArray )
			  {
				 
				_containerArray[index].addNewCard(no);
				_containerArray[index].setWeight(weightC);
				 
			  }
			  else
			  { 
				  _containerArray = new Array();
				   var cont:CardContainer = new CardContainer(_index);
				   cont.addCards(no.toString());
				   cont.setWeight(weightC);
				   _containerArray[index]=cont;
				  
			  }
			   _splitCondition = _containerArray[index].splitCondition();
			
		}
		public function setDouble():void
		{
		    _doubleEnable = true;	
		}
		public function splitFun(str:String):void
		{
			   removeCards();
			   _splitEnable = true;
			  _containerArray = new Array();
			var info:Array = str.split("@");
		
			for (var j:int = 1; j < info.length; j++ )
			{
				var no:Array = info[j].split(",");
				var betAmt:int = no[0];
				var arr:Array = no[3].split("-");
			   for (var j1:int = 0; j1 < arr.length; j1++ )
			     {
				// trace("blackjack",no[4],no[5]);
				   var cont:CardContainer = new CardContainer(no[4]);
				   cont.addCards(arr[j1]);
				 
				   cont.setWeight(no[1]);
				  _containerArray.push(cont);
				
				 
			   }
			
			}
		//	trace("_container", _containerArray);
			showBingoUserCrads();

		}
		
		public function showBingoUserCrads(evt:MouseEvent=null):void
		{
			
			if (_containerArray)
			{
				_bgs.showUserCards(_containerArray,_index);
			}
			
		}
		public function removeCards():void
		{
					_bgs.removeUserCards();
		}
		
		public function setUserBlocked(block:Boolean):void
		{
			//addGameEventListener(this, MouseEvent.CLICK, userClicked);
			//buttonMode = true;
			_isBlocked = block;
			if (_isBlocked )
			{
				
			     screenUI.userName.htmlText = "<font color='#ff0000'>" + _userName +"</font>";
				if (_blockSymbol)
					return;
				  _blockSymbol = new Resources.userBlockSymbol();
				//addChild(_blockSymbol);
				//var bs:* = new Resources.userBlockSymbol();			
				//addChild(bs);
				//trace ("Adding blocked symbol");
			}
			else
			{
				if (_blockSymbol)
				{
			    if (_isAdmin)				
				      screenUI.userName.htmlText = "<font color='#CC0099'>" + _userName +"</font>";
				else
			        screenUI.userName.htmlText = _userName;
					//removeChild(_blockSymbol);
					_blockSymbol = null;
				}
			}
		}
	}
}