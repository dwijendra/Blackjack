package games.casino.Blackjack;

import it.gotoandplay.smartfoxserver.db.DataRow;
import it.gotoandplay.smartfoxserver.db.DbManager;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
import it.gotoandplay.smartfoxserver.util.scheduling.ITaskHandler;
import it.gotoandplay.smartfoxserver.util.scheduling.Scheduler;
import it.gotoandplay.smartfoxserver.util.scheduling.Task;
import it.gotoandplay.smartfoxserver.data.Room;
import it.gotoandplay.smartfoxserver.extensions.ExtensionHelper;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;




public class BingoDbm
{
	public int _authentication;
	//private  int initted = 0;
	public String zoneName="1";
	//private static BingoDBM _me = null;
	DbManager dbase2;
	HashMap<String,String> whiteListedIPs=null;
	//private Scheduler scheduler;
	private static BingoDbm _DutchMe=null;
	private static BingoDbm _SpanishMe=null;
	private static BingoDbm _GermanMe=null;
	
	public  ArrayList<DataRow> currentRoomList;
	public  ArrayList<DataRow> currentJackpotRoom;
	public  ArrayList<DataRow> jackInfo;
	public  ArrayList<DataRow> bg;
	//public static HashMap<Integer, String> jackpotmap;
	public static BingoDbm getBingoDBM(String language)
	{
		String []splits = language.split("_");
		if (splits[1].equals("Duch"))
		{	
			if(_DutchMe == null)
			{
				_DutchMe = new BingoDbm(language);
			}		
			return _DutchMe;
		}
		if (splits[1].equals("Germany"))
		{	
			if(_GermanMe == null)
			{
				_GermanMe = new BingoDbm(language);
			}		
			return _GermanMe;
		}
		if (splits[1].equals("Spanish"))
		{	
			if(_SpanishMe == null)
			{
				_SpanishMe = new BingoDbm(language);
			}		
			return _SpanishMe;
		}		
		return null;
		
	}
	public DbManager getDBmanager()
	{
		return dbase2;
	}
	public BingoDbm(String language)
	{
		
		String driverName = "org.gjt.mm.mysql.Driver";
		
		String connString = "jdbc:mysql://localhost:3306/"+language;
		//System.out.print("hi db----"+connString+"hi db-------");
		//connString+=ZoneLevelExtension.zoneName;
		String userName = "root";
		String pword = "arthah";
		
		String connName = language;
		int maxActive = 50;
		int maxIdle = 10;
		String exhaustedAction = "fail";
		int blockTime = 5000;
			   
		dbase2 = new DbManager(   driverName,
			                           connString,
			                           userName,
			                           pword,
			                           connName,
			                           maxActive,
			                           maxIdle,
			                           exhaustedAction,
			                           blockTime
			                        );
		
		/*for(int i=0;i< result.size();++i)
		{
			//System.out.println("Name:\t"						+ result.get(i));
			//System.out.println("password:\t"						+ result.getString("password"));	
			System.out.println("");
		}*/
		
			   
	}
	public HashMap getUserDetails(String username)
	{
		String sql = "select user_master.USER_ID, user_master.USER_TYPE, user_master.USER_NAME, user_master.EMAIL, user_master.STATUS, user_master.REGISTRATION_DATE, user_master.LAST_LOGIN, user_master.AKEY, user_master.CHAT_STATUS, user_master.IGNORED_USERS , accounts_master.TOTAL_POINTS , accounts_master.CASH_BALANCE , accounts_master.WIN_BALANCE , accounts_master.WIN_BALANCE, accounts_master.ACCOUNT_STATUS from user_master inner join accounts_master on user_master.USER_NAME='"+username+"' AND user_master.USER_ID=accounts_master.ACCOUNT_NUMBER";
	
		ArrayList<DataRow> drows = dbase2.executeQuery(sql);
		if(drows.size()<= 0)
		{
			return null;
		}
		
		HashMap uMap = new HashMap();
		DataRow drow = drows.get(0);
		
		uMap.put("user_id", new String(drow.getItem("USER_ID")));
		uMap.put("user_type", new String(drow.getItem("USER_TYPE")));
		uMap.put("chat_status", new String(drow.getItem("CHAT_STATUS")));
		uMap.put("user_name", new String(drow.getItem("USER_NAME")));
		uMap.put("email", new String(drow.getItem("EMAIL")));
		uMap.put("status", new String(drow.getItem("STATUS")));
		uMap.put("reg_date", new String(drow.getItem("REGISTRATION_DATE")));
		uMap.put("akey", new String(drow.getItem("AKEY")));

		if(drow.getItem("LAST_LOGIN") != null)
			uMap.put("last_login", new String(drow.getItem("LAST_LOGIN")));
		else
			uMap.put("last_login", new String(""));

		if(drow.getItem("IGNORED_USERS") != null)
			uMap.put("ignoredUsers", new String(drow.getItem("IGNORED_USERS")));
		else
			uMap.put("ignoredUsers", new String(""));

		uMap.put("points", new String(drow.getItem("TOTAL_POINTS")));
		uMap.put("cash", new String(drow.getItem("CASH_BALANCE"))); //This is the amount which user has recharged uptil now
		uMap.put("winb", new String(drow.getItem("WIN_BALANCE"))); //This is the balance which user has won till now
		uMap.put("astatus", Integer.parseInt(drow.getItem("ACCOUNT_STATUS")));
		
		return uMap;
		
	}

	/*public void saveBonusDetails(long gameid, long bonusid)
	{
		String sql = "update star_game_records set BONUSID="+bonusid + " where GAME_ID="+gameid;
		dbase2.executeCommand(sql);
	}*/
	public void banUserChat(String username,String state)
	{
		String sql ="update user_master set CHAT_STATUS="+state+" where USER_NAME='"+username+"'";
		dbase2.executeCommand(sql);
	}
	/*public void fetchjackPotRoom()
	{
		//String userQuery = "select * from jackpot_master where (JACKPOT_DT>=SYSDATE()) AND (YEAR(JACKPOT_DT-SYSDATE())=0 )AND (MONTH(JACKPOT_DT-SYSDATE())=0)AND (DAY(JACKPOT_DT-SYSDATE())<=2) ORDER BY JACKPOT_DT ASC";
		//String userQuery = "select * from jackpot_master where JACKPOT_DT>=SYSDATE() ORDER BY JACKPOT_DT ASC";
		String userQuery = "select * from jackpot_master where JACKPOT_DT>=SYSDATE() AND (JACKPOT_DT<=DATE_ADD(SYSDATE(), INTERVAL 2 DAY)) ORDER BY JACKPOT_DT ASC";
		currentJackpotRoom=new ArrayList<DataRow>();
    	currentJackpotRoom=dbase2.executeQuery(userQuery);
    	//System.out.print("++++++jackpot room is called++++++++"+currentJackpotRoom.size()+"++");
	}*/
	public int getRebootStatus(int roomid)
	{
		if(roomid!=25)
		{
		String userQuery = "select REBOOT  from room_master where NUMBER="+roomid+"";
		ArrayList<DataRow> arr=new ArrayList<DataRow>();
    	arr=dbase2.executeQuery(userQuery);
    	//System.out.print("reboot_______"+arr.get(0).getItem("REBOOT")+"reboot_______");
    	return Integer.parseInt(arr.get(0).getItem("REBOOT"));
		}
		
		return 0;
	}
	public void setRebootStatus(int roomid)
	{
		String sql ="update room_master set REBOOT=0 where NUMBER="+roomid+"";
		dbase2.executeCommand(sql);
		//System.out.println(sql + " this is the sql");
		//System.out.println(dbase2.executeCommand(sql) + " result of the query");
	}
	/*public  void fetchJacInfo()
	{
		//String userQuery = "select jackpot_amount,jackpot_balls from jackpot_settings";
		 String userQuery="select * from jackpot_settings";
		 jackInfo=new ArrayList<DataRow>();
    	 jackInfo=dbase2.executeQuery(userQuery);    	
   	}*/
	/*public int getmaxgameid()
	{
		String newQuery = "select * from star_game_records order by GAME_ID desc limit 1";
		ArrayList<DataRow> result= dbase2.executeQuery(newQuery);
		DataRow dr=result.get(0);
		int gameId = Integer.parseInt(dr.getItem("GAME_ID"));
		return gameId;
	}*/
	
	/*public void updateGameRecord(String []info ,Boolean wonJackpot)
	{
		String userQuery="insert into star_game_records(START_TIME,ROOM_ID,TOTAL_PLAYERS,TOTAL_STAKE,PATTERN_AMOUNT,BINGO_AMOUNT,PATTERN_POS,PATTERN_WINNERS,BINGO_WINNERS,ALLBALLS)";
		userQuery+="values('"+info[0]+"',"+info[1]+","+info[2]+","+info[3]+","+info[5]+","+info[4]+",'"+info[6]+"','"+info[7]+"','"+info[8]+"','"+info[9]+"')";
		dbase2.executeCommand(userQuery);
		
		System.out.println(" Jackpot won is " + wonJackpot);
		
		if (wonJackpot == true)
		{
			String newQuery = "select * from star_game_records order by GAME_ID desc limit 1";
			ArrayList<DataRow> result= dbase2.executeQuery(newQuery);
			DataRow dr=result.get(0);
			String gameId = dr.getItem("GAME_ID");
			
			String jackpotRecordQuery = "insert into jackpot_records (ROOM_ID,GAME_ID,WIN_TIME,JACKPOT_WINNERS)";
			jackpotRecordQuery += "values('" + info[1] + "','"+ gameId + "','" + info[0]+"','"+ info[8] + "')";
			dbase2.executeCommand(jackpotRecordQuery);			
			
			String lastJackpotQuery = "select * from jackpot_records order by ID desc limit 1";
			result =  dbase2.executeQuery(lastJackpotQuery);
			dr=result.get(0);
			String jackPotId = dr.getItem("ID");
			String setJRQuery = "update star_game_records set JACKPOT_RECORD_ID='" + jackPotId + "' where GAME_ID='" + gameId + "'";
			dbase2.executeCommand(setJRQuery);			
		}
	}*/
	public void updateGameRd(String []info, int gameId)
	{
		String userQuery="update blackjack_game_records set START_TIME ='"+info[0]+"' ,ROOM_ID="+info[1]+",TOTAL_PLAYERS="+info[2]+",TOTAL_STAKE="+info[4]+",USERS_INFO='"+info[3]+"',SYSTEM_CARDS='"+info[5]+"'where GAME_ID=" + gameId + " ";
		//userQuery+="values('"+info[0]+"',"+info[1]+","+info[2]+","+info[3]+","+info[5]+","+info[4]+",'"+info[6]+"','"+info[7]+"','"+info[8]+"','"+info[9]+"')";
		dbase2.executeCommand(userQuery);
	}
	/*public ArrayList<DataRow> getBunusInfo( int roomid)
	{
		String userQuery = "select * from auto_bonus_settings where ROOM_NUMBER="+roomid+"";
	    return dbase2.executeQuery(userQuery);		
	}*/
	public void updateEachUserGameRecords(String []info)
	{
	//System.out.print("hi info "+info);
		String userQuery="insert into blackjack_eachuserinfo values('"+info[0]+"',"+info[1]+",'"+info[2]+"','"+info[3]+"','"+info[4]+"','"+info[5]+"') ";
		//userQuery+="values('"+info[0]+"',"+info[1]+","+info[2]+","+info[3]+","+info[5]+","+info[4]+",'"+info[6]+"','"+info[7]+"','"+info[8]+"','"+info[9]+"')";
		dbase2.executeCommand(userQuery);
	}
	//updateEachUserGameRecords
	
    /*public void getBackground(int roomid,int jid)
    {
    	String userQuery;
    	//System.out.print("jai ho"+currentJackpotRoom.size()+"jai hind");
    	if(roomid==25)
    	{
    		userQuery="select BACKGROUND from jackpot_master where JACKPOT_ID="+jid+"";	
    	}
    	else
    	{
    	     userQuery="select BACKGROUND from room_master where NUMBER="+roomid+"";
    	}
    	 bg=new ArrayList<DataRow>();
    	bg=dbase2.executeQuery(userQuery);
    	//DataRow dr=bg.get(1);
    	//System.out.print("backgr??????"+bg.size()+"?????????background");
    }*/
	
	
	public void fetchActiveRoom()
	{
		//System.out.print("fetch room_master ===============");
		
		String userQuery="select * from room_master where room_master.ACTIVE_STATUS=1";
		
		//String userQuery="select * from room_master where room_master.ACTIVE_STATUS=1 ";
		currentRoomList=new ArrayList<DataRow>();
    	currentRoomList=dbase2.executeQuery(userQuery);
    	//System.out.print("backgr??????"+dbase2.executeQuery(userQuery).size()+"?????????background");
    	
	}
	public String setActiveStatus(String roomId,String status)
	{
		String userQuery="update room_master set ACTIVE_STATUS="+Integer.valueOf(status)+" where number="+Integer.valueOf(roomId)+" ";	
		if(dbase2.executeCommand(userQuery))
			{
			return "1";
			}
		else
		{
			return "0";	
		}
	}
	

	public ArrayList<DataRow> authenticateUser(String name,String passWord)
	{
		String userQuery="select USER_ID,IGNORED_USERS,STATUS,BAN_UNTILL - '0000-00-00 00:00:00' as B1,CHAT_STATUS,USER_TYPE from user_master where USER_NAME='"+name+"' and PASSWORD='"+passWord+"'";
		ArrayList<DataRow> result=dbase2.executeQuery(userQuery);
		if(result.size()>0)
		{
	     userQuery="update user_master set LAST_LOGIN =SYSDATE() where USER_NAME='"+name+"'";
	     dbase2.executeCommand(userQuery);
		}
	
		return result;
				
	}
	public boolean setMsg(String rname,String welMsg,String Announce)
	{
		String userQuery="update room_master set WELCOME_MESSAGE='"+welMsg+"',ANNOUNCEMENT='"+Announce+"' WHERE NAME='"+rname+"'";
	   	return dbase2.executeCommand(userQuery);
	}
	public boolean authenticateIP(String ipadd)
	{
		String userQuery="select IP from ip_blacklist_table where IP='"+ipadd+"'";
		ArrayList<DataRow> result=dbase2.executeQuery(userQuery);
		if(result.size()>0)
		{
			return false;
		}
		else
		{
			 userQuery="select BANNEDDT,BANNED from ip_list where IPADDR='"+ipadd+"'";
			 result=dbase2.executeQuery(userQuery);
			 if(result.size()>0)
			 {
				 DataRow dr=result.get(0);
				 String dt1=dr.getItem("BANNEDDT");
				 Calendar dtcl=Calendar.getInstance();
				 Calendar current=Calendar.getInstance();
				 java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat( "yyyy-MM-dd HH:mm:ss" );  
				// Date dt=new Date();
				 if(dr.getItem("BANNED").equals("1"))
				 {
					 		try
					 		{
					 			Date dt=(Date)sdf.parse(dt1);
					 			dtcl.setTime(dt);
					 		}
					 		catch(ParseException e)
					 		{
					 			// System.out.print("o comparison"+drows.getItem("B1"));
					 		}
				      if(current.compareTo(dtcl)>0)
				      {
				    	  return true;
				      }
				      else
				      {
				    	return false;
				      }
				 }
				 else
				 {
					 return true;  
				 }
				 
				 
			 }
			 else
			 {
				 return true;
			 }
		}
		
		
	}
	public ArrayList<DataRow> getBalance(int id)
	{
     	String userQuery="select CASH_BALANCE,WIN_BALANCE from accounts_master where ACCOUNT_NUMBER="+id+"";
		ArrayList<DataRow> result=dbase2.executeQuery(userQuery);
		return result;
	}
	public String setBalanceOnadminReq(String name,double cashbalance,double winbalance,String pwd,String cht_ban,String AccId,String uType)
	{
		try
		{
				cashbalance=cashbalance/100;
				winbalance=winbalance/100;
				String userQuery="select USER_ID from user_master where USER_NAME='"+name+"'";
				ArrayList<DataRow> result=dbase2.executeQuery(userQuery);
				if(result.size()>0)
				{
					userQuery="update user_master set USER_ID="+AccId+",CHAT_STATUS="+cht_ban+",PASSWORD='"+pwd+"',USER_TYPE="+uType+" where USER_NAME='"+name+"'";
					dbase2.executeCommand(userQuery);
				}
				else
				{
					userQuery="insert into user_master(USER_ID,USER_NAME,PASSWORD,EMAIL,REGISTRATION_DATE,AKEY,STATUS,BAN_UNTILL,user_note,CHAT_STATUS,USER_TYPE)values("+AccId+",'"+name+"','"+pwd+"','hi',SYSDATE(),'hi',1,'1111-11-11 11:11:11','hi',"+cht_ban+","+uType+")";
					dbase2.executeCommand(userQuery);
				}
				userQuery="select ACCOUNT_NUMBER from accounts_master where ACCOUNT_NUMBER='"+AccId+"'";
				result=dbase2.executeQuery(userQuery);
				if(result.size()>0)
				{
					userQuery="update accounts_master  set  CASH_BALANCE=CASH_BALANCE+"+cashbalance+",WIN_BALANCE=WIN_BALANCE+"+winbalance+" where ACCOUNT_NUMBER="+AccId+"";
					dbase2.executeCommand(userQuery);			
				}
				else
				{
					userQuery="insert into accounts_master(ACCOUNT_NUMBER,TOTAL_POINTS,CASH_BALANCE,WIN_BALANCE,ACCOUNT_STATUS)values("+AccId+",0,"+cashbalance+","+winbalance+" ,1)";
					dbase2.executeCommand(userQuery);
				}
				 insertMoneyTransaction(Integer.parseInt(AccId),"in",cashbalance,winbalance,"0");
				return "1";
		}
		catch (Exception e) {
			// TODO: handle exception
			 insertMoneyTransaction(Integer.parseInt(AccId),"in",cashbalance,winbalance,"1");
			     return "0";
		}
		// userQuery="update accounts_master  set  win_balance="+winbalance+" where account_number="+id+"";
		// dbase2.executeCommand(userQuery);
	}
	
	
	public void setBalance(int id,double cashbalance,double winbalance)
	{
		//System.out.print("amount of the user"+cashbalance+winbalance);
		String userQuery="update accounts_master  set  CASH_BALANCE="+cashbalance+",WIN_BALANCE="+winbalance+" where ACCOUNT_NUMBER="+id+"";
		dbase2.executeCommand(userQuery);		
		
		// userQuery="update accounts_master  set  win_balance="+winbalance+" where account_number="+id+"";
		// dbase2.executeCommand(userQuery);
	}
	public void setBlockedUser(int id,String str)
	{
		String userQuery="update user_master set IGNORED_USERS ='"+str+"' where USER_ID="+id+"";
		dbase2.executeCommand(userQuery);
	}
	/*public void inserteachUserInfo(String name,int gid,int buycard,String cards,int won,String totalp)
	{
		String userQuery="insert into eachUserInfo values('"+name+"',"+gid+","+buycard+",'"+cards+"',"+won+",'"+totalp+"')";
		dbase2.executeCommand(userQuery);
	}*/
	public void setFailedBalance(int AccId,Double cashbalance,Double winbalance)
	{
		 String userQuery="insert into star_failed_account_master(ACCOUNT_NUMBER,CASH_BALANCE,WIN_BALANCE)values("+AccId+","+cashbalance+","+winbalance+")";
		dbase2.executeCommand(userQuery);
	}
	public void insertMoneyTransaction(int id,String type,double CashB,double WinB,String Status)
	{
		
		//  System.out.print("value of status++++++++++++in database"+Status);
		String userQuery="insert into money_transaction_info(AccountID,Type,Date,Cash_Balance,Win_Balance,Status)values("+id+",'"+type+"',SYSDATE(),"+CashB+","+WinB+","+Status+")";
		dbase2.executeCommand(userQuery);
		
	}
	public String updateBalance(int id,double cashbalance)
	{
		//System.out.print("amount of the user"+cashbalance+winbalance);
		String userQuery="update accounts_master  set  CASH_BALANCE=CASH_BALANCE+"+cashbalance+" where ACCOUNT_NUMBER="+id+"";
		if(dbase2.executeCommand(userQuery))
		{
			 insertMoneyTransaction(id,"in",cashbalance,0.0,"0");
		    return "1";
		   
		}
	    else
	    {
	    	 insertMoneyTransaction(id,"in",cashbalance,0.0,"1");
		return "0";	
	    }
	}
	public int getGameId()
	{
		String userQuery="insert into blackjack_game_records(ROOM_ID)values("+-1+")";
		dbase2.executeCommand(userQuery);
		  userQuery="select GAME_ID from blackjack_game_records where ROOM_ID = "+-1+"";
		    /// System.out.print(+"kya aay h");
		     ArrayList<DataRow> result=dbase2.executeQuery(userQuery);
				//id=-1;
				if(result.size()>0)
				{
					DataRow drows=result.get(0);
					return Integer.valueOf(drows.getItem("GAME_ID"));
				}
		return -1;
	}
	

}
