package gameCommon.lib 
{
	import com.gskinner.motion.GTween;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import com.gskinner.motion.easing.*;
	
	/**
	 * ...
	 * @author ...
	 */
	public class TweenCollection  extends EventDispatcher
	{
		private var tweenArray:Array;
		private var numTweens:int;
		private var tcFunc:Function;
		
		public static const AllTweensOver:String = "alltweensover";
		
		public function TweenCollection() 
		{
			tweenArray = new Array();
			numTweens = 0;
		}
		public function get tweens():int
		{
			return numTweens;
		}
		public function addTween(target:Object ,duration:Number,values:Object,props:Object = null,pluginData:Object = null):void
		{
			if (props == null)
				props = new Object();
			//props.paused = true;
			props.ease = Sine.easeInOut;
			props.onComplete = onComplete;
			var newObj:Object = new Object();
			newObj.target = target;
			newObj.duration = duration;
			newObj.values = values;
			newObj.props = props;
			newObj.pluginData = pluginData;
			//var tween:GTween = new GTween(target, duration, values, props, pluginData);
			
			tweenArray.push(newObj);
			numTweens++;
		}
		
		private function createTweenFromObject(obj:Object):void
		{
			new GTween(obj.target, obj.duration, obj.values, obj.props, obj.pluginData);
		}
		
		public function start(tweenCompleteFunc:Function = null):void
		{
			//trace ("Start Called");
			for (var i:int = 0; i < tweenArray.length ; ++i)
			{
				createTweenFromObject(tweenArray[i]);
				//tweenArray[i].paused = false;
			}
			tcFunc = tweenCompleteFunc;
		}
		
		private function onComplete(tween:GTween):void
		{
			numTweens--;
			if (numTweens == 0)
			{
				dispatchEvent(new Event(TweenCollection.AllTweensOver));
				if (tcFunc != null)
					tcFunc();
			}
		}
		
	}
	
}