package bingoV1.gameScreen 
{
	import flash.events.*;
	import gameCommon.screens.BaseScreen;
	import multiLanguage.ResizeableContainer;
	import multiLanguage.LanguageXMLLoader;
	import gameCommon.lib.SoundPlayer;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author vipul
	 */
	public class SoundScreen extends BaseScreen
	{
		public static var _femaleSounDClicked:Boolean = true;
		public static var _maleSounDClicked:Boolean;
		private var _bingoGameScreen:BingoGameScreen;
		public static var _currentSound:String;

		public function SoundScreen(bgs:BingoGameScreen) 
		{
			_bingoGameScreen = bgs;
		}
		override public function initialize():void
		{
			super.initialize();
			//screenUI = new Resources.musicScreen();
			  screenUI = GetDisplayObject.getSymbol("musicScreen");
			addChild(screenUI);
			screenUI.male.gotoAndStop(1);
			screenUI.female.gotoAndStop(2);
			screenUI.music1.gotoAndStop(1);
			screenUI.male.buttonMode = true;
			screenUI.female.buttonMode = true;
			screenUI.music1.buttonMode = true;
			screenUI.music2.gotoAndStop(1);
			addGameEventListener(screenUI.male, MouseEvent.CLICK, manClicked);
			addGameEventListener(screenUI.female, MouseEvent.CLICK, womanClicked);
			addGameEventListener(screenUI.music1, MouseEvent.CLICK, musicClicked);
			addGameEventListener(screenUI.closeB, MouseEvent.CLICK, closeScreen);
			//setTimer();
			setSoundButton();
			setVolumeSlider();
			//ResizeableContainer.setTextToUI(screenUI, LanguageXMLLoader._loadedXML.volumeControl);
		}
		
		private function closeScreen(evt:MouseEvent):void
		{
			_bingoGameScreen.removeSoundScreen();
		}
		
		private function musicClicked(evt:MouseEvent):void
		{
			SoundPlayer.soundButtonPressed(evt);
			setSoundButton();
		}
		
		private function womanClicked(evt:MouseEvent):void
		{
			removeGameEventListener(screenUI.female, MouseEvent.CLICK, womanClicked);
			addGameEventListener(screenUI.male, MouseEvent.CLICK, manClicked);
			_maleSounDClicked = false;
			_femaleSounDClicked = true;
			screenUI.female.gotoAndStop(2);
			screenUI.male.gotoAndStop(1);
		}
		
		private function manClicked(evt:MouseEvent):void
		{
			removeGameEventListener(screenUI.male, MouseEvent.CLICK, manClicked);
			addGameEventListener(screenUI.female, MouseEvent.CLICK, womanClicked);
			_maleSounDClicked = true;
			_femaleSounDClicked = false;
			screenUI.male.gotoAndStop(2);
			screenUI.female.gotoAndStop(1);
		}
		public function setSoundButton():void
		{
			if (SoundPlayer._soundMuted)
				screenUI.music1.gotoAndStop(2);
			else
				screenUI.music1.gotoAndStop(1);
		}
		private function setVolumeSlider():void
		{
			var customslider:CustomSlider = new CustomSlider(0, 1, screenUI.bidslider, changeFunc, 1);
			screenUI.bidslider.slider.x = screenUI.bidslider.endP.x;
		}
		
		private function changeFunc(sliderValue:Number,sliderPosX:Number):void
		{	
			SoundPlayer.slideVolume(sliderValue);
		}
		private function setTimer():void
		{
			var timer:Timer = new Timer(4000, 30);
			addGameEventListener(timer, TimerEvent.TIMER, onTimer);
			timer.start();
		}
		
		private function onTimer(evt:TimerEvent):void
		{			
			var s:int = evt.target.currentCount;
			var str1:String = "male" + s;
			var str2:String = "female" + s;
			/*if(_femaleSounDClicked)
			       SoundPlayer.playSound(str2);
			else
			    SoundPlayer.playSound(str1);*/
				
		}	
	}

}