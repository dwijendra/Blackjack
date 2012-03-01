package gameCommon.objects 
{
	//import flash.utils.IExternalizable;
	//import flash.utils.IDataOutput;
	//import flash.utils.IDataInput;
	
	/**
	 * ...
	 * @author ...
	 */
	public class GameScore 
	{
		 protected var scoreValue:int;
		 protected var user:String;
		
		public function GameScore(uname:String = "Default",pvalue:int = 0) 
		{	
			user = uname;
			scoreValue = pvalue;
		}
		
		public function set value(svalue:int):void
		{
			scoreValue = svalue;
		}
		public function get value():int
		{
			return scoreValue;
		}
		public function get userName():String
		{
			return user;
		}

	   static public function getObjectForScore(score:GameScore):Object
	   {
		   var scoreObj:Object = new Object();
		   scoreObj.v = score.value;
		   scoreObj.u = score.userName;
		   return scoreObj;
	   }  
	   
	   static public function getScoreForObject(scoreObj:Object):GameScore
	   {
		   var rscore:GameScore = new GameScore(scoreObj.u, scoreObj.v);
		   return rscore;
	   }   


	}
	
}