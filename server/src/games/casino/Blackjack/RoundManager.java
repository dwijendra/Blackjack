package games.casino.Blackjack;
import java.util.HashMap;
import games.casino.Blackjack.GameManager.MyTaskHandler;
import it.gotoandplay.smartfoxserver.util.scheduling.Scheduler;
import it.gotoandplay.smartfoxserver.util.scheduling.Task;
import it.gotoandplay.smartfoxserver.util.scheduling.ITaskHandler;
public class RoundManager 
{
	public Scheduler scheduler;
	public ITaskHandler handler;
	public GameManager GManager;
    public int currentPlayerIndex;
    //public boolean requestSent;
    public int totalTime;
    public boolean responseSent;
    public GamePlay gameplay;
    Player currentPlayer;
	RoundManager(GameManager gm)
	{
		//System.out.print("round manager is called++++++++++++++++++++++++");
		responseSent=false;
		gameplay=new GamePlay(this);
		currentPlayerIndex=0;
		GManager=gm;
		totalTime=0;
		gameplay.totalNoOfPlayer=GManager.playerInGame.size();
		stopShedular();
		//startGame();
		
	}
	
	public void startGame()
	{
		gameplay.totalNoOfPlayer=GManager.playerInGame.size();
		 currentPlayerIndex=0;
		
		  for(int j=0;j<GManager.playerInGame.size();j++)
		  {
			 // System.out.print("++++++++++++++++++++++++start game is called++++++++++++++++++++++");
			  //currentPlayer=GManager.playerInGame.get(1);
			  getCurrentPlayer();
			  gameplay.takeAction(currentPlayer,GameConstant.HIT);
			  gameplay.takeAction(currentPlayer,GameConstant.HIT);
			  //currentPlayer.blackJackIndex=0;
			 
			  
		  }
		 // currentPlayer.blackJackIndex=0;
		  currentPlayerIndex=0;
		   selectNextPlayer();
	
		  gameplay.takeAction(GManager.systemPlayer,GameConstant.HIT);
	}
	//public void getCurrentPlayer
	public void handleGameRequest(int cmd,Player pl)
	 {
		if(pl.serverId==currentPlayer.serverId)
		{
			gameplay.takeAction(pl, cmd);
		}
	 }
	public void checkForGameOverAndGetNextPlayer()
	{
		getCurrentPlayer();
		while(currentPlayer.isGameOver())
		{
			getCurrentPlayer();
		}
		
	}
	public void getCurrentPlayer()
	{ 
		//System.out.print("find blackjack next index+++++++++++"+currentPlayer.blackJackIndex);
		if(currentPlayerIndex!=0)
		{
		    if(currentPlayer.getBlackJackNextIndex()==1)
		    {
		       // System.out.print("find blackjack next index+++++++++++"+currentPlayer.blackJackIndex+currentPlayer.name);
			   return;
		    }
		}
		currentPlayerIndex++;
		if(currentPlayerIndex>GManager.playerInGame.size())
		{
			currentPlayerIndex=currentPlayerIndex-GManager.playerInGame.size();
		}
		//System.out.print("current player index+++++++++++++++"+currentPlayerIndex);
		currentPlayer=GManager.playerInGame.get(currentPlayerIndex);
		currentPlayer.blackJackIndex=0;
				
	}
	public void selectNextPlayer()
	{
		  totalTime=0;
		  responseSent=false;
		  stopShedular();
		if(gameplay.totalNoOfPlayer==0)
		{
			return;
		}
		// System.out.print("currentPlayer.blackJackIndex++"+currentPlayer.blackJackIndex+currentPlayer.name);
		if(currentPlayerIndex!=0)
		{
		   GManager.main.sendResponseToAll(GameConstant.TURN,"0"+"-"+currentPlayer.name+"-"+currentPlayer.blackJackIndex+"-"+currentPlayer.index);
		   checkForGameOverAndGetNextPlayer();
		}
		else
		{
			currentPlayerIndex++;
		}
	     currentPlayer=GManager.playerInGame.get(currentPlayerIndex);
		// GManager.main.sendResponseToAll(GameConstant.USERTIMER,totalTime+"-"+currentPlayer.name+"-"+currentPlayer.blackJackIndex);
	    if(currentPlayer.isOnlineP)
	    {
	    	sendInfoToUser();
	    }
	    else
	    {
	    	totalTime=0;
	    	
	    }
	    startShedular();
	  	    
	}
	public void sendInfoToUser()
	{

		 totalTime++;
		
		 if(!responseSent)
         {
			
		      GManager.main.sendResponseToAll(GameConstant.TURN,"1"+"-"+currentPlayer.name+"-"+currentPlayer.blackJackIndex+"-"+currentPlayer.index);
		      responseSent=true;
		   //stopShedular();
		 }
		 GManager.main.sendResponseToAll(GameConstant.USERTIMER,totalTime+"-"+currentPlayer.name+"-"+currentPlayer.blackJackIndex);
		 if(totalTime>20)
		 {
			 //System.out.print("total time is >>>>>>>>>>>>>>>>>>>>>>>>>>>20");
			
			    gameplay.takeAction(currentPlayer,GameConstant.STAND);
						 //selectNextPlayer();
			 }
		// System.out.print("current player name and index"+currentPlayer.name+currentPlayer.blackJackIndex);
	}
	public void startShedular()
	{
		//System.out.print(b);
		scheduler = new Scheduler(1);
		handler = new MyTaskHandler();
		Task generateBall = new Task("waitforOfflineUser");
		scheduler.addScheduledTask(generateBall,1, true, handler);
		scheduler.startService();
	}
	public void stopShedular()
	{   if(scheduler!=null)
	     {
		    //scheduler.stopService();
		    scheduler.destroy(null);
		    scheduler=null;
	      }
	}
	class MyTaskHandler implements ITaskHandler
	{
		public void doTask(Task task) throws Exception
		{
			sendInfoToUser();			
		}
	}
	
	

}
