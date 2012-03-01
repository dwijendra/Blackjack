package games.casino.Blackjack;
//main game code...................................................................
import games.casino.Blackjack.GameManager.MyTaskHandler;
import games.casino.Blackjack.GameStatus.States;
import it.gotoandplay.smartfoxserver.data.Room;
import it.gotoandplay.smartfoxserver.data.User;
import it.gotoandplay.smartfoxserver.data.UserVariable;
import it.gotoandplay.smartfoxserver.data.Zone;
import it.gotoandplay.smartfoxserver.db.DataRow;
import it.gotoandplay.smartfoxserver.events.InternalEventObject;
import it.gotoandplay.smartfoxserver.exceptions.LoginException;
import it.gotoandplay.smartfoxserver.extensions.AbstractExtension;
import it.gotoandplay.smartfoxserver.extensions.ExtensionHelper;
import it.gotoandplay.smartfoxserver.extensions.ExtensionManager;
import it.gotoandplay.smartfoxserver.extensions.ISmartFoxExtension;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
import it.gotoandplay.smartfoxserver.util.scheduling.ITaskHandler;
import it.gotoandplay.smartfoxserver.util.scheduling.Scheduler;
import it.gotoandplay.smartfoxserver.util.scheduling.Task;

import java.nio.channels.SocketChannel;
import java.text.ParseException;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.ListIterator;
import java.util.Map;
import java.util.Set;
import it.gotoandplay.smartfoxserver.data.RoomVariable;

public class ZoneLevelExtension extends AbstractExtension {
	
	public String testServelet;
	private ExtensionHelper helper;
	private Zone currentZone;
	private Scheduler scheduler;
	private MyTaskHandler handler;
	private BingoDbm bingoDbm;
	public HashMap<Integer,String> activeRoomSet=new HashMap<Integer,String>();
	private String activeRooms; 
    private int roomTtype;
    private Boolean jAvailable;
	private String JackpotDate="-1";
	public String jackpot_amount;
	public String jackpot_balls;
    public AbstractExtension ext;
    public HashMap robj;
	public void init()
	{
		helper = ExtensionHelper.instance();
		currentZone=helper.getZone(getOwnerZone());
		bingoDbm=BingoDbm.getBingoDBM(getOwnerZone());
		sendDbManager();
		roomTtype=0;
		initialize();
		//trace("kya aaya----===========================================-"+currentZone+"aur"+helper+""+getOwnerZone());
	}
	public void sendDbManager()
	{
		   ISmartFoxExtension iext = currentZone.getExtManager().get("accountExt");
	       ext = (AbstractExtension)iext;
	     // 
		   robj=new HashMap();
		   robj.put(0,bingoDbm.getDBmanager());
		   ext.handleInternalRequest(robj);
		  // trace("cash___________robj___________________________________"+robj);
	}
	
	@Override
	public void handleRequest(String arg0, ActionscriptObject arg1, User arg2, int arg3) {
		
	}

	void sendResponseToUser(int cmd,String obj,User u)
	{
		//trace("jai hind");
		String aobj[]={Integer.toString(cmd),obj};
		LinkedList<SocketChannel> list=new LinkedList<SocketChannel>();
		list.add(u.getChannel());
		sendResponse(aobj, u.getRoom(),null, list);
		//trace("response sent.....................to the client"+list);
	}
	void sendMsgToAllRoom(String obj)
	{
		//trace("jai hind");
		String aobj[]={"102",obj};
		LinkedList<SocketChannel> list=new LinkedList<SocketChannel>();
		LinkedList lList=currentZone.getRoomList();
		 ListIterator itr = lList.listIterator();
		 while(itr.hasNext())
		 {
		    Room rm=(Room)(itr.next());
		    if(!(rm.getName().equals("Lobby1")))
		    {
		    	sendResponse(aobj,-1,null,rm.getChannellList());	
		    }
	     }
		
	}
	void sendResponsetochannel(int cmd,String obj,LinkedList<SocketChannel> list) 
	{
		//trace("jai hind");
		String aobj[]={Integer.toString(cmd),obj};
		sendResponse(aobj,-1,null, list);
		//trace("response sent.....................to the client");
	}

	private Object handleModeratorRequest(String msgRcv)
	{
		//trace("Moderator Command : "+msgRcv);
         String result="0";
		if(msgRcv.length() <= 1 )
		{
			//trace("ILLEGAL Moderator Command - "+msgRcv);
			return "0";
		}

		String []splits = msgRcv.split(":");
		Zone z =currentZone;
		User u = null;
		Room gameRoom = null;
		ActionscriptObject aobj = null;
		RoomVariable var = null;
		HashMap variables = null;

		switch(Integer.valueOf(splits[0]))
		{
			case 1: //Recharge user account
				if(Integer.valueOf(splits[1])>0&&Double.valueOf(splits[2])>0.0)
				{
				  result= bingoDbm.updateBalance(Integer.valueOf(splits[1]),Double.valueOf(splits[2]));
				 
				}
				else
				{
					return "0";
				}
				break;
			case 2: // change Room Active Status
				
				if((splits[1] == null) || (splits[1].length() <= 0) || (splits[2] == null) || (splits[2].length() <= 0))
					return "0"; 
			     result= bingoDbm.setActiveStatus(splits[1],splits[2]);
				break;
			case 3: // Banning User
				
				String uname = splits[1];
				u = z.getUserByName(uname);

				helper.kickUser(u, 0, "");
				break;

			case 4: // Dynamic bonus announcement from admin 
				
				if((splits[1] == null) || (splits[1].length() <= 0) || (splits[2] == null) || (splits[2].length() <= 0))
					return "0";
				gameRoom = z.getRoomByName(splits[1]);
				ISmartFoxExtension iext = gameRoom.getExtManager().get("gameExt");
				AbstractExtension ext = (AbstractExtension)iext;
				HashMap robj=new HashMap();
				robj.put(0,"4");
				robj.put(1,splits[2]);
				ext.handleInternalRequest(robj);
				LinkedList<SocketChannel> userList = gameRoom.getChannellList();
				sendResponsetochannel(104,splits[2], userList);
				break;

			case 5:
				//++++++++++++++++changing user chat status+++++++++++++
				
				u = z.getUserByName(splits[1]);

				bingoDbm.banUserChat(splits[1],splits[2]);

				if(u!=null)
				{
				    sendResponseToUser(101,splits[2], u);
					u.setVariable("chatS",splits[2],UserVariable.TYPE_STRING);
				}
				else
				{
					//trace("Banning User from chat but User Object could not be found");
				}

				break;
			case 6:
				//Send admin message to everyone in Zone
				gameRoom = z.getRoomByName(splits[1]);
				//activeRoomSet.remove(gameRoom.getVariable("rid").getIntValue()); 
				ISmartFoxExtension iext1 = gameRoom.getExtManager().get("gameExt");
				AbstractExtension ext1 = (AbstractExtension)iext1;
				HashMap robj1=new HashMap();
				robj1.put(0,"6");
				//robj1.put(1,splits[2]);
				ext1.handleInternalRequest(robj1);
             	break;

			case 7:
				//Personal message from admin to user
				
				u = z.getUserByName(splits[1]);
				if(u!=null)
				{
					sendResponseToUser(103,splits[2], u);
				}
				else
				{
					//trace("Sending personal message to user but User Object could not be found");
				}

				break;
			case 8: //This is used in Star Bingo. Not in 75 Ball Bingo
				break;
			case 10:
				//System.out.print("php is called here(((((((((()))))))))))"+msgRcv);
				if(splits.length>=8)
				{
				   result=bingoDbm.setBalanceOnadminReq(splits[1],Double.parseDouble(splits[2]),Double.parseDouble(splits[3]),splits[4],splits[5],splits[6],splits[7]);
				}
				break;
			case 11:
				if(splits.length>=4)
				{
				     Room rm=currentZone.getRoomByName(splits[1]);
				     HashMap<String,RoomVariable> roomVarMap=new HashMap<String,RoomVariable>(); 
					 RoomVariable bWinRv = new RoomVariable(splits[2],"s",null,true,true);
					 RoomVariable pWinRv = new RoomVariable(splits[3],"s",null,true,true);
					 roomVarMap.put("wMsg", bWinRv);
					 roomVarMap.put("announcement", pWinRv);
					 bingoDbm.setMsg(splits[1],splits[2],splits[3]);
				//	System.out.print("value of the variables in the room...."+cardValue+amountInGame+bingoP+patternP);
					helper.setRoomVariables(rm, null,roomVarMap, true, true);
				}
					break;
			case 12:
				sendMsgToAllRoom(splits[1]);
				break;
			case 501:
				gameRoom = z.getRoomByName(splits[1]);
				//activeRoomSet.remove(gameRoom.getVariable("rid").getIntValue());
				 iext1 = gameRoom.getExtManager().get("gameExt");
				 ext1 = (AbstractExtension)iext1;
				 robj1=new HashMap();
				robj1.put(0,"501");
				//robj1.put(1,splits[2]);
			   return ext1.handleInternalRequest(robj1);		
			
			}
		return result;
	}

	
	@Override
	public Object handleInternalRequest(Object obj)
	{      
		  // String result="0";
		    HashMap objMap=(HashMap)obj;
		    if(objMap.get(0).equals("fromAdmin"))
		    {
		     return	handleModeratorRequest((String)objMap.get(1));	
		    }
		    else
		    {
		    	 Room robj = (Room)objMap.get(1);
		    	  	
		       if(objMap.get(0).toString().equals("2"))
		       {
		    	       if( helper.destroyRoom(helper.getZone(getOwnerZone()),robj.getId()))
		    	       {
		    	    	   sendRoomUpdateStatus();
		    	       }
		 		    
		       }
		       if(objMap.get(0).toString().equals("1"))
		       {
		    	  	int rid=robj.getVariable("rid").getIntValue();
		    	    if(bingoDbm.getRebootStatus( rid)==1)
		    	    {
		    	    	 bingoDbm.setRebootStatus(rid);
		    	    	 	 return "1";
		    	    }
		    	    else
		    	    {
		    	    	return "0";
		    	    }
		       
		       }
		    	
		    }
		
		    return null;	
	}

	@Override
	public void handleRequest(String cmd, String[] params, User user, int roomId) {
		
		int cmdValue = Integer.parseInt(params[0]);
		if(cmdValue==7)
		{
			sendStatusToAll();	
		}
		//String evtname = evt.getEventName();
 	      String str="";
 	  //  trace ("event rcvd");
	}

	@Override
	public void handleInternalEvent(InternalEventObject evt)
	{
		
		  String evtname = evt.getEventName();
   	      String str="";
   	  //  trace (evtname + "event rcvd");
  		  
	}
	
	class MyTaskHandler implements ITaskHandler
    {  
          public void doTask(Task task) throws Exception
          {
        	  boolean newRoomMade = false;
        	 // setJackpotRoom();
        	//  bingoDbm.fetchJacInfo();
              bingoDbm.fetchActiveRoom();
             // DataRow dr =bingoDbm.jackInfo.get(0);
             // jackpot_amount=dr.getItem("JACKPOT_AMOUNT");
             // jackpot_balls=dr.getItem("JACKPOT_BALLS");
              activeRooms="";
              //setJackpotTimeForActiveRooms();
               // System.out.print("no of rooms++++++++++++++++++++++++++++++"+bingoDbm.currentRoomList.size());
                  for(int i=0;i<bingoDbm.currentRoomList.size();++i)
                  {
                	 
                	  DataRow drows=bingoDbm.currentRoomList.get(i);
                	  int roomId=Integer.parseInt(drows.getItem("NUMBER"));
                	  activeRooms= activeRooms+","+roomId;
                	  if(currentZone.getRoomByName(drows.getItem("NAME"))==null)
                	  {
                		  newRoomMade = true;
                		// trace("this is the room+++++++++++++++++++++++++++++++++++++++++++++++++++++++++"+drows.getItem("NAME")+drows.getItem("rid")); 
                		 // System.out.print("room id"+drows.getItem("NUMBER")+"///////////////////");
                		 //drows.getItem("JACKPOT_AMOUNT");
                		 HashMap<String, RoomVariable> rvMap = getRoomVariableMapForRoom(roomId,drows,0);
                		 HashMap<String,String> params=new HashMap<String,String>();
                		 params.put("name",drows.getItem("NAME"));
                		 params.put("pwd","");
                		 params.put("maxU","1000");
                		 params.put("isGame","true");
                		 params.put("isLimbo", "false");
                		 params.put("uCount","true");
                		 params.put("xtName","gameExt");
                		 params.put("xtClass","games.casino.Blackjack.BingoMain");
                		 
                		 helper.createRoom(currentZone, params, null, rvMap, null,true, true, false);
                		//+"///////////////////");
                		 //helper.createRoom(currentZone, params, null, null, null,true, true, false);
                	  }
                	
                  }
                    
                  sendStatusToAll(); 
                  if (newRoomMade)
                	  sendRoomUpdateStatus();
          }
         /* public void setJackpotRoom() throws Exception
          {
        	
     		      bingoDbm.fetchjackPotRoom();
     		     
             // activeRooms="";
     		     if( bingoDbm.currentJackpotRoom.size()>0)
     		     {
     		    	
     			     DataRow drows=bingoDbm.currentJackpotRoom.get(0);
     	       	    int roomId=Integer.parseInt(drows.getItem("ROOM_ID"));
     	       	    activeRooms= activeRooms+","+roomId;
     	       	    	// jAvailable=false;
     	       	   // trace("jackpot room....."+jAvailable);
     	       	    	// jAvailable=true;
     	       	    	//  helper.getZone(getOwnerZon
     	       
     	       	  if( jAvailable==false)
     	       	  {
     	       		//trace("jackpot room...&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&..in final block");
     	       	     jAvailable=true;
     	       		 HashMap<String, RoomVariable> rvMap = getRoomVariableMapForRoom(roomId,drows,1);
     	       		  
     	       		 HashMap<String,String> params=new HashMap<String,String>();
     	       		 params.put("name",drows.getItem("ROOM_NAME"));
     	       		 params.put("pwd","");
     	       		 params.put("maxU",drows.getItem("MAX_PLAYERS"));
     	       		 params.put("isGame","true");
     	       		 params.put("isLimbo", "false");
     	       		 params.put("uCount","true");
     	       		 params.put("xtName","gameExt");
     	       		 params.put("xtClass","games.casino.bingov1.BingoMain");
     	       		 
     	       		 helper.createRoom(currentZone, params, null, rvMap, null,true, true, false);
     	       		 setJackpotTimeForActiveRooms();
     	       	      sendRoomUpdateStatus();
     	       		// System.out.print("jai hind jai baharat");
     	       		
       		     }
     	      }
          }*/
          
          private void setJackpotTimeForActiveRooms()
          {
        	  
        	 
   	         
        	  
        	  
        	  
        	  
        	  
        	  
        	 // trace ("Setting jackpot time for active rooms");
        	  Object [] roomArray = currentZone.getRooms();
        	  for (int i = 0; i < roomArray.length; ++i)
        	  {
        		  Room r = (Room)roomArray[i];
        		  ExtensionManager eM = r.getExtManager();
        		  ISmartFoxExtension iext = eM.get("gameExt");
        		  if (iext != null)
        		  {
        			  ext = (AbstractExtension)iext;
        	   		     robj=new HashMap();
        	   			//robj.put(0,1);
        	   			robj.put(0,"7");
        	   			robj.put(1,JackpotDate);
        	      	    ext.handleInternalRequest(robj);
        			  
        			 /* BingoMain extMain = (BingoMain)iext;
        			  extMain.setJackpotTimeUserVariable(JackpotDate);
        			  trace ("Ext main found");*/
        		  }
        	  }
          }          
         
          private HashMap<String, RoomVariable> getCommonRoomVariableMap(int roomId,DataRow drows)
          {
        	 HashMap<String, RoomVariable> rvMap=new HashMap<String, RoomVariable>();
       		 RoomVariable annoncementRV = new RoomVariable(drows.getItem("ANNOUNCEMENT"),"s",null,true,true);
      		 RoomVariable mipRV = new RoomVariable(drows.getItem("MIN_PLAYERS"),"n",null,true,true);
      		 RoomVariable mpRV = new RoomVariable(drows.getItem("MAX_PLAYERS"),"n",null,true,true);
       		 RoomVariable wMsgRV = new RoomVariable(drows.getItem("WELCOME_MESSAGE"),"s",null,true,true);
       		 RoomVariable maxbetRV = new RoomVariable(drows.getItem("MAX_BET"),"s",null,true,true);
       		 RoomVariable minbetRV = new RoomVariable(drows.getItem("MIN_BET"),"s",null,true,true);
      		 RoomVariable bpassRV = new RoomVariable("0","n",null,true,true);
      		 RoomVariable cplRV = new RoomVariable("0","n",null,true,true);
      		 RoomVariable rsRV = new RoomVariable("1","n",null,true,true);
      		 RoomVariable join = new RoomVariable("1","s",null,true,true);
      	     RoomVariable timer = new RoomVariable("0","s",null,true,true);
     		 rvMap.put("joinP", join);
       		 rvMap.put("announcement", annoncementRV); 
     		 rvMap.put("mp", mpRV);
     		 rvMap.put("mxb",maxbetRV);
     		 rvMap.put("mnb",minbetRV);
       		 rvMap.put("bpass", bpassRV);
     		 rvMap.put("cpl", cplRV);
     		 rvMap.put("rs", rsRV);
     		 rvMap.put("minpl",mipRV);
     	     rvMap.put("wMsg",wMsgRV);
     	     rvMap.put("tm",timer);
     		 return rvMap;         	  
        	  
          }
          //third argument for room type in 0 for normal room 1 for jackpot room
          private HashMap<String, RoomVariable> getRoomVariableMapForRoom(int roomId,DataRow drows,int i)
          {
     		 	 HashMap<String, RoomVariable> rvMap=getCommonRoomVariableMap(roomId,drows);
       			 RoomVariable ridRV = new RoomVariable(drows.getItem("NUMBER"),"n",null,true,true);
     			 RoomVariable rdRV = new RoomVariable(drows.getItem("DESCRIPTION"),"s",null,true,true);
       			 rvMap.put("rid", ridRV);    		
     			 rvMap.put("rd", rdRV);
                 return rvMap;         	  
          }
      }
	

	  public void initialize()
      {		    
          scheduler = new Scheduler();
          handler = new MyTaskHandler();
          Task sendRoomUpdates = new Task("sendRoomUpdates");
          //Task TimerTask = new Task("TimerTask");
          scheduler.addScheduledTask(sendRoomUpdates, 5, true, handler);
          // scheduler.addScheduledTask(TimerTask, 5, false, handler);
          scheduler.startService();    
      }
	  
	  public void destroy()
      {
        scheduler.stopService();
      }
	  
	  public void sendStatusToAll()
	  {
		  String aobj[]=new String[2];
		  aobj[0]="7";
		  String str="-1";
		  LinkedList<Room> rooms=helper.getZone(getOwnerZone()).getRoomList();
		  ListIterator<Room> itr=rooms.listIterator();
		  while(itr.hasNext())
		  {
			  Room rm=itr.next();
			  int status=0;
			  if (rm.getVariable("rid") == null)
				  continue;
			  if(str.equals("-1"))
			  {
				 //
				  str="";
				 
				 str=rm.getVariable("rid").getValue();
				 str=str+","+rm.getVariable("cpl").getValue();
				 str=str+","+rm.getVariable("rs").getValue();
				 str=str+","+rm.getVariable("mp").getValue(); 
				 str=str+","+rm.getVariable("tm").getValue(); 
			  }
			  else
			  {
				  str=str+"*"+rm.getVariable("rid").getValue();
				  str=str+","+rm.getVariable("cpl").getValue();
				  str=str+","+rm.getVariable("rs").getValue();
				  str=str+","+rm.getVariable("mp").getValue(); 
				  str=str+","+rm.getVariable("tm").getValue(); 
			  }
		  }
		  
		  aobj[1]=str;
		 // System.out.print(helper.getZone(getOwnerZone()).getRoomByName("Lobby1").getName());
		  LinkedList<SocketChannel> users=helper.getZone(getOwnerZone()).getRoomByName("Lobby1").getChannellList();
		  sendResponse(aobj,-1,null,users);  
	  }
	  
	  public void sendRoomUpdateStatus()
	  {
		  String aobj[]=new String[2];
		  aobj[0]="8";
		  /*String str="";
		  LinkedList<Room> rooms=helper.getZone(getOwnerZone()).getRoomList();
		  ListIterator<Room> itr=rooms.listIterator();
		  while(itr.hasNext())
		  {
			  Room rm=itr.next();
			  int status=0;
			  if (rm.getVariable("rid") == null)
				  continue;
			  String roomIdS = rm.getVariable("rid").getValue();
			  
			  int rid=Integer.parseInt(roomIdS);
			  if(activeRoomSet.containsKey(rid))
			  {
				status=1;  
			  }
			 // str=str+ roomIdS+","+rm.getVariable("mp").getValue()+","+rm.getVariable("cp").getValue()+","+rm.getVariable("bpass").getValue()+","+rm.getVariable("cpl").getValue()+","+rm.getVariable("rs").getValue()+","+rm.getVariable("mcp").getValue()+":";	  
		  }
		  aobj[1]="1";*/
		  LinkedList<SocketChannel> users=helper.getZone(getOwnerZone()).getRoomByName("Lobby1").getChannellList();
		  //trace (users.size() + " size");
		  sendResponse(aobj,-1,null,users);  
	  }
}