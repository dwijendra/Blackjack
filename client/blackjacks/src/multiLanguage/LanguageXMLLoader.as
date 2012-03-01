package multiLanguage 
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	//import gameCommon.lib.FileLoader;
	/**
	 * ...
	 * @author Siddhant
	 */
	public class LanguageXMLLoader
	{
		static public var _loadedXML:XML;
		static public var _onLoadedFunc:Function;
		
		public function LanguageXMLLoader() 
		{
			
		}
		
		static public function loadXML(language:String,gameName:String,onLoadedFunc:Function):void
		{
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, xmlLoaded); 
			var xmlPath:String = "languageXML/" + language + "_" + gameName + ".xml";
			loader.load(new URLRequest(xmlPath)); 
			_onLoadedFunc = onLoadedFunc;
			
			//FileLoader.loadFile(xmlPath, xmlLoaded);
		}
		
		static public function xmlLoaded(evt:Event):void
		{
			//trace (evt.target.data);
			_loadedXML = XML(evt.target.data);
			_onLoadedFunc();
		}
		static public function loadSizeXml():void
		{
			//var loader:URLLoader = new URLLoader();
			//loader.addEventListener(Event.COMPLETE, sizeXmlLoaded); 
			//var xmlPath:String = "languageXML/size_text.xml";
			//loader.load(new URLRequest(xmlPath)); 
		}
		
		static private function sizeXmlLoaded(e:Event):void 
		{
			
		}
	}

}