package gameCommon.lib 
{
	import br.com.stimuli.loading.loadingtypes.URLItem;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	import flash.sampler.NewObjectSample;
	import flash.utils.Dictionary;
	import flash.system.ApplicationDomain;			
	import flash.utils.getDefinitionByName;
	import flash.media.SoundTransform;
	
	/**
	 * ...
	 * @author ...
	 */
	public class SoundPlayer 
	{
		
		private static var _soundChannelMap:Dictionary;
		private static var _soundNameMap:Dictionary;
		private static var _nameClassMap:Object;
		private static var _soundNameArray:Array;

		
		public static var _soundMuted:Boolean;
		public static var _initUrl:String;
		
		public static const defaultVolume:Number = 0.8;
		private static var _slideVolume:Number = 0.8;


		
		public function SoundPlayer() 
		{
			
		}
		
		static public function initialize(nameClassMap:Object,initUrl:String=""):void
		{
			_nameClassMap = nameClassMap;
			_soundChannelMap = new Dictionary();
			_soundMuted = false;
			_initUrl = initUrl;
		}
		
		static public function loadAllSounds():void
		{
			for (var names:* in _soundChannelMap)
			{
				getSoundByUrl(names);
			}
			
		}
		
		static public function soundButtonPressed(evt:Event):void
		{
			var newVolume:Number;
			if (_soundMuted)
			{
				_soundMuted = false;
				newVolume = defaultVolume;
			}
			else
			{
				_soundMuted = true;
				newVolume = 0.0;
			}
			for (var names:* in _soundChannelMap)
			{
				//trace (names , " Sound names");
				setSoundVolume(names, newVolume);
			}
		}
		
		static public function slideVolume(vol:Number):void
		{
			_slideVolume = vol;
			for (var names:* in _soundChannelMap)
			{
				setSoundVolume(names, vol);
			}
		}
		
		static private function getSoundByName(name:String):Sound
		{
			var soundClass:Class = _nameClassMap[name].linkage as Class;
			var sound:Sound = new soundClass();
			return sound;
		}
		
		static public function playSound(soundName:String,numLoops:int = 0,fetchbyurl:Boolean = true):void
		{
			var sound:Sound;
			
			if (fetchbyurl)
			{
				sound = getSoundByUrl(soundName);
			}
			else
			{
				sound = getSoundByName(soundName);
			}
				var transform:SoundTransform = new SoundTransform();
				if (_soundMuted)
					transform.volume = 0.0;
				else
					transform.volume = _slideVolume;
			
					
				var soundChannel:SoundChannel = sound.play(0,numLoops,transform);
				_soundChannelMap[soundName] = soundChannel;
			
		}
		static public function getSoundByUrl(name:String):Sound{
			 
			  var url:String = _nameClassMap[name].url as String;
			  var request:URLRequest = new URLRequest(url);
			  var sound:Sound = new Sound(request);
			  //sound.load(request);
			  return sound;
		}
		
		static public function stopSound(soundName:String):void
		{
			var soundChannel:SoundChannel = _soundChannelMap[soundName];
			if (soundChannel)
			{
				soundChannel.stop();
				_soundChannelMap[soundName] = null;
			}
		}
	    static public function muteAll( mute:Boolean, volume:int = 1.0):void {
			
		}
		
		static public function setSoundVolume(soundName:String, volume:Number):void
		{
			var soundChannel:SoundChannel = _soundChannelMap[soundName];
			if (soundChannel)
			{
				var transform:SoundTransform = soundChannel.soundTransform;
				transform.volume = volume;
				soundChannel.soundTransform = transform;
				//soundChannel.soundTransform.volume = volume;
				//trace("volume " + soundChannel.soundTransform.volume + " volume passed is " ,volume);
			}			
		}
	}
	
}