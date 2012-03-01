package it.gotoandplay.smartfoxserver.http
{
	import flash.net.URLLoader
	import flash.net.URLLoaderDataFormat
	import flash.events.Event
	import flash.events.IOErrorEvent
	
	/**
	 * LoaderFactory class.
	 * 
	 * @version	1.0.0
	 * 
	 * @author	The gotoAndPlay() Team
	 * 			{@link http://www.smartfoxserver.com}
	 * 			{@link http://www.gotoandplay.it}
	 * 
	 * @exclude
	 */
	public class LoaderFactory
	{
		private static const DEFAULT_POOL_SIZE:int = 2
		
		private var currentLoaderIndex:int
		private var responseHandler:Function
		private var errorHandler:Function

		
		function LoaderFactory(responseHandler:Function, errorHandler:Function, poolSize:int = DEFAULT_POOL_SIZE)
		{
			this.responseHandler = responseHandler
			this.errorHandler = errorHandler
		}
		
		public function getLoader():URLLoader
		{
			var urlLoader:URLLoader = new URLLoader()
			urlLoader.dataFormat = URLLoaderDataFormat.TEXT
			urlLoader.addEventListener(Event.COMPLETE, this.responseHandler)
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, this.errorHandler)
			urlLoader.addEventListener(IOErrorEvent.NETWORK_ERROR, this.errorHandler)
			
			return urlLoader
		}
	}
}