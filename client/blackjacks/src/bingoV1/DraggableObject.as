package bingoV1
{
	
	//import Box2D.Collision.b2DynamicTreeBroadPhase;
	//import com.gskinner.motion.GTween;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import gameCommon.objects.BaseObject;
	import flash.events.MouseEvent;
	import gameCommon.screens.BaseScreen;
	/**
	 * ....
	 * @author Siddhant
	 */
	public class DraggableObject extends BaseScreen
	{
		public var _obj:*;
		public var _initX:Number;
		public var _initY:Number;
		private var _dragEnded:Function;
		private var _moveAllCards:Function;
		public var _objInitPos:Point;
		protected var _xMovement:Number;
		protected var _yMovement:Number;
		
		
		private var _inClick:Boolean = false;
		private var _clickTimer:Timer;
		private var _mouseMovedUp:Boolean;
		//public var _intcount:int = 0;
		
		public function DraggableObject() 
		{
			//_obj = obj;
			//_objInitPos = new Point(x, y);
			//_dragEnded = dragEnded;
			//_moveAllCards = moveAllCards;
			addGameEventListener(this, MouseEvent.MOUSE_DOWN, objectClicked);
			addGameEventListener(this, MouseEvent.DOUBLE_CLICK, doubleClicked);
			//////trace (" asdfadf " ,_obj);
		 
		}
		
		public function doubleClicked(evt:MouseEvent):void
		{
			trace (" Double clicked");	
		}
		
		protected function objectClicked(evt:MouseEvent):void
		{
			_initX = evt.stageX;
			_initY = evt.stageY;
			addGameEventListener( stage, MouseEvent.MOUSE_UP, mouseReleased);
			addGameEventListener( stage, MouseEvent.MOUSE_MOVE, mouseMoved);
			return;
		}
		
		private function mouseReleased(evt:MouseEvent):void
		{
			//////trace ("Mouse Released");
			_mouseMovedUp = true;
			removeGameEventListener(stage, MouseEvent.MOUSE_MOVE, mouseMoved);		
			removeGameEventListener(stage, MouseEvent.MOUSE_UP, mouseReleased);	
			dragEnded(evt);
		}
		
		protected function dragEnded(evt:MouseEvent):void
		{
			
		}

		protected function mouseMoved(evt:MouseEvent):void
		{
			_xMovement = evt.stageX - _initX;
			_yMovement = evt.stageY - _initY;
			
			_initX = evt.stageX;  
			_initY = evt.stageY;			
			
			x += _xMovement;
			y += _yMovement;			
			
			stage.invalidate();
		}
				
		public function moveObjectBack():void
		{
			//new GTween(_obj, .4, { x:_objInitPos.x, y:_objInitPos.y } );
		}
	
		
	}

}