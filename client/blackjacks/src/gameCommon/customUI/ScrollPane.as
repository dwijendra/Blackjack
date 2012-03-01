package gameCommon.customUI 
{
	import flash.display.Sprite;
	import gameCommon.screens.BaseScreen;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Siddhant
	 */
	public class ScrollPane extends BaseScreen
	{
		private var _ui:*;
		private var _slider:*;
		public var _visibleHeight:Number;
		private var _visibleWidth:Number;
		//private var _width:Number;
		private var _intY:Number;
		private var _initUIY:Number;
		private var _scrollMask:Sprite;
		
		public function ScrollPane(visibleWidth:Number,visibleHeight:Number,ui:*,slider:*) 
		{
			//_width = width;
			//trace("trace kiya re",slider);
			_visibleHeight = visibleHeight;
			_visibleWidth = visibleWidth;
			_ui = ui;
			_slider = slider;
			_slider.slider.buttonMode = true;			
			_slider.addEventListener(MouseEvent.MOUSE_DOWN, mousePressed);
			setMask();
			addChild(ui);
			this.x = ui.x;
			this.y = ui.y;
			ui.x = 0;
			ui.y = 0;
			ui.mask = _scrollMask;
			_initUIY = ui.y;
			_slider.slider.y = _slider.startP.y;
			shiftUI();
			if (_ui.height <= _visibleHeight)
			{
				//_slider.slider.visible = false;
				return;
			}
		}
		
		public function changeUI(newui:*,height:Number=-1,width:Number=-1):void
		{
			newui.x = _ui.x;
			newui.y = _ui.y;
			newui.mask = _scrollMask;
			removeChild(_ui);
			_ui = newui;
			addChild(_ui);	
			if ((height!=-1) && (width!=-1))
			{
				_visibleHeight = height;
				_visibleWidth = width;
				 setFullScroll()
				 setMask();
			}
		}
		
		/*override public function initialize():void
		{
			
		}*/
		
		private function mousePressed(e:MouseEvent):void 
		{
			_slider.stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoved);
			_slider.stage.addEventListener(MouseEvent.MOUSE_UP, mouseUP);			
			_intY = e.stageY;
		}
		
		private function mouseUP(e:MouseEvent):void 
		{
			_slider.stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoved);
			_slider.stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUP);			
		}
		
		private function mouseMoved(e:MouseEvent):void 
		{
			if (_ui.height <= _visibleHeight)
				return;
			var currentY:Number = e.stageY;
			var diff:Number = currentY - _intY;
			_slider.slider.y += diff;
			_intY = currentY;
			if (_slider.slider.y >= _slider.endP.y - _slider.slider.height)
					_slider.slider.y = _slider.endP.y - _slider.slider.height;
					
			if (_slider.slider.y <= _slider.startP.y)
			{
					_slider.slider.y = _slider.startP.y;
					_ui.y = _initUIY;
			}
			shiftUI();


			//trace (" Ui height ", _ui.height," Total uis ", totalUIShift, " total slider M ", totalSliderMovement, " UI Pos ", _ui.y);
		}	
		
		private function shiftUI():void
		{
			if (_ui.height <= _visibleHeight)
			{
				//_slider.slider.visible = false;
				return;
			}
			_slider.slider.visible = true;
			var totalSliderMovement:Number = _slider.endP.y -  _slider.startP.y - _slider.slider.height;
			//var totalSliderMovement:Number = _slider.endP.y -  _slider.startP.y ;
			var totalUIShift:Number = _ui.height - _visibleHeight;
			
			var uiToBeShifted:Number = (totalUIShift / totalSliderMovement) * (_slider.slider.y - _slider.startP.y);			
			//trace (" UI to be shifted and total UI shift ",uiToBeShifted , totalUIShift);
			_ui.y = _initUIY - uiToBeShifted;		
			_ui.mask = _scrollMask;
		}
		
		public function setMask():void
		{
			_scrollMask = new Sprite();
            addChild(_scrollMask);
			//_scrollMask.y = 10;
           _scrollMask.graphics.lineStyle(3,0x00ff00);
           _scrollMask.graphics.beginFill(0x0000FF);
           _scrollMask.graphics.drawRect(0,0,_visibleWidth,_visibleHeight);
			_scrollMask.visible = false;
		}
		
		public function setFullScroll():void
		{
			_slider.slider.y = _slider.endP.y -  _slider.slider.height;
			shiftUI();			
		}
	}
}