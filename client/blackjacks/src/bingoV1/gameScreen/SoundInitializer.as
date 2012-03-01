package bingoV1.gameScreen 
{
	import gameCommon.lib.SoundPlayer;
	/**
	 * ...
	 * @author vipul
	 */
	public class SoundInitializer
	{
		private var _appUrl:String="";
		
		public function SoundInitializer() 
		{
			initializeSound();
		}
		private function initializeSound():void
		{
			var soundObject:Object = new Object();
			var i:int;
			//soundObject["femaleBingoMusic"] = { url:"sounds/welcome sound + bingo popup sound/bingo-female.mp3" };
			//soundObject["femaleWelcomeMusic"] = { url:"sounds/welcome sound + bingo popup sound/welcom-female.mp3" };
			soundObject["femaleTimerMusic"] = { url:"sounds"+GetDisplayObject.lng+"/female/aftellen.mp3" };
			soundObject["femaleWelcomeMusic"] = { url:"sounds"+GetDisplayObject.lng+"/female/welkomglobal.mp3" };
			soundObject["maleTimerMusic"] = { url:"sounds"+GetDisplayObject.lng+"/male/aftellen.mp3" };
			soundObject["maleWelcomeMusic"] = { url:"sounds"+GetDisplayObject.lng+"/male/welkomglobal.mp3" };
			/*
			for (i = 1; i <= 75;++i )
			{
				var str:String = "female" + i.toString();
				var urlStr:String = "sounds/female/" + i.toString() + ".mp3";
				soundObject[str] = { url:urlStr };
			}*/
			for (i = 1; i <= 75;++i )
			{
				var str1:String = "male"+i.toString();
				var urlStr1:String = "sounds"+GetDisplayObject.lng+"/male/nummers/" + i.toString() + ".mp3";
				soundObject[str1] = { url:urlStr1 };
				var str2:String = "female"+i.toString();
				var urlStr2:String = "sounds"+GetDisplayObject.lng+"/female/nummers/" + i.toString() + ".mp3";
				soundObject[str2] = { url:urlStr2};
			}
			/*
			for (i = 0; i <= 10 ; ++i)
			{
				str = "femaletimer" + i.toString();
				urlStr = "sounds/female 0 - 10/" + i.toString() + ".mp3";
				soundObject[str] = { url:urlStr };
				str = "maletimer" + i.toString();
				urlStr = "sounds/male 0 - 10/" + i.toString() + ".mp3";
				soundObject[str] = { url:urlStr };
			}*/
			//soundObject["gameMusic"] = { linkage:Resources.backgroundSound };
			//soundObject["ticksound"] = { linkage:Resources.ticksound };
			SoundPlayer.initialize(soundObject, _appUrl );
			SoundPlayer.loadAllSounds();
		}
		
		public static function playLastTimerSounds(_currentNum:int):void
		{
			
			if (_currentNum > 10 && _currentNum <= 20)
			{
				SoundPlayer.playSound("ticksound", 0, false);				
				return;
			}
				
			var str1:String = "maletimer" +_currentNum;
			var str2:String = "femaletimer" + _currentNum;
			if (SoundScreen._femaleSounDClicked)
			{
			       SoundPlayer.playSound(str2);
				   //SoundScreen._currentSound = str2;
			}
			else
			{
			    SoundPlayer.playSound(str1);
				//SoundScreen._currentSound = str1;
			}
		}
		
		public static function playWelcomeSound():void
		{
			if(SoundScreen._femaleSounDClicked)
			    SoundPlayer.playSound("femaleWelcomeMusic");
			else
			   SoundPlayer.playSound("maleWelcomeMusic");
		}
		
		
	}

}