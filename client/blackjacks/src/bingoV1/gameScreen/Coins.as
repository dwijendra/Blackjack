package bingoV1.gameScreen 
{
	import flash.geom.Point;
	import gameCommon.screens.BaseScreen;
	import flash.events.MouseEvent;
	import com.gskinner.motion.GTween;
	/**
	 * ...
	 * @author ashish
	 */
	public class Coins extends BaseScreen
	{
		public var _coinsAmount:Number;
		public  var _isSelected:Boolean = false;
		public static var _coinWidth:Number = 70;
		public static var _coinHeight:Number = 70;
		private var _coinsHandler:CoinsHandler;
		public function Coins(coins:int,coinshandler:CoinsHandler) 
		{
			_coinsAmount = coins;
		 // trace(_coinsAmount,"iiiiiiiiiiiiii")
			_coinsHandler = coinshandler;
			screenUI = new Resources.coin();
		//	if(_coinsAmount==1)
			// screenUI.coinMask.visible = false;
			screenUI.txt.text = _coinsAmount; 
			addChild(screenUI);
			
		}
		
		public function getAmount():int {
			return _coinsAmount;
		}
		
		
		public function goto(n:int):void
		{
			if (n == 1)
			screenUI.coinMask.visible = true;
			else
			screenUI.coinMask.visible = false;
			//screenUI.txt.text = txt;
			
		}
		public function animation(xPos:Number,yPos:Number):void
		{ 
		
			//trace(xPos, yPos);
			var pt:Point =globalToLocal(new Point(xPos, yPos))// new Point((globalToLocal(new Point(xPos, yPos)).x,(globalToLocal(new Point(xPos, yPos)).y)));
		//	trace(pt.x, pt.y);
			new GTween(screenUI, .4, { x:pt.x-122, y:pt.y } );
		}
	}

}