package  
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author vipul
	 */
	public class CustomSlider 
	{
		private var _slider:*;
		private var _offsetX:Number;
		private var _initX:Number;
		private var _minValue:Number;
		private var _maxValue:Number;
		private var _onChangeFunc:Function;
		private var newSliderInitPos:Number = 0;
		private var _intY:Number;
		private var _slideDir:int;
		//private var _sliderInitX:int;
		
		public function CustomSlider(minValue:Number, maxValue:Number, ui:* , changeFunc:Function, slideDir:int, sliderInitVal:int=0, SliderInitPos:Number=0) 
		{
			_slideDir = slideDir;
			_onChangeFunc = changeFunc;
			_slider = ui;
			_slideDir = slideDir;
			var maxShift:Number
			if (_slideDir==1)
			{
				 maxShift= _slider.endP.x -  _slider.startP.x;
			}
			else
			{
				maxShift = _slider.endP.y - _slider.startP.y;
			}
			_slider.slider.buttonMode = true;
			
			_slider.addEventListener(MouseEvent.MOUSE_DOWN, mousePressed);
			_minValue = minValue;
			_maxValue = maxValue;
			//trace(" before setting startp inside custom slider _slider.startP.x is " + _slider.startP.x+" sliderInitVal is "+sliderInitVal+" _minValue is "+minValue);
			_slider.slider.x = _slider.startP.x;
			_slider.slider.y = _slider.startP.y;
			_minValue = minValue;
			//trace(" after setting inside custom slider _slider.startP.x is " + _slider.startP.x+" sliderInitPos is "+ SliderInitPos );
		}
		
		private function mousePressed(e:MouseEvent):void 
		{
			_slider.stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoved);
			_slider.stage.addEventListener(MouseEvent.MOUSE_UP, mouseUP);
			_initX = e.stageX;
			_intY = e.stageY;
		}
		
		private function mouseUP(e:MouseEvent):void 
		{
			_slider.stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoved);
			_slider.stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUP);
			
		}
		
		private function mouseMoved(e:MouseEvent):void 
		{
			
			if (_slideDir == 1)
			{
				xDirSlide(e);
			}
			else
			{
				yDirSlide(e);
			}
				
		}
		private function xDirSlide(e:MouseEvent):void
		{
			var currentX:Number = e.stageX;
			var diff:Number = currentX - _initX;
			//trace(" diff " + diff);
			//if (diff > 0)
			//{
				_slider.slider.x += diff;
				_initX = currentX;
				
				if (_slider.slider.x >= _slider.endP.x-_slider.slider.width)
					_slider.slider.x = _slider.endP.x-_slider.slider.width;
					
				if (_slider.slider.x <= _slider.startP.x)
					_slider.slider.x = _slider.startP.x;
					
				var xShift:Number = _slider.slider.x -  _slider.startP.x;
				var maxShift:Number = _slider.endP.x-_slider.slider.width -  (_slider.startP.x);
				var sliderValue:Number = (xShift / maxShift) * (_maxValue - _minValue) + _minValue;
				//trace (" inside custom slider _slider.startP.x is " + _slider.startP.x + " _minValue is " + _minValue + " sliderValue is " + sliderValue);
				//newSliderInitPos = _slider.slider.x;
				_slider.stage.invalidate();
				_onChangeFunc(sliderValue, _slider.slider.x);	
		}
		private function yDirSlide(e:MouseEvent):void
		{
			var currentY:Number = e.stageY;
			var diff:Number = currentY - _intY;
			_slider.slider.y += diff;
			_intY = currentY;
			if (_slider.slider.y >= _slider.endP.y-_slider.slider.height)
					_slider.slider.y = _slider.endP.y - _slider.slider.height;
					
			if (_slider.slider.y <= _slider.startP.y)
					_slider.slider.y = _slider.startP.y;
					
			var yShift:Number = _slider.slider.y -  _slider.startP.y;
			var maxShift:Number = _slider.endP.y-_slider.slider.height -  (_slider.startP.y);
			var sliderValue:Number = (yShift / maxShift) * (_maxValue - _minValue) + _minValue;
			//trace (" inside custom slider _slider.startP.x is " + _slider.startP.y + " _minValue is " + _minValue + " sliderValue is " + sliderValue);
			//newSliderInitPos = _slider.slider.x;
			_slider.stage.invalidate();
			_onChangeFunc(sliderValue, _slider.slider.y);	
					
		}
	}

}