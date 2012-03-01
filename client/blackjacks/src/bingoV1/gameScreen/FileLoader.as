package bingoV1.gameScreen 
{
	import flash.display.Loader;
	import flash.system.ApplicationDomain;
	import flash.events.IEventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	/**
	 * ...
	 * @author ...
	 */
	public class FileLoader 
	{
		
		static public var loader:Loader;
		static private var complFunc:Function;
		static private var loaderUI:*
		
		
		static public function loadFile(url:String,onCompleteFunc:Function):void {
            loader = new Loader();
			//loaderUI = ui;
			//loaderUI.gotoAndStop(1);
			//loaderUI.loader.gotoAndStop(1);
            configureListeners(loader.contentLoaderInfo);
			complFunc = onCompleteFunc;
            //loader.addEventListener(MouseEvent.CLICK, clickHandler);
 
            var request:URLRequest = new URLRequest(url);
			var context:LoaderContext = new LoaderContext();
//        context.applicationDomain = ApplicationDomain.currentDomain;
			context.applicationDomain = new ApplicationDomain();

            loader.load(request,context);

            //addChild(loader);
        }

        static private function configureListeners(dispatcher:IEventDispatcher):void {
            dispatcher.addEventListener(Event.COMPLETE, completeHandler);
            dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
            dispatcher.addEventListener(Event.INIT, initHandler);
            dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            dispatcher.addEventListener(Event.OPEN, openHandler);
            dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
            dispatcher.addEventListener(Event.UNLOAD, unLoadHandler);
        }

        static private function completeHandler(event:Event):void {
            //trace("completeHandler: " + event.target);
			complFunc();
        }

        static private function httpStatusHandler(event:HTTPStatusEvent):void {
            //trace("httpStatusHandler: " + event);
        }

        static private function initHandler(event:Event):void {
            //trace("initHandler: " + event);
        }

        static private function ioErrorHandler(event:IOErrorEvent):void {
            //trace("ioErrorHandler: " + event);
        }

        static private function openHandler(event:Event):void {
            //trace("openHandler: " + event);
        }

        static private function progressHandler(event:ProgressEvent):void {
			var perc:int = int (event.bytesLoaded / event.bytesTotal * 100);
			//loaderUI.gotoAndStop(perc);
			//loaderUI.loader.gotoAndStop(perc);
            //trace("progressHandler: bytesLoaded=" + event.bytesLoaded + " bytesTotal=" + event.bytesTotal);
        }

        static private function unLoadHandler(event:Event):void {
            //trace("unLoadHandler: " + event);
        }

        static private function clickHandler(event:MouseEvent):void {
            trace("clickHandler: " + event);
            var loader:Loader = Loader(event.target);
            loader.unload();
        }		
	}
	
}