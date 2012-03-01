package bingoV1.gameScreen 
{
	import flash.display.Sprite;
	import gameCommon.screens.BaseNetworkScreen;
	import bingoV1.GameConstants;
	import flash.events.*;
	import it.gotoandplay.smartfoxserver.SFSEvent;
	import flash.display.Graphics;
	import multiLanguage.ResizeableContainer;
	import multiLanguage.LanguageXMLLoader;
	/**
	 * ...
	 * @author vipul
	 */
	public class GamePlayScreen extends BaseNetworkScreen
	{
	    private var _cardNumberArray:Array;
		private var _card:BingoCard;
		private var _cardArray:Array;
		private var _patternArray:Array;
		private var _comingNumber:String;
		private var _ballArray:Array;
		private var _currentBall:Ball;
		private var _lastPosX:Number;
		private var _movingText:RunningText;
		public var _gamePlayScreen:*;
		private var _textmask:Sprite;
		private var _pattarnScreen:PattarnScreen;
		private var _playerArray:Array;
		
		public function GamePlayScreen() 
		{
			_cardArray = new Array();
			_ballArray = new Array();
		}
		override public function initialize():void
		{
			super.initialize();
			_lastPosX = 0.0;
			setGameScreen();
			setMovingText();
		}
		private function setGameScreen():void
		{
			//screenUI = new Resources.gameScreen();
			  screenUI = GetDisplayObject.getSymbol("gameScreen");
			addChild(screenUI);
			setTextmask();
			//ResizeableContainer.setTextToUI(screenUI, LanguageXMLLoader._loadedXML.GameRoom.Room);
			_gamePlayScreen = screenUI;
			setPlayer();
			
		}
		private function setCards():void
		{
			var posX:Number = screenUI.cardPos.x;
			var posY:Number = screenUI.cardPos.y;
			for (var i:int = 0; i < _cardNumberArray.length;++i )
			{
				_card = new Card(_cardNumberArray[i],_patternArray);
				addChild(_card);
				_card.x = posX;
				_card.y = posY;
				posX += _card.width + 5;
				if (i ==4)
				{
					posY += _card.height + 3;
				}
				_cardArray.push(_card);
			}
		}
		private function checkNumber(number:String):void
		{
			for (var i:int = 0; i < _cardArray.length;++i )
			{
				_cardArray[i].checkNumber(number);
			}
		}
		private function startGame():void
		{
			addGameEventListener(stage, Event.ENTER_FRAME, doEveryFrame);
		}
		
		private function doEveryFrame(evt:Event):void
		{
		   if (_currentBall)
		   {
				if (_currentBall.x <= _lastPosX&&_ballArray.length<=5)
				{
					_currentBall.x -= 0;
					_currentBall.rotation -= 0;
				}
				else 
				{
						_currentBall.x -= GameConstants.BALL_SPEED;
						_currentBall.rotation -= GameConstants.BALL_ROTATION;
				}
				if (_ballArray.length > 5&&_currentBall.hitTestObject(_ballArray[4]))
				{
					_currentBall.x += GameConstants.BALL_SPEED;
					_currentBall.rotation -= 0;
					for (var i:int = 0; i < _ballArray.length;++i )
					{
						_ballArray[i].x -= GameConstants.BALL_SPEED;
						_ballArray[i].rotation -= GameConstants.BALL_ROTATION;
						if (_ballArray[0].x <= -_currentBall.width)
						{
							_ballArray[i].x -= 0;
							_ballArray[i].rotation -= 0;
							var t:*= _ballArray.splice(0, 1);
							t[0].parent.removeChild(t[0]);
							t[0] = null;
							--i;
						}
					}
				}
		    }
		}
		private function setBall():void
		{
			var color:int = int(Math.random() * GameConstants.BALL_NUMBER)+1;
			var ball:Ball = new Ball(_comingNumber,color);
			addChild(ball);
			_currentBall = ball;
			_ballArray.push(ball);
			_lastPosX += _currentBall.width;
		}
		override public function onExtensionResponse(evt:SFSEvent):void
		{
			
		}
		private function setMovingText():void
		{
			_movingText = new RunningText();
			addChild(_movingText);
			_movingText.x = screenUI.textP.x;
			_movingText.y = screenUI.textP.y;
			_movingText.mask = _textmask;
		}
		private function setTextmask():void
		{
			_textmask = new Sprite();
            addChild(_textmask);
            _textmask.graphics.lineStyle(3,0x00ff00);
            _textmask.graphics.beginFill(0x0000FF);
            _textmask.graphics.drawRect(screenUI.textBar.x, screenUI.textBar.y, screenUI.textBar.width, screenUI.textBar.height);
			_textmask.visible = false;
		}
		private function setpattarnScreen(patArray:Array):void
		{
			_pattarnScreen = new PattarnScreen(patArray);
			addChild(_pattarnScreen);
			_pattarnScreen.x = screenUI.pattarnP.x;
			_pattarnScreen.y = screenUI.pattarnP.y;
		}
		private function setPlayer():void
		{
			var customslider:CustomSlider = new CustomSlider(0,5, screenUI.bidSlider1,changeFunc, 2);
		}
		
		private function changeFunc(sliderValue:Number,sliderPosX:Number):void
		{
			var ind:int = int(value);
			//trace(ind,"index,,,,,,,,,,",value)
			for (var i:int = 0; i < _playerArray.length;++i )
			{
				if(_playerArray.length>5)
				  // showNameArray[i].text = nameArray[ind + i];
			}
		}
	}

}