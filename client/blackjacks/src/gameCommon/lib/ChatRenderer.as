package gameCommon.lib 
{
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import gameCommon.screens.BaseScreen;
	import flash.events.Event;
	import flash.ui.Keyboard;
	import flash.events.TextEvent;
	import flash.events.KeyboardEvent;
	import bingoV1.gameScreen.PrivateChatScreen;
	/**
	 * ...
	 * @author Siddhant
	 */
	public class ChatRenderer extends BaseScreen
	{
		public var _chatField:TextField;
		private var _inputField:TextField;
		public var _chatSubmitFunc:Function;
		public var _textEntered:String;
		private var _lastIndex:int;

		
		private static var _emoRadius:Number = 18;
		private static var _emoRadius1:Number = 25;
		

		//private var emoticons:Array = [":$", ":9", ":b", ":s",":p",":)",":(","bingo"];
		private var emoticons:Array = [":$", ":9", ":b", ":s",":p",":)",":(",":*"];

	//	private var emoticons:Array = [":$", ":9", ":b", ":s",":p",":)",":("];

		
		public function ChatRenderer(chatField:TextField,inpField:TextField,csf:Function = null,emoRadius:Number = 18) 
		{
			_lastIndex = 0;
			_chatField = chatField;
	
			
			_inputField = inpField;
			_chatSubmitFunc = csf;		
			_textEntered = "";
		
			
			addChild(_chatField);			
			this.x = _chatField.x;
			this.y = _chatField.y;
			_chatField.x = 0;
			_chatField.y = 0;
			_emoRadius = emoRadius;
		}
		
		override public function initialize():void
		{
			super.initialize();
			//addGameEventListener(_inputField, TextEvent.TEXT_INPUT, textChanged);
			addGameEventListener(_inputField, KeyboardEvent.KEY_UP, textChanged);
			//addGameEventListener(_chatField, Event.CHANGE, displayTextChanged);
		}
		
		//private function displayTextChanged(evt:TextEvent):void
		//{
			//trace (_chatField.text , " Text changed is ");
		//	parseForEmoticons();
			
		//}
		
		private function textChanged(evt:KeyboardEvent):void
		{			
			
			if (evt.keyCode == Keyboard.ENTER)
			{
				
				if (_textEntered.length > 0 && _chatSubmitFunc != null)
				{
					_chatSubmitFunc(_textEntered);
			
				}
				
				
				_textEntered = "";
				_inputField.text = "";
			}
			else
			{
				_textEntered = evt.currentTarget.text;
			}
		
		}	
		
		
		public function parseForEmoticons():void
		{
			
			var emos:Array = [];
			
			var str:String = _chatField.htmlText;
			
			for (var jj:String in emoticons)
			{
			//	if (j == "bingo")
			//	{
					
					
				//	trace("hjk",str);
			   //str = str.split(emoticons[jj]).join("  "+emoticons[jj]);
			//	}
			 //  emoticons[j] =  emoticons[j] + " ";
				////
			//	trace(str);
			}

			//var substr:String = str.substr(_lastIndex);
			//for (var jj:String in emoticons)
		    //{
			 //str = str.replace(emoticons[jj], "  " + emoticons[jj] + "  ");
			//}
			//str = str.substring(0, _lastIndex) + substr;
			_chatField.htmlText = str;
			
			var normalText:String = _chatField.text;
			//str = normalText;
			
			//trace(normalText, str);
			//trace (_chatField.text , " asdfadf");
			//for (var i:String in emoticons)
			//index = str.indexOf(lastText);
			var i:int;
			var index:int = 0;
			for (i = 0; i < emoticons.length ; ++i)
			{
				index = _lastIndex;
				while (index != -1)
				{
					var curIndex:int = index;
					index = normalText.indexOf(emoticons[i], curIndex);
					if (index == -1)
						index = normalText.indexOf(emoticons[i].toLocaleLowerCase(), curIndex);
				
					if (index != -1)
					{
						emos.push({id:i, index:index, token:emoticons[i]});
						index += emoticons[i].length;
					}
				
				}
			}
		//	trace(str);
			emos.sortOn('index', Array.NUMERIC);
			for (var j:String in emoticons)
			{
			//	if (j == "bingo")
			//	{
					
					
				//	trace("hjk",str);
			   str = str.split(emoticons[j]).join("     ");
			//	}
			 //  emoticons[j] =  emoticons[j] + " ";
				////
			//	trace(str);
			}
			
		
			
			
			_chatField.htmlText = str;
			//return;
			//return;
				// .join("      ");
			//	trace(str);
				
			for (i = 0; i <  emos.length ; ++i)
			{
				_chatField.height += 5;
			//	trace(emos[i].id);
				var charBounds:Rectangle = _chatField.getCharBoundaries(emos[i].index + 3*i + 1);
				_chatField.height -= 5;
				//trace ("Finding char bounds index is " + emos[i].index + " token is " + emos[i].token + " char bound is " + charBounds);
				//trace ("index is ", emos[i].index, " char bounds ", charBounds.x);
				//trace (" Char bounds are ", charBounds);
				var emo:* = new Resources.emoticons();
			//	if (int(emos[i].id) == 7)
			//	{
			//	      emo.width = 30;
			//	}
		//	else
		//		{
				   emo.width = _emoRadius;
			//	}
				emo.height = _emoRadius;
				emo.gotoAndStop(emos[i].id + 1);
				emo.x = charBounds.x  * 99 / 100 - 2;
				emo.y = charBounds.y ;
				addChild(emo);
				//index += emos[i].token.length;
			}
			//_chatField.text = str;
			_chatField.htmlText = str;
			_lastIndex = normalText.length;
		}
	
	}
}