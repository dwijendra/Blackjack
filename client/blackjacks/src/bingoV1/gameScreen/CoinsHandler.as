package bingoV1.gameScreen 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import gameCommon.screens.BaseScreen;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author ashish
	 */
	public class CoinsHandler extends BaseScreen
	{
		private var _coinsAmount:Array;
		private var _coinsHolder:Sprite;
		private var _coinsArr:Array;
		public var _selectedCoinAmt:Number;
		public var _selectedCoin:* = null;
		
		private var _coinPos:Array = ["coinPos1", "coinPos2", "coinPos3","coinPos4"];
		private var _coinSelectedArray:Array;
		private var _screenUi:*;
		private var _arrpos:Array;
		private var _coinTillNow:Array;
		private var _totalSelectedAmt:Array;
		public static var _coinFlag:Boolean = false;
		private var _selectFun:Function;
		private var _bgs:BingoGameScreen;
		
		
		public function CoinsHandler(coins:String,bgs:BingoGameScreen) 
		{ 
			_bgs = bgs;
			screenUI = new Resources.betScreen();
			
			addChild(screenUI);
			//_selectedCoinAmt = BingoGameScreen._minBetAmount;
			_coinsAmount = coins.split("@");
		 
			showCoins();
			addGameEventListener(screenUI.closeB, MouseEvent.CLICK, closeScreen);
			setCoinEvent();
			
		}
		
		private function closeScreen(evt:MouseEvent):void
		{
			_bgs.showBetScreen();
		}
		public function setSelectedCoin(rs:Number):void
		{
			trace("hialla"+rs)
			_selectedCoinAmt = rs;
			if (_coinsArr)
			{
			   for (var i:int = 0; i < _coinsArr.length; i++ )
			    {
	    		  if (_selectedCoinAmt == _coinsArr[i]._coinsAmount)
				   {
				    _coinsArr[i].goto(2);
				    _selectedCoin = _coinsArr[i];
			    	}
				  else
				   _coinsArr[i].goto(1);
		           }
			}
			  
		}
		private function setCoinEvent():void
		{
			for (var j:int = 0; j < _coinsArr.length; j++ )
			{
			    _coinsArr[j].buttonMode = true;
				addGameEventListener(_coinsArr[j], MouseEvent.CLICK, coinSelected);
			}
		}
		
		public function removeCoinEvent():void
		{
			for (var j:int = 0; j < _coinPos.length; j++ )
			{
			      _coinsArr[j].buttonMode = true;
				  removeGameEventListener(_coinsArr[j], MouseEvent.CLICK, coinSelected);
				 
			}
			
		}
		
		
		
	
	    private function check():void
		{
			
			for (var j:int = 0; j < _coinSelectedArray.length; j++ )
		    {
				var add:int=0
				    for (var i:int = 0; i < _coinSelectedArray[j].length; i++ )
		            {
						add += int(_coinSelectedArray[j][i]);
					}
				
			  if (add > _selectedCoinAmt && _coinsAmount.indexOf(add.toString()))
			  {
					//trace(_coinSelectedArray[j],"kya phele");
					refresh(j);
					//trace(_coinSelectedArray[j],"kya bade");
					for (var i1:int = 0; i1 < _coinTillNow[j].length; i1++ )
		            {
						screenUI.removeChild(_coinTillNow[j][i1])
						
					}
					 var pt:Point = new Point(screenUI[_coinPos[j]].x, screenUI[_coinPos[j]].y);
				           _arrpos[j] = pt;
		      
					 _coinTillNow[j] = new Array();
					for ( i =_coinSelectedArray[j].length-1; i >= 0 ; i-- )
		            {
						
					     if (int(_coinSelectedArray[j][i]) != 0)
						 {
					      
			            //  screenUI.addChild(coin);
				        
						 }
					}
			  }
			}
		}
		private function refresh(k:int):void
		{
			
		    var _total:int = 0;
			var index:Array = new Array ();
			for (var i:int = 0; i < _coinsAmount.length; i++ )
				    {
					 index[i] = 0;
					  var ss:int = 0;
			             for (var j:int = 0; j < _coinSelectedArray[k].length; j++ )
			                  {
					        
				                 if (_coinSelectedArray[k][j] == _coinsAmount[i])
				                   ss++;
				               } 
							    index[i] = ss;
								
			           	_total += index[i] * _coinsAmount[i]
						index[i] = 0;
			         }
			
			_totalSelectedAmt[k] = _total;
			
			setAgainCoin(index,k);
			
		}
		private function setAgainCoin(ind:Array,k:int):void
		{
			_coinSelectedArray[k] = new Array();
			for (var kk:int = 0; kk < ind.length; kk++)
			{
				for (var j:int = 0; j < ind[kk];j++)
				{
					_coinSelectedArray[k].push(_coinsAmount[kk]);
				}
			}
			
		}
		
		private function showCoins():void
		{
			_coinsHolder = new Sprite();
			_coinsArr = new Array();
			var currentX:Number = 0;
			for (var i:int = 0; i < _coinsAmount.length; i++ )
			{
				var coin:Coins = new Coins(_coinsAmount[i], this)
				coin.y = currentX;
				currentX += Coins._coinHeight;
				_coinsHolder.addChild(coin);
			     _coinsArr.push(coin);
			}	
			_coinsHolder.x = screenUI.betP.x;
			_coinsHolder.y = screenUI.betP.y;
			screenUI.addChild(_coinsHolder);
		}
		
		public function coinSelected(evt:MouseEvent):void
		{
			
			
			 var obj:*= evt.currentTarget;
			 
			for (var i:int = 0; i < _coinsAmount.length; i++ )
			{
	    		if (obj == _coinsArr[i])
				{
				 _coinsArr[i].goto(2);
				 _selectedCoinAmt = _coinsArr[i]._coinsAmount;
				 _selectedCoin = _coinsArr[i];
				}
				else
				 _coinsArr[i].goto(1);
			}
			_bgs.setEventAgain();
		}
	
		
	}

}