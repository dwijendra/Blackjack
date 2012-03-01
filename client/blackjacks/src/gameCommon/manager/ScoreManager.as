 package gameCommon.manager 
{
	import flash.net.SharedObject;
	import gameCommon.objects.GameScore;
	import gameCommon.lib.SharedObjectManager;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ScoreManager 
	{
		//array to store all the scores
		
		//var sharedScoreObject:SharedObject;
		static private var scoreArray:Array;
		
		public function ScoreManager() 
		{
			scoreArray = new Array();
			//initialize();
			
		}
		
		//initialize the score array
		static public function initialize():void
		{
			var sharedScoreObject:SharedObject = SharedObjectManager.getScoreSharedObject();

			if (sharedScoreObject.data.sA == null)
			{
				sharedScoreObject.data.sA = new Array();
				SharedObjectManager.saveSharedObject(sharedScoreObject);
			}
			//else
			//	scoreArray = new Array();
		}
		
		static public function addNewScore(newScore:GameScore):void
		{
			var sharedScoreObject:SharedObject = SharedObjectManager.getScoreSharedObject();
			var scoreArray:Array = sharedScoreObject.data.sA as Array;
			scoreArray.push(GameScore.getObjectForScore(newScore));

			//scoreArray.push(newScore);
			//sharedScoreObject.data.sA = scoreArray;
			//SharedObjectManager.saveSharedObject(sharedScoreObject);
		}
		
		static public function get scores():Array
		{
			/*var sharedScoreObject:SharedObject = SharedObjectManager.getScoreSharedObject();
			var scoreArray:Array = sharedScoreObject.data.sA;
			if (scoreArray == null)
				scoreArray = new Array();
			//scoreArray.push(newScore);*/
			var sharedScoreObject:SharedObject = SharedObjectManager.getScoreSharedObject();
			var scoreObjArray:Array = sharedScoreObject.data.sA as Array;
			var scoreArray:Array = new Array();
			for (var i:int = 0; i < scoreObjArray.length; ++i)
			{
				scoreArray.push(GameScore.getScoreForObject(scoreObjArray[i]));
			}
			scoreArray.sortOn("value", Array.DESCENDING | Array.NUMERIC);
			//if (scoreArray == null)
			//	scoreArray = new Array();
			return scoreArray;			
		}
		
		static public function get highScore():GameScore
		{
			var scoreArray:Array = ScoreManager.scores;
			//var sharedScoreObject:SharedObject = SharedObjectManager.getScoreSharedObject();
			//var scoreArray:Array = sharedScoreObject.data.sA;
			//trace (GameScore(scoreArray[0])  + " ScoreArray");
			//if (scoreArray == null)
			//	scoreArray = new Array();
			//scoreArray.sortOn("value", Array.DESCENDING | Array.NUMERIC);	
			if (scoreArray && scoreArray.length > 0)
			{
				return scoreArray[0] as GameScore;
			}
			return null;
		}
		
		/*protected function getScoreArray():Array
		{
			sharedScoreObject = SharedObjectManager.getSharedObjectByName("SgScores");
			var scoreArray:Array;
			if (sharedScoreObject.data.sA)
			{
				scoreArray  = sharedScoreObject.data.sA;
			}
			else
				scoreArray = new Array();
				
			return scoreArray;	
			
		}*/
		
	}
	
}