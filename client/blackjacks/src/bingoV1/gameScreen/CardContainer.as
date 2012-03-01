package bingoV1.gameScreen 
{
	import adobe.utils.CustomActions;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import gameCommon.screens.BaseScreen;
	import multiLanguage.ResizeableContainer;
	import multiLanguage.LanguageXMLLoader;
	
	/**
	 * ...
	 * @author ...
	 */
	public class CardContainer extends BaseScreen
	{
		private var _cardArray:Array;
		
		private var _cardHolder:Sprite;
		private var _cardMask:Sprite;
	    private var _cardPointer:int;
		private var pointerMaxVal:int;
		private var  numCards:int ;
		public var _mainCardArray:Array;
		private var currentY:Number = 10.0;
		private var currentX:Number = 60.0;
		private var currentAnimX:Number= 0;
		private var currentAnimY:Number = 10;
		
		
		private var _text:*;
        private var _cardStrArr:Array;
		private var _index:int;
		public const pt0:Point = new Point( -500, 50);
		public const pt1:Point = new Point( -830, 200);
		public const pt2:Point = new Point( -600, 265);
		public const pt3:Point = new Point( -300, 250);
	//	public const pt4:Point = new Point( -125, 320);
		
		private var pointArr:Array = new Array(pt0, pt1, pt2, pt3);
		
		
	
		public function CardContainer(index:int) 
		{
			_index = index;
			currentAnimX = pointArr[_index].x;
			currentAnimY = pointArr[_index].y;
		    _cardHolder = new Sprite();
			_text = new Resources.txt();
		    _mainCardArray = new Array();
			_cardArray = new Array();
			_cardStrArr = new Array();
		}
	
		
		public function addCards(numString:String):void
		{
			//trace(numString)
			if (numString ==null)
			return ;
			
			_cardArray = numString.split("-");
				for (var l:int = 0; l <_cardArray.length;l++)
				{
					var no:int = (_cardArray[l] - 1) % 52 + 1;
			          showCard(no);
				}
			
				
		}
		public function removeCard(no:String):void
		{
			// trace(_cardArray.indexOf(no),_cardArray,"ky aata",no)
			if (_cardArray.indexOf(no) != -1)
			{
				
				if (no == "0")
				{
				//	trace("hellon")
				 _mainCardArray[_cardArray.indexOf(no)].backCardAnim();
				}
				 
			    removeChild(_mainCardArray[_cardArray.indexOf(no)]);
			  _cardArray.splice(_cardArray.indexOf(no), 1);
			  _mainCardArray.splice(_cardArray.indexOf(no), 1);
			 // currentAnimY -= 10;
			   currentAnimX -= 25;
			
			}
			
		}
		public function sendBackCard():void
		{
			for (var j:int = 0; j < _mainCardArray.length; j++ )
			{
				_mainCardArray[j].animation(-900,10);
			}
		}
		public function setWeight(no:String):void
		{
			_text.txt1.text = no;
			
			_text.x = pointArr[_index].x;
			_text.y = pointArr[_index].y+20;
			addChild(_text);
		}
		public function addNewCard(str1:int):void
		{
			showCard(str1);
			_cardArray.push(str1.toString());
		}
		public function splitCondition():int
		{
	     if (_cardStrArr.length > 2)
		  no = 0;
		if (_cardStrArr[0] && _cardStrArr[1] && _cardStrArr.length == 2)
		{
		   var  no:int = 0;                                                               
			if ((_cardStrArr[0]%13) == (_cardStrArr[1]%13))
			    no = 1;
			
				
		}
			return no;
			
		}
		
	
		
		private function showCard(str:int):void
		{
			
			     _cardStrArr.push(str);
				  var card:Card = new Card(str);
				  
				   addChild(card);
				   card.x = currentX;
				   card.y = currentY;
				   card.animation(currentAnimX, currentAnimY);
				  // currentAnimY += 15;
				   currentAnimX += 25;
				 _mainCardArray.push(card);	
		}
		
		
		private function drawMask():void
		{
			_cardMask = new Sprite();
            addChild(_cardMask);
           _cardMask.graphics.lineStyle(3,0x00ff00);
           _cardMask.graphics.beginFill(0x0000FF);
           _cardMask.graphics.drawRect(0,0,900,240);
			_cardMask.visible = false;
		}
		
	}
}