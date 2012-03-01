package games.casino.Blackjack;

import java.nio.channels.SocketChannel;
import java.util.HashMap;
import java.util.LinkedList;

import it.gotoandplay.smartfoxserver.data.User;
import it.gotoandplay.smartfoxserver.data.Zone;
import it.gotoandplay.smartfoxserver.events.InternalEventObject;
import it.gotoandplay.smartfoxserver.extensions.AbstractExtension;
import it.gotoandplay.smartfoxserver.extensions.ExtensionHelper;
import it.gotoandplay.smartfoxserver.extensions.ISmartFoxExtension;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

public class ChatExt extends AbstractExtension {
	private ExtensionHelper helper;
	private Zone currentZone;
	private Zone userZone;
    public AbstractExtension ext;
	public HashMap robj;
    public void init()
    {
    	helper = ExtensionHelper.instance();
		currentZone=helper.getZone(getOwnerZone());
		trace("zone names"+currentZone.getName());
    }
	@Override
	public void handleRequest(String arg0, ActionscriptObject arg1, User arg2,
			int arg3) {
		// TODO Auto-generated method stub
		//trace("cmd++++++++chat+ext++++++");
		
	}

	@Override
	public void handleRequest(String cmd, String[] str, User arg2, int arg3) {
		trace("cmd++++++++chat+ext+++++++"+str[1].trim()+"++++++++++++++++++"+cmd+"kya aaya++++++ "+str[0].trim() +"  hsdgh "+arg2.getName());
		userZone=helper.getZone("Chat_Zone");
		String str1=str[1].trim();
		trace("cmd++++++++chat+ext+++++"+str1);
		 ISmartFoxExtension iext = userZone.getExtManager().get("chatExt");
	       ext = (AbstractExtension)iext;
	     
		   robj=new HashMap();
		   robj.put(0, str1);
		   ext.handleInternalRequest(robj);
		
		//trace("zone user names"+userZone.getName());
	}

	@Override
	public void handleInternalEvent(InternalEventObject arg0) {
		// TODO Auto-generated method stub
		//trace("cmd++++++++chat+ext++hndleinternal++++");
	}
	public Object handleInternalRequest(Object obj)
	{
		 HashMap objMap=(HashMap)obj;
		trace("a ja ayai bahar _____"+objMap.get(0).toString());
		
		return null;
	}
	

}
