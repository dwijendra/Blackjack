package gameCommon.screens 
{

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import gameCommon.lib.TweenCollection;
	import gameCommon.manager.SceneManager;
	import gameCommon.manager.ScoreManager;
	import gameCommon.objects.GameScore;
	import gameCommon.screens.BaseScreen;
	//import gameCommon.screens.GameScreen;
	//import sameGame.gameObjects.BallObject;
	import flash.events.Event;
	import com.gskinner.motion.GTween;
	//import sameGame.gameScreens.GameEndScreen;
	import gameCommon.lib.Utils;
	import com.gskinner.motion.easing.*;
	
	/**
	 * ...
	 * @author ...
	 */
	public class GameScreen extends BaseScreen
	{
		protected var gameScene:SceneManager;
		protected var gameScore:GameScore;
		protected var gameBkg:*;
		
		public function GameScreen() 
		{
			
		}
		override public function initialize():void
		{
			resetVars();
			setGameScene();			
			resetScore();
			//scoreManager = new ScoreManager();
		}
		
		public function resetVars():void
		{
			gameScene = null;
		}
		
		public function setGameScene():void
		{
			setupBackground();			
			gameScene = new SceneManager();
			addChildAt(gameScene, 1);
			setGameUI();
		}
		
		public function resetScore():void
		{
			gameScore = new GameScore("me");
			gameScore.value = 0;
			//updateScore();
		}
		private function setupBackground():void
		{
			gameBkg = new Resources.gameBkg;
			addChildAt(gameBkg,0);			
		}	
		
		private function setGameUI():void
		{
			var gameUI:* = new Resources.gameUI();

			addChildAt(gameUI, 2);
			screenUI = gameUI;
		}		
	}
	
}