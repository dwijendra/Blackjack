package bingoV1.lobbyScreen 
{
	import gameCommon.objects.BaseObject;
	import multiLanguage.ResizeableContainer;
	/**
	 * ...
	 * @author 
	 */
	public class RoomSymbol extends BaseObject
	{
		public static const _symbolHeight:Number = 70;
		
		public function RoomSymbol() 
		{
			mouseChildren = false;
		}
		
		public function initialize(roomNumber:int,desc:String,cardPrice:String,maxUsers:String,status:Boolean):void
		{
			
		}
		
		public function updateBallPassed(ballsPassed:String):void
		{
			
		}
		
		public function updateStatus(status:Boolean):void
		{
			
		}
		
		public function updateCurrentUsers(currentUsers:String):void
		{
			
		}
		

	}

}