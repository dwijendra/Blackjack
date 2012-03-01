package gameCommon.screens 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import gameCommon.resources.CommonResources;
	import flash.utils.getDefinitionByName;
	import flash.display.DisplayObject;
	
	
	/**
	 * ...
	 * @author ...
	 */
	
	//StartScreen to have 3 basic functionality 
	//first set game UI
	//class will automatically set listeners
	public class StartScreen extends BaseScreen
	{
		protected var gameClassName:String = "GameScreen";
		
		
		public function StartScreen() 
		{
			
			
		}
		
		override public function initialize():void
		{
			//resetVars();
			setStartScene();			
			//resetScore();
			//scoreManager = new ScoreManager();
		}
		
		protected function setStartScene():void
		{
			var startUI:* = new Resources.startUI();
			addChild(startUI);
			screenUI = startUI;
			
			setListeners();
			
		}

		
		protected function setListeners():void
		{
			addGameEventListener(screenUI.playB, MouseEvent.CLICK, playButtonClicked);
			addGameEventListener(screenUI.scoreB, MouseEvent.CLICK, showSocoresClicked);
			addGameEventListener(screenUI.quitB, MouseEvent.CLICK, quitButtonClicked);
		}
		
		private function quitButtonClicked(evt:MouseEvent):void
		{
			quitClicked();
		}
		
		protected function quitClicked():void
		{
			
		}
		
		private function showSocoresClicked(evt:MouseEvent):void
		{
			scoreClicked();
		}
		
		protected function scoreClicked():void
		{
			
		}
		
		private function playButtonClicked(evt:MouseEvent):void
		{
			playClicked();
		}
		
		protected function playClicked():void
		{
			
		}
	}	
}