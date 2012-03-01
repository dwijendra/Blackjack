package bingoV1.gameScreen 
{
	import gameCommon.smartFoxAPI.SfsMain;
	/**
	 * ...
	 * @author Siddhant
	 */
	//Mantains ignore user list 
	//private chat manager checks whether user is blocked or not
	public class IgnoreUserManager
	{
		static public var _ignoredUserA:Object;		
		private static var _userList:Object;
		
		public function IgnoreUserManager() 
		{			
			
		}
		
		static public function initialize(ul:UserList):void
		{
			_userList = ul;
			_ignoredUserA = new Object();
		}
		
		static public function parseIgnoreString(str:String):void
		{
			if (str == null)
				return;
			
			var splitArray:Array = str.split(",");
			for (var i:int = 0; i < splitArray.length; ++i)
			{
				if (splitArray[i].length > 0)
				{
					_ignoredUserA[splitArray[i]] = "1";
				}
			}
		}
		
		public static function addIgnoredUser(userName:String,ignore:Boolean):void
		{
			//trace ("Add ignore user called for user name", userName);
			if (ignore)
			{
				_ignoredUserA[userName] = "1";
			}
			else
			{
				_ignoredUserA[userName] = null;
			}
			var bingoUser:BingoUser = _userList.getUserByName(userName);
			if (bingoUser)
			{
				bingoUser.setUserBlocked(ignore);				
			}
			setIgnoreUserString();
		}
		
		public static function setIgnoreUserString():void
		{
			var ignoreString:String = "";
			for (var name:String in _ignoredUserA)
			{
				if (_ignoredUserA[name] == "1")
				{
					ignoreString += name + ",";					
				}
			}
			var uVars:Object = new Object();
			uVars["IU"] = ignoreString;
			//trace ("Sending ignore user string ", ignoreString);
			SfsMain.sfsclient.setUserVariables(uVars);			
		}
		
		public static function isUserBlocked(userName:String):Boolean
		{
		//	if (_ignoredUserA[userName] == "1")
		//		return true;
		//		
			return false;	
			//var bingoUser:BingoUser = _userList.getUserByName(userName);
			//return bingoUser._isBlocked;			
		}
	}

}