package bingoV1.gameScreen 
{
	/**
	 * ...
	 * @author dwijendra
	 * 
	 */
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import gameCommon.lib.FileLoader;
	import gameCommon.screens.BaseScreen;
	//import mochi.as3.*;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display.LoaderInfo;
	import gameCommon.lib.SHA1;
	import flash.net.URLLoaderDataFormat;
	import flash.events.SecurityErrorEvent;
	
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
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.net.URLLoader;
	import flash.system.Security;
	import gameCommon.lib.SHA1;	
	public class Cashier extends BaseScreen
	{
		
		private var loaderUI:*;
	
		// Substitute these for what's in the MochiAd code
        public static var GAME_OPTIONS:Object = { id: "ee004661827b5d0c", res:"800x600" };
		private var game_loaded:Boolean = false;
		private var add_loaded:Boolean = false;
		private var _lng:String;
		private var _origWidth:Number;
		private var _userName:String =null;
		private var _pwd:String =null;
		private var _balance:String;
		private var _Screen:*
		private var loader:URLLoader;
		public function Cashier(screen:*):void 
		{
			_Screen = screen;
			//setLanguageByFlashVars();
			 init();
			
		}
		
		private function init():void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			sendGetRequest();
		}
			
		
		public function sendGetRequest():void
		{
			
			//trace(SHA1.hex_sha1("bingobingo"),"tracing the");
			Security.loadPolicyFile(GetDisplayObject.getBalanceRequestURL() + "/crossdomain.xml");
			//trace (GetDisplayObject.getBalanceRequestURL() + "/crossdomain.xml");
			var url:String = GetDisplayObject.getBalanceRequestURL() + "/BalanceRequest?client_session_id=550.00&username=" + Main._userName + "&password=" +Main._password+"&random="+ Math.random();
			//var url:String = GetDisplayObject.getBalanceRequestURL() + "/BalanceRequest?client_session_id=550.00&username=" + Main._userName + "&password=" +SHA1.hex_sha1(Main._password)+"&random="+ Math.random();//testing:::::::::::
			//trace (" Url to be send is ", url);
			//BingoGameScreen._publicChatScreen.addChatMessage(" Url to be send is " + url);
			var requestVars:URLVariables = new URLVariables();
			//requestVars.object_name = "key1";
			//requestVars.cache = new Date().getTime();
 
			var request:URLRequest = new URLRequest();
			request.url = url;
			request.method = URLRequestMethod.GET;
			request.data = requestVars;
 
			 loader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.addEventListener(Event.COMPLETE, loaderCompleteHandler);
			loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
    		loader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			try
			{
				loader.load(request);
			}
			catch (error:Error)
			{
				trace ("Unable to load URL");
			}
	
	
		}
		
		private function loaderCompleteHandler(e:Event):void
		{
			loader.removeEventListener(Event.COMPLETE, loaderCompleteHandler);
			loader.removeEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
    		loader.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			 var response:XML = XML(e.target.data as String);
		//	trace("trace kiya"+response);
			 if ( response.child("error_code")[0].toString() == "0")
			{
				var balance:Number = response.child("balance")[0];
				_balance = (balance/100).toFixed(2);
				_Screen.balance.text = _balance;
			}
		}
		private function httpStatusHandler (e:Event):void
		{
			//trace("httpStatusHandler:" + e);
		}
		private function securityErrorHandler (e:Event):void
		{
			
		}
		private function ioErrorHandler(e:Event):void
		{
			
		}
		
	}

}