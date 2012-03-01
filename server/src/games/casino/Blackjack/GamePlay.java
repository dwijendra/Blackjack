package games.casino.Blackjack;

import java.util.Date;

import games.casino.Blackjack.RoundManager.MyTaskHandler;
import it.gotoandplay.smartfoxserver.util.scheduling.ITaskHandler;
import it.gotoandplay.smartfoxserver.util.scheduling.Scheduler;
import it.gotoandplay.smartfoxserver.util.scheduling.Task;

public class GamePlay 
{
	   public ITaskHandler handler;
	   public RoundManager rManager;
	   public int totalNoOfPlayer;
	   Scheduler scheduler;
	   private Date startTime;
	   String game_info[];
	   int dropGame;
	  
	   //public int CurrentPlayerPoint;
	   GamePlay(RoundManager rm)
	   {
		   game_info=new String[10];
		   rManager=rm;
		   dropGame=0;
	   }
	   
	   public void takeAction(Player pl,int cmd)
	   {
		   if(cmd==GameConstant.HIT)
		   {
			   hit(pl);
		   }
		   if(cmd==GameConstant.STAND)
		   {
			   Stand(pl);
		   }
		   if(cmd==GameConstant.DOUBLE)
		   {
			   Double(pl);
		   }
		   if(cmd==GameConstant.SPLIT)
		   {
			   split(pl);
		   }
	   }
	   public int hit(Player pl)
	   {
		  // if(pl.isGameOver())
		  // {
		 
		  // }
		     Card crd=pl.getCard();
		     rManager.GManager.main.sendResponseToAll(GameConstant.HIT,pl.name+":"+pl.getBetAmount()+":"+crd.getcardId()+":"+pl.getPoint1B()+":"+pl.getPoint2B()+":"+pl.blackJackIndex+":"+pl.index);
		     int effectivePoint=getPlayerEffectivePoint(pl);
		     if((effectivePoint==21)&&!pl.name.equals("SYSTEM"))
		     {
		    	 rManager.GManager.main.sendResponseToAll(GameConstant.WIN,pl.name+":"+pl.getBetAmount()+":"+pl.getPoint1B()+":"+pl.getPoint2B()+":"+pl.blackJackIndex+":"+pl.index);
		    	 rManager.GManager.sendCashOutRequest(rManager.currentPlayer,2);
		    	 pl.setGameOver();
		    	 Stand(pl);
		     }
		     if((effectivePoint>21)&&!pl.name.equals("SYSTEM"))
		     {
		    	// pl.setGameOver();
		    	 
		    	// System.out.print("+++++++++++++++haar gaye ab to ab dekho kya hota hai++++++++++++++++");
		    	 pl.setIsWin("LOSE");
		    	 pl.setWinAmount(0.0);
		    	 rManager.GManager.main.sendResponseToAll(GameConstant.LOSE,pl.name+":"+pl.getBetAmount()+":"+pl.getPoint1B()+":"+pl.getPoint2B()+":"+pl.blackJackIndex+":"+pl.index); 
		    	 pl.setGameOver();
		    	 Stand(pl);
		     }
		  	 return getPlayerEffectivePoint(pl);
		   
	   }
	   public int getPlayerEffectivePoint(Player pl)
	   {
		   int num1=pl.getPoint1B();
		    int num2=pl.getPoint2B();
		    if(num2<=21)
		    {
		    	return num2;
		    }
		    else
		    {
		    	return num1;
		    }
	   }
	   public void split(Player pl)
	   {
		   if(!pl.cansplit())
		   {
			  // System.out.print("what is the value++++++++cansplit++++++++++++++++++");
			  return; 
		   }
		   if(rManager.GManager.deductBalance(pl._betAmount, pl)!=1)
		   {
			 //  System.out.print("what is the value++++++++++deductBalance++++++++++++++++");
			   return;
		   }
		//   System.out.print("what is the value++++++++++click split++++++++++++++++");
		    pl.splitB();
		   rManager.GManager.main.sendResponseToAll(GameConstant.SPLIT,pl.getplayerInfo());
		   totalNoOfPlayer++; 
		   hit(pl);
		   
	   }
	   public void Stand(Player pl)
	   {
		  
		   totalNoOfPlayer--; 
		  
		   if(totalNoOfPlayer==0)
		   {
			  gameEnd(); 
		   }
		   else
		   {
			  // System.out.print("+++++select next player is called+++++++++++++++++++");
			   rManager.selectNextPlayer();
		   }
	   }
	   public void Double(Player pl)
	   {
		   if(rManager.GManager.deductBalance(pl._betAmount,pl)==1)
		   {
		         pl.AddAmount(pl.getBetAmount());
		         rManager.GManager.main.sendResponseToAll(GameConstant.DOUBLE,pl.name+":"+pl._betAmount+":"+ pl.getPoint1B()+":"+pl.getPoint2B()+":"+pl.blackJackIndex+":"+pl.index);
		         if(hit(pl)<21)
		         {
			       Stand(pl);   
		         }
		         
		   }
	   }
	   public void endGameForPlayer(int i)
	   {
		   
	   }
	   public void gameEnd()
	   {
		  //rManager.GManager.systemPlayer.getPoint1B();
		   rManager.stopShedular();
		  int i=getPlayerEffectivePoint(rManager.GManager.systemPlayer);
		  
		//  System.out.print("what is the value++++++++++++++++++++++++++"+i);
		  
		 while(i<17)
		  {
		    i= hit( rManager.GManager.systemPlayer);
		  }
		  rManager.currentPlayerIndex=0;
		  rManager.getCurrentPlayer();
		  for(int j=0;j<rManager.GManager.playerInGame.size();j++)
		  {
			  //System.out.print("what is the value++++++++++++++++++++++++++"+i);
			 int k=0;
			 while(k<rManager.currentPlayer.blackJackPlayers.size())
			 {
				       k++;
			           if(i>21)
			            	{
			        	    	if(!rManager.currentPlayer.isGameOver())
			        	   	    {
			        	    		 System.out.print("hsdjfsd hi win");
			        	   	    rManager.currentPlayer.setIsWin("WIN");
			        	   	    rManager.currentPlayer.setWinAmount(rManager.currentPlayer.getBetAmount()*2);
			        	   		rManager.GManager.sendCashOutRequest(rManager.currentPlayer,2);
			        	   		rManager.GManager.main.sendResponseToAll(GameConstant.WIN,rManager.currentPlayer.name+":"+rManager.currentPlayer.getBetAmount()+":"+ rManager.currentPlayer.getPoint1B()+":"+rManager.currentPlayer.getPoint2B()+":"+rManager.currentPlayer.blackJackIndex+":"+rManager.currentPlayer.index);
			        	    	}
			        	   	
			           	  }
			           else
			           	{
			        	 if(getPlayerEffectivePoint(rManager.currentPlayer)>=i)
			        	     {
			        	   	// if win money equals bet*2 added to amount
			        	   	//in case of draw it becomes equal to bet
			        	    	int multiply=2;
			        	    	if(!rManager.currentPlayer.isGameOver())
			        	    	{
			        	    	       if(getPlayerEffectivePoint(rManager.currentPlayer)==i)
			        	                {
			        	    	       multiply=1;
			        	   	           rManager.currentPlayer.setIsWin("DRAW");
			        	   	        System.out.print("hsdjfsd hi drwa");
			        	   	           rManager.currentPlayer.setWinAmount(rManager.currentPlayer.getBetAmount());
			        	   	          rManager.GManager.main.sendResponseToAll(GameConstant.DRAW,rManager.currentPlayer.name+":"+rManager.currentPlayer.getBetAmount()+":"+rManager.currentPlayer.getPoint1B()+":"+rManager.currentPlayer.getPoint2B()+":"+rManager.currentPlayer.blackJackIndex+":"+rManager.currentPlayer.index);
			    	                	}
			        	    	      else
			        	   	          {
			        	    	    	System.out.print("hsdjfsd hi winner");
			        	   		      rManager.currentPlayer.setIsWin("WIN");
				        	   	      rManager.currentPlayer.setWinAmount(rManager.currentPlayer.getBetAmount()*2);
			        	   		      rManager.GManager.main.sendResponseToAll(GameConstant.WIN,rManager.currentPlayer.name+":"+rManager.currentPlayer.getBetAmount()+":"+ rManager.currentPlayer.getPoint1B()+":"+rManager.currentPlayer.getPoint2B()+":"+rManager.currentPlayer.blackJackIndex+":"+rManager.currentPlayer.index);
			        	   	           }
			        	   	          rManager.GManager.sendCashOutRequest(rManager.currentPlayer,multiply);
			        	       }
			        	    }
			             else
			                {
			            	   if(!rManager.currentPlayer.isGameOver())
			            	     {
			            		   System.out.print("hsdjfsd hi loser");
			            		 rManager.currentPlayer.setIsWin("LOSE");
				        	   	 rManager.currentPlayer.setWinAmount(0.0);
				                 rManager.GManager.main.sendResponseToAll(GameConstant.LOSE,rManager.currentPlayer.name+":"+rManager.currentPlayer.getBetAmount()+":"+rManager.currentPlayer.getPoint1B()+":"+rManager.currentPlayer.getPoint2B()+":"+rManager.currentPlayer.blackJackIndex+":"+rManager.currentPlayer.index);
			            	    }
			               }
		               }
			         rManager.getCurrentPlayer();
			       }
		  }
		  rManager.GManager.createInfoForGameRecords();
		 
		  startShedular(); 
	   }
	   
	   public void DestroyGame()
	   {
		   if(dropGame==1)
		   {
			    
			   stopShedular();   
		       rManager.GManager.main.destroyGame(); 
		   }
		   dropGame++;
	   }
	   
		public void startShedular()
		{
			//System.out.print(b);
			scheduler = new Scheduler(1);
			handler = new MyTaskHandler();
			Task generateBall = new Task("waitforOfflineUser");
			scheduler.addScheduledTask(generateBall,2, true, handler);
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
				DestroyGame();	
			}
		}

}
