package bingoV1.gameScreen 
{
	import adobe.utils.CustomActions;
	import com.gskinner.motion.plugins.SnappingPlugin;
	import flash.geom.Point;
	import gameCommon.screens.BaseScreen;
	import com.gskinner.motion.GTween;
	import flash.events.Event;
	
	
	/**
	 * ...
	 * @author vipul
	 */
	public class Card extends BaseScreen
	{
	
		private var _cardId:int;
		
		
		public function Card(cardId:int) 
		{
			_cardId = cardId;
		//	trace("card id", cardId,Resources._cardArray.length);
			screenUI = new Resources._cardArray[_cardId]();
			screenUI.height = 120;
			screenUI.width = 80;
			 addChild(screenUI);
			 
			 if (_cardId == 0)
			 {
			    screenUI.stop();
				//addGameEventListener(screenUI, Event.ENTER_FRAME, cardAnim);
			 }
		}
		
	    public function animation(xPos:Number=20,yPos:Number=20):void
		{
			new GTween(screenUI, .3, { x:xPos, y:yPos } );
		}
		public  function backCardAnim():void {
			
			screenUI.play();
			addGameEventListener(screenUI, Event.ENTER_FRAME, cardAnim)
		}
		private function cardAnim(e:Event):void
		{
			var obj:*= e.currentTarget;
			screenUI.gotoAndStop(obj.totalFrames);
			removeGameEventListener(screenUI, Event.ENTER_FRAME, cardAnim)
		}
		
	}

}