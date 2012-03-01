package bingoV1.gameScreen 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import gameCommon.screens.BaseScreen;
	import gameCommon.customUI.ScrollPane;
	
	/**
	 * ...
	 * @author vipul
	 */
	public class UserList extends BaseScreen
	{
		private var _userListArray:Array;
		private var _userHolder:Sprite;
		private var _userListMask:Sprite;
		private var _userInfoArray:Array;
		private var _userTypeArray:Array;
		private	var currentY:int;
		private var tempY:int;
		//private var flag:int = 0;
		private var _sliderPos:Point;
		private var _sp:ScrollPane;
		
		public static const ulistH:Number = 225;
		public static const ulistW:Number = 190;
	    private var _bgs:BingoGameScreen; 
	//	public static var _currentPlayer:BingoUser;
		
		
		public function UserList(sliderX:Number,sliderY:Number,bgs:BingoGameScreen) 
		{
			_sliderPos = new Point(sliderX, sliderY);
			_userInfoArray = new Array();
			//_screenUi = screen;
		     _bgs = bgs;
			//_userInfoArray = userInfoArray;
			//_userTypeArray = utype;
			//addUsers();
		}
		override public function initialize():void
		{
			super.initialize();
			screenUI = new Resources.userSlider();
			screenUI.x = _sliderPos.x;
			screenUI.y = _sliderPos.y;
			
			//drawMask();
			 
			_userHolder = new Sprite();
			addChild(_userHolder);
			_sp = new ScrollPane(195, 225, _userHolder, screenUI.bidSlider);
			addChild(_sp);
			addChild(screenUI);
			
			//setuserSlider();
		}
		
		public function resizeScreen(hsf:Number, vsf:Number):void
		{
			_sp._visibleHeight = ulistH * vsf;
			screenUI.bidSlider.scaleY = vsf;
			width = ulistW * hsf;
			_sp.setMask();
			
		}
		
		
		public function addUsers(userInfoArray:Array):void
		{
			_userListArray = new Array();
			userInfoArray.sortOn("name");
			for (var i:int = 0; i < userInfoArray.length;++i )
			{
				var user:BingoUser = new BingoUser(userInfoArray[i],_bgs);
				user.setUserBlocked(IgnoreUserManager.isUserBlocked(user._userName));
				_userListArray.push(user);
				
            }
			makeUserList(_userListArray);
			//trace("in iser list player",_userListArray);
			
			 
		}
		public function getUserByName(name:String):BingoUser
		{
			var bu:BingoUser;
			for (var j:int = 0; j < _userListArray.length; j++)
			{
				if (name == _userListArray[j]._userName)
				{
					bu = _userListArray[j];
					break;
				}
			}
			return bu;			
		}
		
		public function makeUserList(userArray:Array):void
		{
		
			userArray.sort(sortUsers);
			_userHolder = new Sprite();
			//_sp.change
			 currentY = 0;
			 
			 for (var us:int = 0; us<userArray.length; us++ )
			 {
				// trace("user is ............",userArray[us])
				 _userHolder.addChild(userArray[us]);
				userArray[us].y = currentY;
				currentY += userArray[us]._userHeight;
			//	trace (currentY, " Current Y");
			 }
			  //addChild(_userHolder);
			//_userHolder.mask = _userListMask;
			_userListArray = new Array();
			_userListArray = userArray;
			_sp.changeUI(_userHolder);
		//	_sp.setFullScroll();
			stage.invalidate();
			
		}
		
		private function sortUsers(user1:BingoUser,user2:BingoUser):int
		{
			if (user1.weight > user2.weight)
			{
				return -1;
			}
			else if (user1.weight == user2.weight)
			{
				return user1._userName.localeCompare(user2._userName);
			}
			return 1;
		}
	
		public function  setWinner(name:String,noOfWinningCard:int,noOfTotalCard:String,WinningAmount:String,state:int):void
		{
			//trace("'''''''''''''''''''''",name)
			var k:int = 0;
			for (var i:int = 0; i < _userListArray.length; i++)
			{
				
				/*if (k == 1)
				{
					_userListArray[i].y = currentY;
					currentY += _userListArray[i]._userHeight;
					
				}*/
				if (_userListArray[i]._userName == name)
				{
					_userListArray[i].setState(state);
					_userListArray[i].setName(noOfWinningCard, noOfTotalCard,WinningAmount);
					//_userListArray[i].y += 10;
				//	currentY = _userListArray[i].y + _userListArray[i]._userHeight;
					//k = 1;
				}
				
				
				
			}
			makeUserList(_userListArray);
		//	_sp.setFullScroll();
					
		}
		public function setCardInGame(arr:Array):void 
		{
			for (var i:int = 0; i < _userListArray.length; i++)
			{
				///trace(_userListArray[i]._userName)
			    if (_userListArray[i]._userName == arr[0])
				{
					_userListArray[i].setCardInGame(arr);
				}
				  
				
			}
			
			showUserCards();
		}
		
		public function setSplitFun(str:String):void 
		{
			var playerName:String = str.split("@")[0];
			for (var i:int = 0; i < _userListArray.length; i++)
			{
				//trace(_userListArray[i]._userName)
			    if (_userListArray[i]._userName == playerName)
				{
				
					_userListArray[i].splitFun(str);
				}
				 
				
			}
		   	
		}
		public function splitCondition():int
		{
			var no:int=0;
			for (var j:int = 0; j <  _userListArray.length; j++ )
			{
				 if (_userListArray[j]._userName == Main._userName)
				   no = _userListArray[j]._splitCondition;
				 
			}
			return no;
		}
		public function sendBack():void
		{
			for (var j:int = 0; j <  _userListArray.length; j++ )
			{
				
				 _userListArray[j].sendBack();
			}
		}
		public function setCardInformation(playerCardInfo:String):void
		{
			var playerName:String = playerCardInfo.split("@")[0];
		   // trace("player name",playerName,_userListArray)		
		
			for (var i:int = 0; i < _userListArray.length; i++)
			{
				//trace(_userListArray[i]._userName)
			    if (_userListArray[i]._userName == playerName)
				{
					//trace(playerName,i)
					_userListArray[i].setCardCointainer(playerCardInfo);
				}
				 
				
			}
			
			showUserCards();
			
		}
		public function setDoubleCond(str:String):void
		{
			var arr:Array = str.split(":");
		
	         for (var  i:int=0; i < _userListArray.length; i++)
			    {
					 if (_userListArray[i]._userName == arr[0])
				     {
				        _userListArray[i].setDouble();
					 }
		     	}
		   
			
		}
		public function showUserCards():void
		{
			if (_userListArray)
		   {
			for (var  i:int=0; i < _userListArray.length; i++)
			{
				
					
				      _userListArray[i].showBingoUserCrads();
			}
		   }
		}
		public function setuserInGame(Name:String,i:int):void
		{
			//trace("setuserInGame in main block",name,i);
			var flag:int = 0;
			for (var j:int = 0; j < _userListArray.length; j++)
			{
				if (_userListArray[j]._userName == Name && i==1)
				{
					
					//tempY= _userListArray[j].y;
					_userListArray[j].setState(1);
					//_userListArray[j].y = tempY;
					break;
					
				}
				if (_userListArray[j]._userName == Name && i == 3)
				{
					if (_userListArray[j]._utype == 1)
					{
						//tempY= _userListArray[j].y;
					   _userListArray[j].setState(3);
					  // _userListArray[j].y = tempY;
					   break;
						
					}
					
				
						if (_userListArray[j]._utype==4 ||_userListArray[j]._utype==5)
					
								{
										//trace("good");
										
								}
						if(_userListArray[j]._utype==2)
							{
								removeUserFromList(Name);
								//trace("remove list is called");
						
							}
					break;		
					
					
				}
				if ( i == 0)
				{
					
					if (_userListArray[j]._userName == Name)
					{
						if (_userListArray[j]._utype ==3)
						{
							//tempY= _userListArray[j].y;
					       _userListArray[j].setState(1);
					     //_userListArray[j].y = tempY;
						// trace("setuserInGame  in for loop++++++++++++",name,i);
						flag = 10;
								break;
							
						}
						else
						{
							flag = 10;
						}
				
						
					}
				
					
				}
				makeUserList(_userListArray);
				//currentY = _userListArray[j].y;
				
				
			}
			if ((flag != 10) &&(i==0||i==10))
			{
				//trace("setuserInGame  in last condition++++++++++++",name,i);
				i = i + 2;
				  var obj:Object = { name:Name, type:String(i)};
				var user:BingoUser = new BingoUser(obj,_bgs);
				user.setUserBlocked(IgnoreUserManager.isUserBlocked(Name));
				_userListArray.push(user);
				_userListArray.sortOn("weight");
				makeUserList(_userListArray);
				  flag = 0;
			}
			stage.invalidate();
			//trace("_____________________________________________________________________________________________________________________");
			
		}
		
	
		public function removeUserFromList(userName:String):void
		{
			var k:int = 0;
			currentY = 0;
			for (var i:int = 0; i < _userListArray.length;++i )
			{
				if (_userListArray[i]._userName== userName &&k==0)
				{
					_userHolder.removeChild(_userListArray[i]);
					currentY = _userListArray[i].y;
					
					 k = i + 1;
					 break;
				}
				
			}
			if (k != 0)
			{
				var j:int;
				for (j=k-1; j < _userListArray.length;++j )
				{
				
				
				
					//_userHolder.removeChild(_userListArray[i]);
					//_userHolder.addChild(_userListArray[i]);
					_userListArray[j].y = currentY-_userListArray[j].height;
					currentY += _userListArray[j].height;
				
				}
				currentY-=_userListArray[j-1].height;
			}
			
			_userListArray.splice((k - 1), 1);
			//_sp.setFullScroll();
			stage.invalidate();
			
		}
		
		/*private function drawMask():void
		{
			_userListMask = new Sprite();
            addChild(_userListMask);
           _userListMask.graphics.lineStyle(3,0x00ff00);
           _userListMask.graphics.beginFill(0x0000FF);
           _userListMask.graphics.drawRect(0,0,168,250);
			_userListMask.visible = false;
		}*/
	}

}