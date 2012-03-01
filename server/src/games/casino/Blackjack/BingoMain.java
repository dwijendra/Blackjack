package games.casino.Blackjack;
//mainGame code.......................................................

import it.gotoandplay.smartfoxserver.data.Room;
import it.gotoandplay.smartfoxserver.data.RoomVariable;
import it.gotoandplay.smartfoxserver.data.User;
import it.gotoandplay.smartfoxserver.data.UserVariable;
import it.gotoandplay.smartfoxserver.data.Zone;
import it.gotoandplay.smartfoxserver.db.DataRow;
import it.gotoandplay.smartfoxserver.events.InternalEventObject;
import it.gotoandplay.smartfoxserver.extensions.AbstractExtension;
import it.gotoandplay.smartfoxserver.extensions.ExtensionHelper;
import it.gotoandplay.smartfoxserver.extensions.ISmartFoxExtension;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
import it.gotoandplay.smartfoxserver.util.scheduling.ITaskHandler;
import it.gotoandplay.smartfoxserver.util.scheduling.Scheduler;
import it.gotoandplay.smartfoxserver.util.scheduling.Task;
//import p
import java.nio.channels.SocketChannel;
import java.text.ParseException;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.Map;
import java.util.Set;

import javax.xml.ws.Dispatch;
public class BingoMain  extends AbstractExtension
{
	AbstractExtension ext;
	private Scheduler scheduler;
	private MyTaskHandler handler;
	public Room gameRoom;
	public ExtensionHelper helper;
	public Zone currentZone;
	public RequestHttp _rhttp;
	public int _maxCard;
	public int rId;
	GameManager newgame;
	public HashMap<Integer,Player> automatePlayers; 
	public long inBetweenRoomTimerValue=60;
    public boolean destroyRoom=false;
    public HashMap robj;
    //public Bonus bonus;
    public String _URLstring;
    public GetUrlClass _GURLC;
	@Override 
	public void init()
	{
		//trace("Extension initialized 6.7");
		helper = ExtensionHelper.instance();
	   _rhttp=new RequestHttp();
	    currentZone=helper.getZone(getOwnerZone());
	    // currentZone.setPubMsgInternalEvent(true);
		automatePlayers =new HashMap<Integer,Player>();
		_GURLC=new GetUrlClass(getOwnerZone());
		// main.sendResponseToAll(104,_GURLC);
		_URLstring=_GURLC.getUrl();
		gameRoom = helper.getZone(getOwnerZone()).getRoomByName(getOwnerRoom());
		rId=gameRoom.getVariable("rid").getIntValue();
		//_maxCard = gameRoom.getVariable("mcp").getIntValue();
		Zone currentZone = helper.getZone(getOwnerZone());
	    //Zone currentZone = ExtensionHelper.instance().getZone(getOwnerZone());
	    ISmartFoxExtension iext = currentZone.getExtManager().get("zoneExt");
		 ext = (AbstractExtension)iext;
		 restartGame(); 			
	}
	public String sendOutRequest(User u,Double cashB,Double winB)
	{
		 int id=u.getVariable("id").getIntValue();
		double totalAmount=cashB*100+winB*100;
		//String url="http://game-03.globalstarsgames.com/mtransfer/out.php";
		String url="http://management.globalstarsgames.com/webservice/v1transfer/out.php";
		String data="url="+_URLstring+"/TransferOutRequest&client_session_id=7967858765675&timestamp=123&account_id="+u.getVariable("id").getValue()+"&amount="+totalAmount+"&transaction_id=123456&licensee_reverse_password=123456&deposit_pot="+cashB*100+"&winning_pot="+winB*100;
		String str="1";
		 str=_rhttp.SendRequest(url,data);
		 if(str.equals("0"))
		 {
			 newgame.bingoDbm.insertMoneyTransaction(id,"out",cashB,winB,"0");
		 }
		 else
		 {
			 newgame.bingoDbm.insertMoneyTransaction(id,"out",cashB,winB,"1");
		 }
		 return str;
	}
	/*public String getBackground(Room rm)
	{
		 int id=gameRoom.getVariable("rid").getIntValue();
		 int id1=id;
		 if(id==25)
		 {
		   id1= gameRoom.getVariable("jid").getIntValue();
		 }
		 newgame.bingoDbm.getBackground(id,id1);
    	DataRow dr1=newgame.bingoDbm.bg.get(0);
         return dr1.getItem("BACKGROUND");
			
	}*/
	public void sendDestroyMsgToZone()
	{
		robj=new HashMap<Integer,Room>();
		robj.put(0,2);
		robj.put(1,gameRoom);
		ext.handleInternalRequest(robj);
		
	}
	
	class MyTaskHandler implements ITaskHandler
    {  
          public void doTask(Task task) throws Exception
          {
        	 // handlejackpot();  
          }
    }
	public Object handleInternalRequest(Object obj)
	{
		    HashMap objMap=(HashMap)obj;
		    if(objMap.get(0).equals("4"))
		    {
		    	
		    }
		    if(objMap.get(0).equals("6"))
		    {
		    	destroyRoomFinally();
		    }
		    if(objMap.get(0).equals("7"))
		    {
		    	//trace("sbadnmsdfhkjhgjlhuytkj");
		    	setJackpotTimeUserVariable((String)objMap.get(1));
		    }
		    if(objMap.get(0).equals("8"))
		    {
		    	String str=objMap.get(1).toString();
		    //	trace("id in main "+str);
		    	//trace("id in main "+str+newgame.players.containsKey(Integer.parseInt("str")));
		    	if(newgame.players.containsKey(Integer.parseInt(str)))
		    	{
		    		//trace("id in main in if");
		    		return "1";
		    		
		    	}
		    	else
		    	{
		    		//trace("id in main in else");
		    		return "0";
		    	}
		    }
		    if(objMap.get(0).equals("501"))
		    {
		    	 return Integer.toString(currentZone.getRoomByName(getOwnerRoom()).getUserCount());
		    }
	
		    return null;
	}
	 public void initialize()
     {		    
         //scheduler = new Scheduler();
        // handler = new MyTaskHandler();
         //Task HandleJackpot = new Task("handleJackpot");
         //Task TimerTask = new Task("TimerTask");
        // scheduler.addScheduledTask(HandleJackpot, 3, true, handler);
         // scheduler.addScheduledTask(TimerTask, 5, false, handler);
        // scheduler.startService();    
     }
	void sendResponseToAll(int cmd,String obj)
	{
		//trace("cmd+obj ++++++++++++++++++++"+cmd+"dsfdsjhgfd"+obj);
		String aobj[]={Integer.toString(cmd),obj};
		LinkedList<SocketChannel> userList = gameRoom.getChannellList();
		sendResponse(aobj, gameRoom.getId(), null,userList );
	} 
	public void sendUserToLobby()throws Exception
	{
		User u[]= gameRoom.getAllUsers();
		for(int i=0;i<u.length;i++)
		{
			helper.joinRoom(u[i],gameRoom.getId(),helper.getZone(getOwnerZone()).getRoomByName("Lobby1").getId(), true,"", false,true);
			//helper.joinRoom(usr, currRoom, newRoom, leaveRoom, pword, isSpectator, broadcast)o
			
		}
	}
	

	void destroyGame()
	{
	   // robj=new HashMap();
		//robj.put(0,1);
		//robj.put(1,gameRoom);
        //boolean bl=Boolean.valueOf(ext.handleInternalRequest(robj).toString());
		//String str=ext.handleInternalRequest(robj).toString();
		//System.out.print("string is"+str+"is string");
	
		//if(str.equals("1"))
		//{
		 // destroyRoomFinally();
			
		//}
		//else
	   // {
			
			restartGame();
		//}
			
	}
	public void setJoinPermission(String str)
	{
		 HashMap<String,RoomVariable> roomVarMap=new HashMap<String,RoomVariable>();
		 RoomVariable join = new RoomVariable(str,"s",null,true,true);
		 roomVarMap.put("joinP", join);
		 helper.setRoomVariables(gameRoom, null,roomVarMap, true, false);
	}
	public void destroyRoomFinally()
	{
		try
		{
			 setJoinPermission("0");
			if((gameRoom.getUserCount()==0))
			{
			   sendDestroyMsgToZone();
			   return;
			}
			destroyRoom=true;	
		  
		   sendUserToLobby();
		}
		catch(Exception e)
		{
			
		}
		
	}
	
	public void playJackpot()
	{
		Calendar currentdate=Calendar.getInstance();
		long jdate=Long.parseLong(gameRoom.getVariable("jd").getValue());
		inBetweenRoomTimerValue=(jdate-currentdate.getTimeInMillis());
		inBetweenRoomTimerValue=inBetweenRoomTimerValue/1000;
		
	}
	public void playNormal()
	{
	//	if(newgame != null)
			//trace("hia all++++++++++++++++++");
		newgame=null;
		newgame=new GameManager(this,BingoDbm.getBingoDBM(getOwnerZone()));
		String str1;
		sendUserListToAll();
		//automatePlayers=new HashMap<Integer,Player>();
	}
	
	void restartGame()
	{
		//destroyGame();
		setGameStatus(1);
		setNumBallsPassed(0);
		playNormal();
		
	}
	
	void sendResponseToUser(int cmd,String obj,User u)
	{
		//trace("jai hind");
		String aobj[]={Integer.toString(cmd),obj};
		LinkedList<SocketChannel> list=new LinkedList<SocketChannel>();
		list.add(u.getChannel());
		sendResponse(aobj, u.getRoom(),null, list);
		//trace("response sent.....................to the client"+list.size());
	}

	public void handleRequest(String cmd, String[] params, User u, int fromRoom)
	{
		int i=u.getVariable("id").getIntValue();
		String type =u.getVariable("type").getValue();
		String str1="";
		int cmdValue = Integer.parseInt(params[0]);
		if(cmdValue==0 &&type.equals("real"))
		{
			//System.out.print(i+"number purchage...............................");
			Double dealAmount=Double.parseDouble(params[1]);
           // Player temp=newgame.players.get(i);
			str1=newgame.makeDeal(dealAmount,u);
			if(str1.equals(""))
			{
				str1="-1";
			}
			sendResponseToUser(GameConstant.DEAL, str1,u);
		}
		else if (cmdValue == GameConstant.GAMESTATE)
		{
			//trace ("Game State request recieved");
			 sendAllUserList(u);
			 String str=newgame.getgamestatus(i);
			 String blockedUser=u.getVariable("IU").getValue();
			 String CashBalance =u.getVariable("cashB").getValue().trim();
			 String winBalance =u.getVariable("winB").getValue().trim(); 
			 sendResponseToUser(21,newgame.roundOff(Double.parseDouble(CashBalance), 2)+","+newgame.roundOff(Double.parseDouble(winBalance), 2),u);
			 sendResponseToUser(22,blockedUser,u);
			 sendResponseToUser(23,gameRoom.getVariable("wMsg").getValue(), u);
			 sendResponseToUser(GameConstant.GAMESTATE,str, u);
			// sendResponseToUser(201,gameRoom.getVariable("TI").getValue(), u);
			// sendResponseToUser(26,getBackground(gameRoom), u);
		}
		else
		{
			newgame.handleGameRequest(u,cmdValue);
		}
		
		/*if(cmdValue==1)
		{
			newgame.setAutomate(i);
		}*/
	}
	
	public void sendJackpotTimeToAll()
	{
		 Calendar currentdate=Calendar.getInstance();
		 long jdate=Long.parseLong(gameRoom.getVariable("jd").getValue());
			
			if(jdate!=-1)
			{
				
			jdate=(jdate-currentdate.getTimeInMillis());
			jdate=jdate/1000;
		 //   System.out.print(jdate+"jdate is printed");
		  
			}
			//.0System.out.print("jackpot$$$$$$$$$$$$$$$$$$$$$$ date"+Long.toString(jdate));
			 sendResponseToAll(24,Long.toString(jdate));
	}
	
	public void setJackpotTimeUserVariable(String JackpotDate)
	{
		//
		if(rId!=25)
		{
			//trace("++++++++++jackpot is executed++++++++++++++++++");
		 HashMap<String,RoomVariable> roomVarMap=new HashMap<String,RoomVariable>();
		 RoomVariable jDate = new RoomVariable(JackpotDate,"s",null,true,true);
		 roomVarMap.put("jd", jDate);
		 helper.setRoomVariables(gameRoom, null,roomVarMap, true, false);
		 sendJackpotTimeToAll();
		}
	}
	
	public void setRoomVariable(int noOfSentBall,int noOfCurrentPlayer)
	{
		//helper = ExtensionHelper.instance();
		HashMap<String,RoomVariable> roomVarMap=new HashMap<String,RoomVariable>(); 
		RoomVariable bpRv = new RoomVariable(Integer.toString(noOfSentBall),"n",null,true,true);
		RoomVariable cplRv = new RoomVariable(Integer.toString(noOfCurrentPlayer),"n",null,true,true);
		roomVarMap.put("cpl", cplRv);
		roomVarMap.put("bpass", bpRv);
		//gameRoom = helper.getZone(getOwnerZone()).getRoomByName(getOwnerRoom());
		helper.setRoomVariables(gameRoom, null,roomVarMap, true, false);
	}
	public void settimerValue(long _timer)
	{
		HashMap<String,RoomVariable> roomVarMap=new HashMap<String,RoomVariable>(); 
		RoomVariable timerRV = new RoomVariable(Long.toString(_timer),"n",null,true,true);
		roomVarMap.put("tm", timerRV);
		helper.setRoomVariables(gameRoom, null,roomVarMap, true, false);		
	}
	
	public void setNumBallsPassed(int numBallsSent)
	{
		HashMap<String,RoomVariable> roomVarMap=new HashMap<String,RoomVariable>(); 
		RoomVariable bpRv = new RoomVariable(Integer.toString(numBallsSent),"n",null,true,true);
		roomVarMap.put("bpass", bpRv);		
		helper.setRoomVariables(gameRoom, null,roomVarMap, true, true);		
	}
	
	public void setCurrentPlayers(int numCurrentPlayers)
	{
		HashMap<String,RoomVariable> roomVarMap=new HashMap<String,RoomVariable>(); 
		RoomVariable cplRv = new RoomVariable(Integer.toString(numCurrentPlayers),"n",null,true,true);
		roomVarMap.put("cpl", cplRv);
		helper.setRoomVariables(gameRoom, null,roomVarMap, true, false);		
	}
	
	
	public void setGameStatus(int newstatus)
	{
		String strs = "" + newstatus;
		//newstatus --- 1 TIMER_RUNNING , ---- 0 GAME_RUNNING
		Integer status = new Integer(newstatus);
		//trace (status.toString() + " Status dumped");
		RoomVariable rsRV = new RoomVariable(strs,"n",null,true,true);
		HashMap<String,RoomVariable> roomVarMap=new HashMap<String,RoomVariable>();
		roomVarMap.put("rs", rsRV);
		helper.setRoomVariables(gameRoom, null,roomVarMap, true, true);		
	}

	public void handleRequest(String cmd, ActionscriptObject ao, User u,int fromRoom)
	{
	}
	public void  sendUserListToAll()
	{
		String Name=null;
	    Name=newgame.getTotalPlayersName();
	    sendResponseToAll(8, Name);
	
	}
	public void sendAllUserList(User u)
	{
		String Name=null;
	   Name=newgame.getTotalPlayersName();
	    //trace(Name);
	  //  System.out.println("above is the list of total user&&&&vipul"+Name+"above is the list of total user");
	    sendResponseToUser(8,Name,u);
	}

	public void handleInternalEvent(InternalEventObject ieo)
	{
		String evtname = ieo.getEventName();
		String str="";
   		ActionscriptObject ao = new ActionscriptObject();
		if (evtname.equals("userJoin"))
		{
			User joinedUser = (User)ieo.getObject("user");
			int i=joinedUser.getVariable("id").getIntValue();
			String userType=joinedUser.getVariable("id").getValue();
			if(newgame.players.containsKey(i))
			{
				newgame.setOnline(i, joinedUser);
			}
			str=newgame.getgamestatus(i);
		}
		else if ( evtname.equals("userLost") || evtname.equals("logOut"))
		{
			User juser = (User)ieo.getObject("user");
			int id=juser.getVariable("id").getIntValue();
			 String ulist=juser.getVariable("IU").getValue();
			// trace("blocked user list given below>>>>>>>>>>>>>>"+ulist);
			newgame.setOfline(id);
			newgame.bingoDbm.setBlockedUser(id, ulist);
		}
		else if(evtname.equals("userExit"))
		{
			
			User juser = (User)ieo.getObject("user");
			int id=juser.getVariable("id").getIntValue();
			String ulist=juser.getVariable("IU").getValue();
			newgame.setOfline(id);
			newgame.bingoDbm.setBlockedUser(id, ulist);
			if((gameRoom.getUserCount()==0)&&destroyRoom)
			{
				sendDestroyMsgToZone();
			}
					 
		}
	}
}
