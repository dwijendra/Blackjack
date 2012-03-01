package gameCommon.customUI 
{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import gameCommon.objects.BaseObject;
	import gameCommon.screens.BaseScreen;
	
	
	/**
	 * ...
	 * @author ...
	 */
	public class ListUI extends BaseScreen
	{
		protected var _headerArray:Array;
		protected var _listUI:*;
		protected var _elementH:Number;
		protected var _elementW:Number;
		protected var _elementA:Array;
		protected var _selectedIndex:int;
		protected var _lastSelected:ListElement;
		
		public function ListUI(listUIC:Class,ew:Number,eh:Number) 
		{
			_listUI = new listUIC();
			_elementW = ew;
			_elementH = eh;
			_elementA = null;
			_selectedIndex = -1;
			_lastSelected = null;
		}
		
		override public function initialize():void
		{
			addChild(_listUI);			
		}
		
		public function setListHeaders(nameA:Array):void
		{
			_headerArray = nameA;
		}
		
		//will create list elements
		public function setListData(objArray:Array,uiClass:Class):void
		{
			removeExistingElements();
			var tmpE:ListElement;
			var tmpUIC:*;
			
			_elementA = new Array();
			var currentX:Number = _listUI.elemS.x;
			var currentY:Number = _listUI.elemS.y;
			for (var i:int = 0; i < objArray.length;++i)
			{
				tmpE = getListElement(objArray[i],i);
				tmpUIC = getListElementUI(objArray[i],uiClass);
				tmpE.setUI(tmpUIC);	
				addChild(tmpE);
				tmpE.x = currentX;
				tmpE.y = currentY;
			    currentY += _elementH;
				setCurrentSelection(tmpE);
				_elementA.push(tmpE);
				//_selectedIndex = i;				
			}
		}
		
		protected function setCurrentSelection(elem:ListElement):void
		{
			if (_lastSelected)
			{
				_lastSelected.removeGlow();
				//_lastSelected = null;
			}
			_lastSelected = elem;
			_lastSelected.glow();
			_selectedIndex = _lastSelected._index;
		}
		
		protected function getListElement(obj:Object,index:int):ListElement
		{
			var relem:ListElement = new ListElement(index);
			relem.addGameEventListener(MouseEvent.CLICK, elementClicked);
			
			return relem;
		}
		
		private function elementClicked(e:MouseEvent):void 
		{
			var elem:ListElement = e.currentTarget as ListElement;
			setCurrentSelection(elem);
			//elem.glow();
			//_selectedIndex = elem._index;			
		}
		
		protected function removeExistingElements():void
		{
			if (_elementA == null)
				return;
				
			var tmpBaseObj:BaseObject;	
			for (var j:int = 0; j < _elementA.length;++j)
			{
				tmpBaseObj = _elementA[j];
				tmpBaseObj.destroy();
				removeChild(tmpBaseObj);				
			}
		}
		
		protected  function getListElementUI(data:Object,uiClass:Class):*
		{
			var returnUI:* = new uiClass();
			var header:String;
			var instanceN:String;
			for (var i:int = 0; i < _headerArray.length;++i)
			{
				header = _headerArray[i];				
				instanceN = header +  "T";
				returnUI[instanceN].text = data[header];
				returnUI[instanceN].selectable = false;
				returnUI.pBar.gotoAndStop(1);
			}
			return returnUI;
		}
	}
	
}