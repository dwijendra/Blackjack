package bingoV1.gameScreen 
{
	/**
	 * ...
	 * @author dwijendra
	 * 
	 */
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import gameCommon.screens.BaseScreen;
	import multiLanguage.ResizeableContainer;
	import multiLanguage.LanguageXMLLoader;
	import flash.events.MouseEvent;
	import gameCommon.smartFoxAPI.SfsMain;
	import flash.events.TextEvent;
	import flash.events.FocusEvent;
	 import flash.net.navigateToURL;
	 import flash.net.URLRequest;
	 import gameCommon.lib.SoundPlayer;
	import gameCommon.lib.SHA1;	
	public class CashRequest extends BaseScreen
	{ 
		
		public var _amt:Number;
		public var _bgs:*;
		public var sp:Sprite;
		public function CashRequest(bgs:*,fromLooby:Boolean=false) 
		{
			 _bgs = bgs;
			 screenUI = GetDisplayObject.getSymbol("CashAmountScreen");
			 screenUI.blinkSymbol.visible = false;
			  addChild(screenUI);
			  screenUI.totalbalance.text = "0.0";
			  	new Cashier(screenUI);
			screenUI.balance.text = "0.00";
			screenUI.message.visible = false;	
			screenUI.username.text = Main._userName;	
			
			screenUI.tbalance.restrict = "0-9 .";
			screenUI.tbalance.text = "0.00";
			
		    addGameEventListener(screenUI.okb, MouseEvent.CLICK,orderForCash);
			addGameEventListener(screenUI.exitb, MouseEvent.CLICK, removeScrn);
			addGameEventListener(screenUI.paymentB, MouseEvent.CLICK, gotoPayment);
			
			addGameEventListener(screenUI.tbalance, Event.CHANGE,flickerFun);
			
			if (fromLooby)
			{
				screenUI.gamebalance.text = "0.0";
				screenUI.totalbalance.text = "0.0";
				screenUI.backB.visible = false;
				screenUI.outBt.visible = false;
				
				//screenUI.okb.x -= 20;
				
			}
			else
			{
				screenUI.gamebalance.text = getApproxValueToPlaces(Number(_bgs._gameAmount),2);
				screenUI.totalbalance.text = getApproxValueToPlaces(Number(_bgs._gameAmount) + Number(screenUI.totalbalance.text), 2);
				addGameEventListener(screenUI.backB, MouseEvent.CLICK, sendCashBack);
			}
			//addGameEventListener(this, FocusEvent.FOCUS_OUT,focusOut);
			///addGameEventListener(screenUI.tbalance,TextEvent.TEXT_INPUT,textHandler);
			
		}
		private function flickerFun(evt:Event = null):void
		{
			screenUI.blinkSymbol.visible = true;
			return;
			  sp= new Sprite();
			  sp.alpha = .3;
			 sp.graphics.lineStyle(2, 0x0000FF);
             sp.graphics.beginFill(0x000000,0);
             sp.graphics.drawRect(0,0,screenUI.okb.width+10,screenUI.okb.height+10);
			// sp.graphics.drawRect(screenUI.okb.x-5,screenUI.okb.y-5,screenUI.width+10,screenUI.height+10);
	         screenUI.addChild(sp);  
			 sp.x = screenUI.okb.x - 5;
			 sp.y = screenUI.okb.y - 5;
			 sp.mouseEnabled = false;
		}
		private function gotoPayment(evt:MouseEvent):void {
			SoundPlayer.playSound("buttonClick");
			var str:String = GetDisplayObject.getPaymentArray()+ Main._userName;
	//	trace(str);
		var request:URLRequest = new URLRequest(str);
	     	        try {
				           navigateToURL(request, "_blank");
			             } 
		            catch (e:Error)
					     {
						    trace("Error occurred!");
					     }
					
		     removeGameEventListener(screenUI.okb, MouseEvent.CLICK,orderForCash);
			 removeGameEventListener(screenUI.exitb, MouseEvent.CLICK, removeScreen);
			 removeGameEventListener(screenUI.backB, MouseEvent.CLICK,sendCashBack);
			 _bgs.removeCashScreen()			
		}
		
		private function focusOut(evt:FocusEvent):void
		{
			//trace ("Focus OUt");
			//stage.focus = evt.target as InteractiveObject;
		}
		public function removeScrn(e:Event):void
		{
			//SoundPlayer.playSound("buttonClick");
			//_bgs.
			 // removeGameEventListener(screenUI.okb, MouseEvent.CLICK,orderForCash);
			  removeGameEventListener(screenUI.okb, MouseEvent.CLICK,sendCashBack);
			  removeGameEventListener(screenUI.exitb, MouseEvent.CLICK, removeScreen);
			  removeGameEventListener(screenUI.backB, MouseEvent.CLICK,sendCashBack);
			 _bgs.removeCashScreen()
		}
		public function orderForCash(e:Event):void 
		{
			//SoundPlayer.playSound("buttonClick");
			if (screenUI.tbalance.text!=0)
			{
				
				//_amt = Number(screenUI.tbalance.text);
				screenUI.message.visible = false;	
		      var sendParam:Array=["123",Main._password,getApproxValueToPlaces(Number(screenUI.tbalance.text),2)];
			  //var sendParam:Array=["123",SHA1.hex_sha1(Main._password),getApproxValueToPlaces(Number(screenUI.tbalance.text),2)];
			 SfsMain.sfsclient.sendXtMessage("accountExt", "123", sendParam, "str");
			 screenUI.blinkSymbol.visible = false;
			}
		}
		public function sendCashBack(e:Event):void 
		{
			//SoundPlayer.playSound("buttonClick");
			if ((screenUI.tbalance.text!=0))
			{
				//_amt = Number(screenUI.tbalance.text);
				screenUI.message.visible = false;	
		        var sendParam:Array=["124",getApproxValueToPlaces(Number(screenUI.tbalance.text),2)];
			    SfsMain.sfsclient.sendXtMessage("accountExt", "124", sendParam, "str");  
			}
		}
		public function addCash(str:String):void
		{
			screenUI.message.visible = true;;	
			if (str!="-1")
			{
			//screenUI.totalbalance.text = getApproxValueToPlaces(Number(str),2);
			screenUI.gamebalance.text =  getApproxValueToPlaces(Number(str),2);
			screenUI.message.gotoAndStop(1);
			screenUI.balance.text = getApproxValueToPlaces( Number(screenUI.balance.text) - Number(screenUI.tbalance.text), 2);
			screenUI.tbalance.text = "";
			// Main.isFirstLogin;
			}
			else
			{
			   screenUI.message.gotoAndStop(2);
			}
		}
		public function updateCash(str:String):void
		{
			screenUI.message.visible = true;;	
			if (str!="-1")
			{
			//screenUI.totalbalance.text = getApproxValueToPlaces(Number(str),2);
			screenUI.gamebalance.text =  getApproxValueToPlaces(Number(str),2);
			screenUI.message.gotoAndStop(1);
			screenUI.balance.text = getApproxValueToPlaces( Number(screenUI.balance.text) + Number(screenUI.tbalance.text), 2);
			screenUI.tbalance.text = "";
			}
			else
			{
			   screenUI.message.gotoAndStop(2);
			}
		}
		public function resizeScreen(hsf:Number,vsf:Number):void
		{
			screenUI.scaleX = hsf;
			screenUI.scaleY = vsf;
			
		}
	     public function getApproxValueToPlaces(num:Number, numPlaces:int):Number
		{
			var numToBeAdded:Number = 5 / Math.pow(10, numPlaces + 1);
			numToBeAdded *= num < 0 ? -1 : 1;
			var newNum:Number = num + numToBeAdded;
			var tFactor:Number = Math.pow(10, numPlaces);
			var rNum:Number = int(newNum * tFactor) / tFactor;
			return rNum;
		}
		
	}

}