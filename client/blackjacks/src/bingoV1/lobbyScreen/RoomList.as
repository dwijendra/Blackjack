package bingoV1.lobbyScreen 
{
	import flash.display.Sprite;
	import gameCommon.screens.BaseScreen;
	import flash.display.Graphics;
	/**
	 * ...
	 * @author Siddhant
	 */
	public class RoomList extends BaseScreen
	{
		
		private var _roomListArray:Array;
		private static const _maxRooms:int = 25;
		private var _roomHolder:Sprite;
		private var _roomMask:Sprite;
		private var _slidervalue:Number = 0.0;
		private var _maskH:Number = 0;
	
		
		public function RoomList() 
		{
			_roomListArray = new Array(_maxRooms);
			screenUI = new Resources.lobbyslider();
			addChild(screenUI);
			//DrawMask();
		}
		
		
		public function updateRoom(roomInfo:Object):void
		{
			var roomId:int = int(roomInfo.rid);
			//things that can be updated current users, balls passed , status
			//trace("UPDATE IS CALLED++++++++++++++++@@@@@@@@@@@",roomId);
			var room:RoomSym = _roomListArray[roomId];
			if (room)
			{
				
				
				room.updateCurrentUsers(roomInfo);
				room.updateStatus(roomInfo);	
			}
		}
		
		private function setSlider():void
		{
			//var customslider:CustomSlider = new CustomSlider(0,_roomHolder.height-600, screenUI.bidSlider,changeFunc, 2);
		}
		
		private function changeFunc(sliderValue:Number,sliderPosX:Number):void
		{
			var ind:int = int(sliderValue);
			var diff:int=_slidervalue-sliderValue
			
			//trace(_roomHolder.height+_roomHolder.y, "index,,,,,,,,,,");
			
			if (_roomHolder.height>600)//&&)
			{
				
				_roomHolder.y = -sliderValue;
			}
			else
			{
				//_roomHolder.y = sliderValue;
			}
			
		}
		public function addRoom(roomObj:Object,roomName:String):void
		{
			var roomId:int = roomObj.rid;
			var room:RoomSym = new RoomSym(roomObj, roomName);
			//trace("roomId------------>", roomId);
			//room.initialize(roomId, roomObj.desc, roomObj.cardPrize, roomObj.maxUsers, roomObj.status);
			_roomListArray[roomId] = room;
		}
		
	
		public function showRooms():void
		{
			if (_roomHolder)
			{
				removeChild(_roomHolder);
			}
				
			_roomHolder = new Sprite();
			var currentY:Number = 0.0;
			
			for (var i:int = 0 ; i < _roomListArray.length; ++i)
			{
				if (_roomListArray[i])
				{
					_roomHolder.addChild(_roomListArray[i]);
					_roomListArray[i].y = currentY;
					//trace("currenty  ", currentY);
					currentY += RoomSym._symbolHeight;
				}
			}
			//addChild(_roomMask);
			addChild(_roomHolder);
			//_roomHolder.mask = _roomMask
			
			//setSlider();
		
		}
		private function DrawMask():void
		{
			_roomMask = new Sprite();
            addChild(_roomMask);
           _roomMask.graphics.lineStyle(3,0x00ff00);
           _roomMask.graphics.beginFill(0x0000FF);
           _roomMask.graphics.drawRect(0,0,562,425);
			_roomMask.visible = false;
		}
	}

}