package gameCommon.lib 
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import gameCommon.screens.BaseScreen;
	import flash.utils.getDefinitionByName;
	import flash.display.DisplayObject;
	import flash.system.fscommand;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Utils 
	{
		private static var statTimer:Timer;
		private static var recordFunc:Function;
		
		public function Utils() 
		{

		}
		
		public static function addPopUpScreen(parentScreen:BaseScreen,className:String):*
		{
			var ScrClass:Class = getDefinitionByName(className) as Class;
			var scr:DisplayObject = new ScrClass() as DisplayObject;
			parentScreen.addChild(scr);			
			scr.x = parentScreen.x + (parentScreen.width - scr.width) / 2;
			scr.y = parentScreen.y + (parentScreen.height - scr.height) / 2;
			return scr;
			//removeScreen();		
		}
		
		public static function quitGame():void
		{
			fscommand("quit");
		}
		public static function changeScreen(oldScreen:BaseScreen, newScreen:BaseScreen):void
		{
			oldScreen.parent.addChild(newScreen);
			oldScreen.removeScreen();
		}
		
		public static function executeOnce(delay:Number, func:Function):void
		{
			recordFunc = func;
			statTimer = new Timer(delay, 1);
			statTimer.addEventListener(TimerEvent.TIMER, onTimer);
			statTimer.start();
			//statTimer.addEventListener(TimerEvent.TIMER, onTimer);
		}
		
		private static function onTimer(e:TimerEvent):void 
		{
			
			statTimer.removeEventListener(TimerEvent.TIMER, onTimer);
			recordFunc(e);
		}
		
		public static function getRandomArrayElement(inputA:Array):*
		{
			var ri:int = Math.floor(inputA.length * Math.random());
			return inputA[ri];
		}		
	
	}
	
}