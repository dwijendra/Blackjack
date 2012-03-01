package multiLanguage 
{
	import flash.display.DisplayObject;
	import multiLanguage.ResizableUI;
	/**
	 * ...
	 * @author Siddhant
	 */
	public class ResizeableContainer
	{
		//protected var _uiXML:XMLList;
		//protected var _ui:*;
		
		public function ResizeableContainer() 
		{
			
		}
		
		public function initialize(ui:*, xml:XMLList):void
		{
			//_ui = ui;
			//_uiXML = xml;
			//setTextToUI();
		}
		
		static public function setTextToUI(_ui:*,_uiXML:*):void
		{
			return;
			var child:DisplayObject;
			//var tmpBaseObject:BaseObject;
			
			for (var i:uint=0; i < _ui.numChildren; i++)
			{
				child = _ui.getChildAt(i);
				if (child.name.indexOf("_res") != -1)
				{
					//name will be of form 
					
					var uindex:int = child.name.indexOf("_");
					var uiXmlName:String = child.name.substring(0, uindex);
					//trace (_uiXML, "ui xml");
					var uiText:String = _uiXML[uiXmlName];
					//trace (uiText , " text got is " , uiXmlName);
					//var resUI:ResizableUI = new ResizableUI();
					ResizableUI.initialize(child, uiText);
				}
			}
		}		
	}
}