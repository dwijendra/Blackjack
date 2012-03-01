package multiLanguage 
{
	import flash.text.TextFieldAutoSize;
	/**
	 * ...
	 * @author Siddhant
	 */
	public class ResizableUI
	{
		
		public function ResizableUI() 
		{
			
		}
		
		static public function initialize(ui:*,uiText:String,normalLength:int = 1):void
		{
			if (ui.hasOwnProperty("text"))
			{
				ui.text = uiText;
				ui.autoSize =  TextFieldAutoSize.CENTER;
				ui.mouseEnabled = false;
				//ui.mouseChildren = false;
				//trace("jhgfsdjfgjsdgjf")
			}
			else
			{
				trace (ui.name , "error point");
				if (ui.hasOwnProperty("textHolder"))
				{
					ui.textHolder.text = uiText;
					
					if (ui.textHolder.hasOwnProperty("mouseEnabled"))	
						ui.textHolder.mouseEnabled = false;
				}
				
			}
			//trace (ui , uiText, " setting here");
			//var scaleFactor:int = uiText.length / normalLength;
			//ui.width = scaleFactor;
		}
		
	}

}