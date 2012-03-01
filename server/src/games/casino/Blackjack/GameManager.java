package games.casino.Blackjack;
//main game code............................................................
import java.util.*;

import games.casino.Blackjack.GameStatus.States;
import it.gotoandplay.smartfoxserver.data.User;
import it.gotoandplay.smartfoxserver.data.UserVariable;
//import it.gotoandplay.smartfoxserver.extensions.ExtensionHelper;
//import games.casino..GameStatus.States;
import it.gotoandplay.smartfoxserver.util.scheduling.Scheduler;
import it.gotoandplay.smartfoxserver.util.scheduling.Task;
import it.gotoandplay.smartfoxserver.util.scheduling.ITaskHandler;
import it.gotoandplay.smartfoxserver.data.RoomVariable;
import java.math.*;
import java.text.SimpleDateFormat; 

import javax.xml.transform.Templates;
public class GameManager 
{	
	BingoMain main;
	Scheduler scheduler;
	ITaskHandler handler;
	String game_info[];
	int totalNoOfCardInGame;
	int noOfPlayer;
	long timer;
	public TotalCardPack CardPack;
	private Date startTime;
	public Double totalStakeAmount;
	private boolean isGamerunning;
	public int maxPlayer;
	public int minPlayerRequired;
	public Double maxBet;
	public Double minBet;
	public HashMap<Integer,Player> players; 
	public HashMap<Integer,Player> playerInGame; 
	public int Pattern;
	public GameStatus game;
	public BingoDbm bingoDbm;
    int timeBetweenBalls = 1;
    public RoundManager rManager;
    public Player systemPlayer;
    public int gameid;
	GameManager()
    {
		
	}
	public String getTotalPlayersName()
	{
		String name="";
		Set  set = players.entrySet();
		Iterator<Map.Entry<Integer, Player>> playerIter = set.iterator();
		while(playerIter.hasNext())
		{
			Map.Entry<Integer, Player> tmpEntry = (Map.Entry<Integer, Player>)playerIter.next();
			Player tmpPlayer = tmpEntry.getValue();
			if(name=="")
			{
				 name=tmpPlayer.name;
			}
			else
			{
				 name=tmpPlayer.name+","+name;
			}
			//if(!tmpPlayer.isOnlineP)
			
			
		} 
		//System.out.print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&s"+name);
		return name;
	}
	GameManager(BingoMain v1,BingoDbm pbingodbm)
	{
		players =new HashMap<Integer,Player>();
		playerInGame =new HashMap<Integer,Player>();
		bingoDbm= pbingodbm;
		game_info=new String[10];
		CardPack=new TotalCardPack(8);	
		game=new GameStatus();
		noOfPlayer=0;
		totalStakeAmount=0.0;
		this.main=v1;
		systemPlayer=new Player(CardPack);
		minPlayerRequired=main.gameRoom.getVariable("minpl").getIntValue();
		maxPlayer=main.gameRoom.getVariable("mp").getIntValue();
		maxBet=main.gameRoom.getVariable("mxb").getDoubleValue();
		minBet=main.gameRoom.getVariable("mnb").getDoubleValue();
	  	timer = main.inBetweenRoomTimerValue;
	  	gameid=-1;
		init();
		setcplRoomVariable();
		 rManager=new RoundManager(this);
		// System.out.print("kkkkkkkkkkkkk  "+maxBet+"  kkk  "+minBet);
	}
	
	public void setcplRoomVariable()
	{
		HashMap<String,RoomVariable> roomVarMap=new HashMap<String,RoomVariable>(); 
		RoomVariable cplVar = new RoomVariable(Integer.toString(noOfPlayer),"n",null,true,true);
		roomVarMap.put("cpl", cplVar);
		main.helper.setRoomVariables(main.gameRoom, null,roomVarMap, true, true);		
	}
	public void init()
	{
		
		scheduler = new Scheduler(1);
		handler = new MyTaskHandler();
		Task generateBall = new Task("generateBall");
		scheduler.addScheduledTask(generateBall, 1, true, handler);
		scheduler.startService();
	}
	public void setOfline(int id)
	{
		   Player tempPlayer=players.get(id);	
		   if (tempPlayer != null)
		   tempPlayer.isOnlineP=false;
	}
		
	public String getTotalPlayerInfo()
	{
		String nameNcards="";
		Set  set = players.entrySet();
		Iterator<Map.Entry<Integer, Player>> playerIter = set.iterator();
		while(playerIter.hasNext())
		{
			Map.Entry<Integer, Player> tmpEntry = (Map.Entry<Integer, Player>)playerIter.next();
			Player tmpPlayer = tmpEntry.getValue();
			if(nameNcards=="")
			{
				nameNcards=tmpPlayer.getplayerInfo();
				
			}
			else
			{
				nameNcards=nameNcards+":"+tmpPlayer.getplayerInfo();
			}
		} 
		//System.out.print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&s"+name);
		return nameNcards;
	}
	public String setOnline(int id,User u)
	{
	//	System.out.print("set on line  is called");
		if(players.containsKey(id))
		{
			Player tempPlayer=players.get(id);
			tempPlayer.isOnlineP=true;
			u.setVariable("id",Integer.toString(id),UserVariable.TYPE_STRING);
			tempPlayer.user=u;
		}
		String str=getgamestatus(id);
		return str;

	}
	public void createInfoForGameRecords()
	   {
		   if(gameid != -1)
		   {
			   Calendar cal = Calendar.getInstance();
				  SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				  String   date= sdf.format(cal.getTime());
				game_info[0]= date;
				game_info[1]=main.gameRoom.getVariable("rid").getValue();
				game_info[2]= Integer.toString(noOfPlayer);
			    game_info[3]=  getTotalPlayerGameRecords();
			    game_info[4]=Double.toString(totalStakeAmount);
			    game_info[5]=systemPlayer.blackJackPlayers.get(systemPlayer.blackJackIndex).cardString;
			    bingoDbm.updateGameRd(game_info,gameid);
		   }
	   }
	public String getTotalPlayerGameRecords()
	{
		String nameNcards="";
		Set  set = players.entrySet();
		Iterator<Map.Entry<Integer, Player>> playerIter = set.iterator();
		while(playerIter.hasNext())
		{
			Map.Entry<Integer, Player> tmpEntry = (Map.Entry<Integer, Player>)playerIter.next();
			Player tmpPlayer = tmpEntry.getValue();
			System.out.println("tmpPlayer.name"+tmpPlayer.name+"hii+++"+tmpPlayer.blackJackPlayers.get(tmpPlayer.blackJackIndex).cardString);
			if(nameNcards=="")
			{
				nameNcards=tmpPlayer.name+","+tmpPlayer.blackJackPlayers.get(tmpPlayer.blackJackIndex).cardString;
				if(!tmpPlayer.isSystem)
				 totalStakeAmount = tmpPlayer.getBetAmount();
				bingoDbm.updateEachUserGameRecords(tmpPlayer.setGameRecords(gameid));
				 
			}
			else
			{
				nameNcards=nameNcards+":"+tmpPlayer.name+","+tmpPlayer.blackJackPlayers.get(tmpPlayer.blackJackIndex).cardString;
				if(!tmpPlayer.isSystem)
				 totalStakeAmount =totalStakeAmount + tmpPlayer.getBetAmount();
				bingoDbm.updateEachUserGameRecords(tmpPlayer.setGameRecords(gameid));
			}
		} 
		//System.out.print("&&&&&&&&&&&&&&&&&&&&&&&&&&s"+nameNcards);
		return nameNcards;
	}
	public void setAutomate(int id)
	{
		if(players.containsKey(id))
		{
			Player tmpPlayer=players.get(id);
			
		}
	 }
	public void handleGameRequest(User u,int cmd)
	{
		if(game.state==States.GAMEON)
		{
		   int id=u.getVariable("id").getIntValue();
		   if(players.containsKey(id))
		    {
		       Player pl=players.get(id);
		       rManager.handleGameRequest(cmd,pl);
		    }
		}
	}
	public void sendCashOutRequest(Player p,int i)
	{
		// i=1 for draw
		//i=2  for  win 
		           main.sendResponseToAll(6,p.name+","+p.blackJackIndex);
		           User juser=p.user;
		           int id=p.serverId;
		           if((main.currentZone.getUserByName(juser.getName())==null)) 
		           { 		 
		        	   if(!(main.sendOutRequest(juser,0.0,roundOff(p.getBetAmount()*i,2)).equals("0")))
			             {
		        	        	 bingoDbm.setFailedBalance(id,0.0, roundOff(p.getBetAmount()*i,2));   
			             }
		      	        	  	              
	                }
		           else
		           {
	                     juser= main.currentZone.getUserByName(juser.getName());               	
		       	    	 updateUserWinVariable(juser,p.getBetAmount()*i);   
		    	 
		           }
		     
			
	}
	public String addPlayer(Player p)
	{
		//Player abc=new Player(u,Pattern);
		int sid=p.user.getVariable("id").getIntValue();
		players.put(sid,p);
		noOfPlayer++;
		playerInGame.put(noOfPlayer,p);
		p.index=noOfPlayer;
		setcplRoomVariable();
		main.setCurrentPlayers(noOfPlayer);
		main.sendResponseToAll(9,p.name+","+p.index+","+p.getBetAmount()+","+p.blackJackIndex);
		//System.out.print("add player response  sent to all user..................");
		return "";
	}
	public String getgamestatus(int i)
	{
		String res=getTotalPlayerInfo()+":"+systemPlayer.getplayerInfo();
		return res;
	}
	public String makeDeal(Double amount,User u)
	{ 
		int sid=u.getVariable("id").getIntValue();
		String response="";
		if(amount == 0||players.containsKey(sid)||(noOfPlayer==maxPlayer))
		{
			return response;
		}
		Player player;
		 player=new Player(u,CardPack,amount);
		if((game.state!=States.GAMEON)&&(deductBalance(amount, player)==1))
		{ 
			 
			  addPlayer(player); 
			  
			 // player.getCard();
			 // player.getCard();
			 // player._betAmount=amount;
			  response+=player.name+","+noOfPlayer+","+player._betAmount;
 		}
		return response;
	}
	public int deductBalance(Double amt,Player pl)
	{
		User u=pl.user;
		
		int sid=u.getVariable("id").getIntValue();
		int flag=0;
		 Double cost= amt;
		 Double CashBalance =Double.valueOf(u.getVariable("cashB").getValue().trim()).doubleValue();
		 Double winBalance =Double.valueOf(u.getVariable("winB").getValue().trim()).doubleValue(); 
		 if(winBalance<cost)
		 {
			 	cost=cost-winBalance;
			 	winBalance=0.0;
			 	if(CashBalance>=cost)
			 	{
			 			CashBalance-=cost;
			 			flag=1;
			 	}
		 }
		 else
		 {
			 winBalance-=cost;
			 flag=1;
		 }
		 CashBalance=roundOff(CashBalance, 2);
		 winBalance=roundOff(winBalance, 2);
		 if(flag==1)
		 {
		   u.setVariable("cashB",Double.toString(CashBalance),UserVariable.TYPE_STRING);
		   u.setVariable("winB",Double.toString(winBalance),UserVariable.TYPE_STRING);
		    bingoDbm.setBalance(sid, CashBalance, winBalance);
		    //pl.AddAmount(amt);
		    main.sendResponseToUser(21,Double.toString(CashBalance)+","+Double.toString(winBalance), u);
		 }
		 return flag;
		
	}
		
	//public String finallyPurchage(User u,int noOfCard,Double CashBalance,Double winBalance)
	//{
		
	//}
	
	public void isOnline(int sid ,boolean status)
	{
		Player player= players.get(sid);
		player.isOnlineP=status;
		main.sendResponseToAll(9,player.name);

	}
	
	public void isRealPlayer(int sid ,boolean status)
	{
		Player player= players.get(sid);
		player.isRealP=status;
		

	}
	public void updateUserWinVariable(User u,Double amount)
	{
		    //System.out.print("++++++++++user is on line+++++++++++++");
			 Double CashBalance =Double.valueOf(u.getVariable("cashB").getValue().trim()).doubleValue();
			 Double winBalance =Double.valueOf(u.getVariable("winB").getValue().trim()).doubleValue(); 
			 int uid=u.getVariable("id").getIntValue();
			 winBalance+=amount;
			 winBalance=roundOff(winBalance,2);
			 bingoDbm.setBalance(uid, CashBalance, winBalance);
			 u.setVariable("winB",Double.toString(winBalance),UserVariable.TYPE_STRING);
			 main.sendResponseToUser(21,Double.toString(CashBalance)+","+Double.toString(winBalance),u);
					
	}

	class MyTaskHandler implements ITaskHandler
	{
		public void setGameOver()
		{
			main.destroyGame();
			destroy();
		}
		int check=0;
		
			
		
		/*private void updateGameinfo(Boolean wonJackpot)
		{
			java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat( "yyyy-MM-dd HH:mm:ss" );   
		    String sdate=sdf.format(startTime);  
			game_info[0]=sdate;
			game_info[1]=main.gameRoom.getVariable("rid").getValue();
			game_info[2]= Integer.toString(noOfPlayer);
			game_info[3]=Double.toString(totalStakeAmount);
			bingoDbm.updateGameRecord(game_info,wonJackpot);
		}*/
		
		
		
		public void doTimerTask()
		{

			//System.out.println("do timer task++++in gamemanager++++++++++++++++++++"+timer);

			if(main.getOwnerZone().equals("Blackjack_Duch"))
			{
			// System.out.println("do timer task++++in gamemanager++++++++++++++++++++"+timer+main.getOwnerZone());
			}

			if(timer>=0)
			{
				if(noOfPlayer==maxPlayer)
				{
					timer=0;
					main.sendResponseToAll(0, Long.toString(timer));
					main.setGameStatus(0);
					game.state=States.GAMEON;
					return;
				}
				main.sendResponseToAll(0, Long.toString(timer));
				
				timer--;
				main.settimerValue(timer);
				return;
			}	
			else if(noOfPlayer<minPlayerRequired)
			{
				
				timer= main.inBetweenRoomTimerValue;
				main.sendResponseToAll(0, Long.toString(timer));
				timer--;
				return;
				//game.state=States.NOPLAYER;
			}
			else
			{
				main.setGameStatus(0);
				game.state=States.GAMEON;
			}
		}
		
		public void doTask(Task task) throws Exception
		{
			if(game.state == States.TIMER)
			{
				doTimerTask();
			}
			else
			{
				destroy();
				createRoundManager();
				
			}
			
		}
	}
	 public void createRoundManager()
	 {
		// systemPlayer=new Player(CardPack);
		// systemPlayer.getCard();
		// systemPlayer.getCard();
		//System.out.print("&&&&&&&&&&&&&&round manager&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
		 gameid= bingoDbm.getGameId();
		 rManager.startGame();
		
		
	 }
	public double roundOff(Double val, int n) 
	{
		long v1=(long)(val*Math.pow(10,n));
		double v2=val*Math.pow(10,n)-v1;
		if(v2>=.5)
		{
			v1=v1+1;
		}
		return (double)v1/Math.pow(10,n);
		
	}
	public void destroy()
	{
		//scheduler.stopService();
		scheduler.destroy(null);
		//scheduler=null;
	}
}
