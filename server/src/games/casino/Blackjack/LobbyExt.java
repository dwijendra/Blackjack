package games.casino.Blackjack;

import it.gotoandplay.smartfoxserver.data.Room;
import it.gotoandplay.smartfoxserver.data.User;
import it.gotoandplay.smartfoxserver.data.UserVariable;
import it.gotoandplay.smartfoxserver.data.Zone;
import it.gotoandplay.smartfoxserver.events.InternalEventObject;
import it.gotoandplay.smartfoxserver.extensions.AbstractExtension;
import it.gotoandplay.smartfoxserver.extensions.ExtensionHelper;
import it.gotoandplay.smartfoxserver.extensions.ISmartFoxExtension;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.HashMap;

public class LobbyExt extends AbstractExtension
{
	public Room gameRoom;
	public ExtensionHelper helper;
	private Zone currentZone;
    AbstractExtension ext;
    public HashMap hmap;
    private BingoDbm bingoDbm;
    public RequestHttp _rhttp;
    public String _URLstring;
    public GetUrlClass _GURLC;
	@Override 
	public void init()
	{
		//trace("___________lobbby is initialize|||||||||");
		helper = ExtensionHelper.instance();
		bingoDbm=BingoDbm.getBingoDBM(getOwnerZone());
		 _rhttp=new RequestHttp();
		 _GURLC=new GetUrlClass(getOwnerZone());
		 _URLstring=_GURLC.getUrl();
  	}
	public void sendInfoToZone(String cmd,User u ,String info)
	{
		//helper = ExtensionHelper.instance();
		/// Zone currentZone = helper.getZone(getOwnerZone());
			
	}
	public String sendOutRequest(User u,Double cashB,Double winB)
	{
		double totalAmount=cashB*100+winB*100;
		//String url="http://game-03.globalstarsgames.com/mtransfer/out.php";
		String url="http://management.globalstarsgames.com/webservice/v1transfer/out.php";
		String data="url="+_URLstring+"/TransferOutRequest&client_session_id=7967858765675&timestamp=123&account_id="+u.getVariable("id").getValue()+"&amount="+totalAmount+"&transaction_id=123456&licensee_reverse_password=123456&deposit_pot="+cashB*100+"&winning_pot="+winB*100;
		
		String str=_rhttp.SendRequest(url,data);
				//String str=_rhttp.SendRequest(_URLstring+"/TransferOutRequest",data);
		// System.out.print("this is  out result"+str+"this is  out result");
		 return str;
	}
	public void handleRequest(String cmd, ActionscriptObject ao, User u,int fromRoom)
	{
	}
	public void joinRoom(User u,String roomName) throws Exception
	{
     Room rm=helper.getZone(getOwnerZone()).getRoomByName(roomName);
//trace("+++++++++++++calling for join room +++++++++++++"+u.getVariable("id").getValue());
		boolean flag=false;
		if(roomName.equals("Lobby1"))
		{
			helper.joinRoom(u,u.getRoom(),rm.getId(), true,"", false,true);
			return;
		}
		if(rm.getVariable("cpl").getIntValue()<rm.getVariable("mp").getIntValue())
		{
			flag=true;
			
		}
		else
		{
			 
			//ISmartFoxExtension iext = rm.getExtManager().get("gameExt");
			ISmartFoxExtension iext = rm.getExtManager().get("gameExt");
		     ext = (AbstractExtension)iext;
		     hmap=new HashMap();
		     hmap.put(0,"8");
		     hmap.put(1,u.getVariable("id").getValue());
		     String str=ext.handleInternalRequest(hmap).toString();
		   
		     //String str="1";
		     if(str.equals("1")||(u.getVariable("Utype").getIntValue()==1))
		     {
		    	// trace("+++++++++++++calling for join room +++++++++++++");
		    	 flag=true;
		     }
		}
		if((rm.getVariable("joinP").getValue().equals("1")&& flag))
		{
			//trace(" for join room called   +++++++++++++ +++++++++++++"+roomName);
		  helper.joinRoom(u,u.getRoom(),rm.getId(), true,"", false,true);
		}
	}
	public void handleRequest(String cmd, String[] params, User u, int fromRoom)
	{
		
		//System.out.print("|||||||||||||hi|||||||||||||||||");
		int i=u.getVariable("id").getIntValue();
		String str1="";
		int cmdValue = Integer.parseInt(params[0]);
				
		if(cmdValue==1)
		{
			try
			{
				 joinRoom(u,params[1]);	
			}
			catch(Exception e)
			{
				
			}
		
			
		}
	}
	
	@Override
	public void handleInternalEvent(InternalEventObject evt)
	{
		   String evtname = evt.getEventName();
		   User juser = (User)evt.getObject("user");
		   //int id=juser.getVariable("id").getIntValue();
			String str="";

			ActionscriptObject ao = new ActionscriptObject();
			if (evtname.equals("userJoin"))
			{
				//sendInfoToZone("100",juser,"");
			}
			else if ( evtname.equals("userLost") || evtname.equals("logOut"))
			{
				
				/*int id=juser.getVariable("id").getIntValue();
				Double CashBalance =Double.valueOf(juser.getVariable("cashB").getValue().trim()).doubleValue();
			    Double winBalance =Double.valueOf(juser.getVariable("winB").getValue().trim()).doubleValue(); 
			    bingoDbm.setBalance(id,0.0,0.0);
		    	juser.setVariable("cashB","0.0",UserVariable.TYPE_STRING);
		    	juser.setVariable("winB","0.0",UserVariable.TYPE_STRING);
			   
			    	  if(!(sendOutRequest(juser,CashBalance,winBalance).equals("0")))
					    {
					    	 bingoDbm.setFailedBalance(id, CashBalance, winBalance);   	
					    }*/
			   
			}
			else if (evtname.equals("userExit"))
			{
				//trace("++++++++exit code is excuted from lobby+++++++++++");
				/*
				int id=juser.getVariable("id").getIntValue();
				Double CashBalance =Double.valueOf(juser.getVariable("cashB").getValue().trim()).doubleValue();
			    Double winBalance =Double.valueOf(juser.getVariable("winB").getValue().trim()).doubleValue(); 
			    bingoDbm.setBalance(id, CashBalance, winBalance);
			    if((currentZone.getUserIdByName(juser.getName())==id))
			    {
			    	  if(sendOutRequest(juser,CashBalance,winBalance).equals("0"))
					    {
					    	bingoDbm.setBalance(id,0.0,0.0);
					    	juser.setVariable("cashB","0.0",UserVariable.TYPE_STRING);
					    	juser.setVariable("winB","0.0",UserVariable.TYPE_STRING);
					    }
			    	trace("++++++++exit code is excuted from lobby+++++++++++");
			    }
				*/
			}
	}


}
