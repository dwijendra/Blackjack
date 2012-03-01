package bingoV1.gameScreen 
{
	import bingoV1.gameScreen.PrivateChatManager;
	import gameCommon.screens.BaseScreen;
	import flash.events.MouseEvent;
	import multiLanguage.ResizeableContainer;
	import multiLanguage.LanguageXMLLoader;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.text.TextFieldAutoSize;
	//import CustomSlider;
	import gameCommon.customUI.ScrollPane;
	import gameCommon.smartFoxAPI.SfsMain;
	import flash.events.FocusEvent;
	import flash.text.TextFieldType;
	import gameCommon.lib.ChatRenderer;
	 import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;
	/**
	 * ...
	 * @author Siddhant
	 */
	public class PublicChatScreen extends BaseScreen
	{
		//private var _userName:String;
		private var _bingoScreen:BingoGameScreen;
		
		private var _scrollPane:ScrollPane;
		public var _screen:*;
		private var _chatOnOffScreen:*;
		private var _chatEnabled:Boolean;
		public var _chatInput:*;
		private var _chatRenderer:ChatRenderer;
		private var format:TextFormat; 
		private var hsf1:Number;
		private var vsf1:Number;
		private var visibleH:Number;
		private var visibleW:Number;
		public function PublicChatScreen(bs:BingoGameScreen) 
		//public function PrivateChatScreen(userName:String) 
		{
			_bingoScreen = bs;
			//screenUI = new Resources.publicChatScreen();
			  screenUI = GetDisplayObject.getSymbol("publicChatScreen");
			  _screen = screenUI;
			_chatInput = screenUI.chatInput;
			_chatEnabled = true;
			//screenUI.chatDisplay = 0Xffffff;
			// format = new TextFormat();
           // format.font = "Arial";
           // format.color = 0x9d3292;
           // format.size = 12;
            //format.underline = true;
			//screenUI.chatDisplay.defaultTextFormat = format;
			//addGameEventListener(screenUI.closeB, MouseEvent.CLICK, closeClicked);
			//addGameEventListener(screenUI.ignoreB, MouseEvent.CLICK, ignoreClicked);
			//screenUI.userName.text = userName;
			addChild(screenUI);
			var cr:ChatRenderer = new ChatRenderer(screenUI.chatDisplay, screenUI.chatInput, submitChat);
			addChild(cr);
			_chatRenderer = cr;
			
			addGameEventListener(screenUI.chatOnOffB, MouseEvent.CLICK, showChatOnOffScreen);
			
			screenUI.chatDisplay.autoSize = TextFieldAutoSize.CENTER;
			screenUI.chatDisplay.wordWrap = true;
		
			screenUI.chatDisplay.text = "";
			screenUI.chatInput.text = "";
			//ResizeableContainer.setTextToUI(screenUI, LanguageXMLLoader._loadedXML.GameRoom.Room);	
			//new CustomSlider(0, 100, screenUI.chatDisplay, null, 0);
			visibleH = screenUI.bottomP.y - screenUI.topP.y;
			visibleW = screenUI.bottomP.x- screenUI.topP.x;
			var sp:ScrollPane = new ScrollPane(visibleW,visibleH, _chatRenderer, screenUI.chatSlider);
			//sp.x = screenUI.chatDisplay.x;
			//sp.y = screenUI.chatDisplay.y;
			addChild(sp);
			_scrollPane = sp;
			_chatOnOffScreen = null;
			screenUI.cb.visible = false;
			//screenUI.chatDisplay.textFormat	
			
			/*var format:TextFormat = new TextFormat();
            format.font = "Verdana";
            format.color = 0xFF0000;
            format.size = 10;
            format.underline = true;*/

           // label.defaultTextFormat = format;

			addGameEventListener(screenUI.sendB, MouseEvent.CLICK, sendMsg);
			
			//ResizeableContainer.setTextToUI(screenUI, LanguageXMLLoader._loadedXML.PrivateChatScreen);
			//addGameEventListener(this,KeyboardEvent.KEY_UP, keyPressed);
		}
		
		override public function initialize():void
		{
			stage.focus = screenUI.chatInput;
			//stage.focus = ci;
			var ci:* = screenUI.chatInput;
			ci.setSelection(ci.length, ci.length);
			ci.stage.focus = ci;
		}
		
		public function resizeScreen(hsf:Number,vsf:Number):void
		{
			hsf1 = hsf;
			vsf1 = vsf;
			 //screenUI.chatDisplay.scaleX=hsf;
			//screenUI.chatDisplay.scaleY=vsf;
			visibleH = (screenUI.bottomP.y - screenUI.topP.y)*vsf;
			_scrollPane._visibleHeight = visibleH;
			_scrollPane.setMask();
			_scrollPane.setFullScroll();
			//_scrollPane.changeUI(screenUI,screenUI.height,screenUI.width);
			screenUI.scaleX = hsf;
			screenUI.scaleY = vsf;
			if (_chatOnOffScreen)
			{
				removeChatOnOffScreen();
			      chatOnOff();
			}
			
			
		}
		
		private function showChatOnOffScreen(evt:MouseEvent):void
		{
			if (_chatOnOffScreen)
			{
				removeChatOnOffScreen();
			}
			else
			{
				chatOnOff();
				
			}
		}
		private function chatOnOff():void
		{
			_chatOnOffScreen = new Resources.chatOnOff();
				
				_chatOnOffScreen.x = screenUI.chatOnOffP.x*hsf1;
				_chatOnOffScreen.y = screenUI.chatOnOffP.y*vsf1;
				addChild(_chatOnOffScreen);
				
				if (_chatEnabled)
					setChatEnabled();
				else
					setChatDisabled();
					
				//addGameEventListener(_chatOnOffScreen.onB, MouseEvent.CLICK, setChatEnabled );
				//addGameEventListener(_chatOnOffScreen.offB, MouseEvent.CLICK, setChatDisabled);
				addGameEventListener(_chatOnOffScreen.closeB, MouseEvent.CLICK, removeChatOnOffScreen );
		}
		
		private function setChatEnabled(evt:MouseEvent = null):void
		{
			_chatEnabled = true;
			screenUI.cb.visible = false;
			screenUI.cb.alpha = .3;
			//screenUI.chatInput.editable = true;
			//screenUI.chatDisplay.enabled = true;
			if (_chatOnOffScreen)
			{
				removeGameEventListener(_chatOnOffScreen.onB, MouseEvent.CLICK, setChatEnabled );
				addGameEventListener(_chatOnOffScreen.offB, MouseEvent.CLICK, setChatDisabled);
				_chatOnOffScreen.onB.enabled = false;
				_chatOnOffScreen.offB.enabled = true;				
			}
		}
		
		private function setChatDisabled(evt:MouseEvent = null):void
		{
			_chatEnabled = false;
			screenUI.cb.visible = true;
			//screenUI.chatInput.editable = false;
			//screenUI.chatDisplay.enabled = false;
			if (_chatOnOffScreen)
			{
				addGameEventListener(_chatOnOffScreen.onB, MouseEvent.CLICK, setChatEnabled );
				removeGameEventListener(_chatOnOffScreen.offB, MouseEvent.CLICK, setChatDisabled);
				_chatOnOffScreen.onB.enabled = true;
				_chatOnOffScreen.offB.enabled = false;				
			}
		}
		
		private function removeChatOnOffScreen(evt:MouseEvent = null):void
		{
			removeChild(_chatOnOffScreen);
			_chatOnOffScreen = null;
		}
		
		private function sendMsg(evt:MouseEvent):void
		{
			
			if (_chatRenderer._textEntered.length >0 && _chatRenderer._chatSubmitFunc !=null)
			{
				submitChat(_chatRenderer._textEntered);
			}
			_chatRenderer._textEntered = "";
			screenUI.chatInput.text = "";
		}
		
		public function submitChat(msg:String):void
		{
			trace("msg", msg,ServerConstants.CHAT);
			
				//if (Main.isRealPlay && BingoGameScreen.chatStatus==1)
				{
					// trace("msg", msg,ServerConstants.CHAT);
			    	//SfsMain.sfsclient.sendPublicMessage(msg + "\n");
					  var sendParam:Array = [ServerConstants.CHAT, msg];
					  trace("kya huaparsm",sendParam)
		               SfsMain.sfsclient.sendXtMessage("chatExt", ServerConstants.CHAT, sendParam, "str");
				}
		
		}
		
		private function ignoreClicked(evt:MouseEvent):void
		{			
		}
		
		private function closeClicked(evt:MouseEvent):void
		{			
			removeScreen();
			//_chatManager.privateChatClosed(_userName);
		}
		
		public function addChatMessage(msg:String,isUserAdmin:Boolean = false):void
		{
			var temp:TextFormat;
			var temp1:TextFormat;
			var temp2:TextFormat;
			var mydate:Date = new Date();
			
			
			var time:String = String(mydate.getHours()) + ":" + String(mydate.getMinutes() < 10 ? "0" + mydate.getMinutes():mydate.getMinutes());
			
			if (_chatEnabled)
			{
				//screenUI.chatDisplay.text += _userName + " : " + msg;
				var xyz:Array = msg.split(":");
				if (xyz[0]=="" || xyz[0]=="-1" )
				{
					//trace (" herer setting initial");
					temp = new TextFormat();
					temp.size = 12;
					
					// “CartoonSmart <font color=\u0022#”
					//screenUI.chatDisplay.html = true;
					//trace (isUserAdmin, " is user admin");
					if(xyz[0]=="-1")
					{
					    screenUI.chatDisplay.htmlText +=  "<font color='#b93fba' >" + time +" " + GetDisplayObject.getBonusP1() +"<h1>" + (Number(xyz[1])).toFixed(2) + "</h1>" + GetDisplayObject.getBonusP2() + " </font>"; 
						
					}
					else
					{
						screenUI.chatDisplay.htmlText +=  "<font color='#b93fba' >" + time + " " + msg + "</font>"; 
						
					}

						
					 //temp.color = 0xb93fba;
					
					screenUI.chatDisplay.embedFonts = true;
					//screenUI.chatDisplay.defaultTextFormat = temp;
					//screenUI.chatDisplay.setTextFormat(temp, 0, xyz[1].length - 1); 
					//screenUI.chatDisplay.text = msg; 
					
				}
				else
				{
					//temp1=new TextFormat();
					//temp1.color = 0xFF0000;
					//temp1.size = 12;
					//temp1.bold = false;
					var info:String;
					if (isUserAdmin)
						info =  "<font color='#CC0099'>" + time + " " + msg + "</font>"; 
					else	
						info =  "<font color='#000000'>" + time + " " + msg + "</font>"; 
					 //var info:String="<font color='#000000'>"+time+msg+"</font>"; 
					screenUI.chatDisplay.htmlText += info;
					//screenUI.chatDisplay.setTextFormat(temp1, screenUI.chatDisplay.text.length-xyz[0].length,screenUI.chatDisplay.text.length-1); 
					
					//temp2=new TextFormat();
					//temp2.color = 0xFF0000;
					//info="<font color='#000000'>"+xyz[1]+"</font>";
					//screenUI.chatDisplay.htmlText += info;  
					//screenUI.chatDisplay.setTextFormat(temp2, screenUI.chatDisplay.text.length- xyz[1].length,screenUI.chatDisplay.text.length-1); 
					
				  
				}

				
				_scrollPane.setFullScroll();
				_chatRenderer.parseForEmoticons();
				
			}
		}		
	}
}