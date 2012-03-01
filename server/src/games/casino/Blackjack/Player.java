package games.casino.Blackjack;
import java.util.*;

import it.gotoandplay.smartfoxserver.data.User;

public class Player
{
	    public User user; 
	    public int serverId;
	    public String name;
	    public int index;
	    String game_info[];
	    String isWon;
	    BingoDbm bingoDbm;
	    public double totalWinAmount;
	    public boolean isRealP;
	    public boolean isSystem;
	    public boolean isOnlineP;
	    public boolean isGameOver;
	    private TotalCardPack TCP;
	    public Double _betAmount=0.0;
	    public int blackJackIndex;
	    public HashMap<Integer,Card> myCards; 
	    public ArrayList<BlackJackPlayer> blackJackPlayers=new ArrayList<BlackJackPlayer>();
	    Player(TotalCardPack tp)
	    {
	    	 game_info=new String[10];
	    	 isWon="-1";
	    	 totalWinAmount=-1.0;
	    	 myCards=new HashMap<Integer,Card>();
	    	 blackJackPlayers=new ArrayList<BlackJackPlayer>();
	    	 TCP=tp;
	    	 
	    	 this.name="SYSTEM";
	 	     this.isRealP=true;
	    	 isSystem=true;
	    	 isOnlineP=true;
	         blackJackIndex=0;
		     blackJackPlayers.add(new BlackJackPlayer(tp,_betAmount));
		     index=-1;
		
	    }
		Player(User u,TotalCardPack tp,Double amt)
	    {
			game_info=new String[10];
			myCards=new HashMap<Integer,Card>();
			blackJackPlayers=new ArrayList<BlackJackPlayer>();
			isWon="no";
	    	user=u;
	    	totalWinAmount=0.0;
	    	TCP=tp;
	    	this.name=u.getVariable("name").getValue();
	    	_betAmount=amt;
	    	this.isRealP=true;
	    	serverId=u.getVariable("id").getIntValue();
	    	isOnlineP=true;
		    isSystem=false;
		    blackJackIndex=0;
		    blackJackPlayers.add(new BlackJackPlayer(tp,_betAmount));
	    }
		public String getplayerInfo()
		{
			String info=name;
			for(int i=0;i<blackJackPlayers.size();i++)
			{
				info+="@"+blackJackPlayers.get(i)._betAmount+","+blackJackPlayers.get(i).point1+","+blackJackPlayers.get(i).point2+","+blackJackPlayers.get(i).cardString+","+index+","+blackJackIndex;
			}
			return info;
		}
		public Card getCard()
		{
		    Card crd=blackJackPlayers.get(blackJackIndex).getCard();
		     myCards.put(crd.getcardId(),crd);
		     return crd;
		}
		
		public boolean cansplit()
		{
			 BlackJackPlayer currentBjp=blackJackPlayers.get(blackJackIndex);
			 String str[]=currentBjp.cardString.split("-");
			// System.out.print("split string++++++++++++++++++++++++"+str[0]+"OOOO"+str[1]+"ghhghg"+str.length);
			 int str1=Integer.parseInt(str[0]);
			 int str2=Integer.parseInt(str[1]);
			 if(str.length!=2)
			 {
				 return false;
			 }

	        if((str1%13)==(str2%13))
			 {
			   
			    return true;
			 }
			// blackJackIndex++;
	      return false;
			
		}
		public void setIsWin(String atr)
		{
			//System.out.print("setiswin"+atr);
			isWon=atr;
		}
		public void setWinAmount(double amt)
		{
			//System.out.print("setiswin amount"+amt);
			totalWinAmount=amt;
		}
		public boolean splitB()
		{
			 BlackJackPlayer currentBjp=blackJackPlayers.get(blackJackIndex);
			 String str[]=currentBjp.cardString.split("-");
		  //  System.out.print("ky ahua bhai "+cansplit());
     	      if(cansplit())
			 {

			    BlackJackPlayer bjp= new BlackJackPlayer(TCP,_betAmount); 
			    blackJackPlayers.add(bjp); 
			    currentBjp.point1=currentBjp.point1/2;
			    bjp.point1=currentBjp.point1;
			    currentBjp.point2=currentBjp.point2/2;
			    bjp.point2=currentBjp.point2;
   			    bjp.cardString=str[0];
			    currentBjp.cardString=str[0];

			    return true;
			 }

			// blackJackIndex++;
	      return false;
		}
		public void AddAmount(Double amount)
		{
			//_betAmount+=amount;
			blackJackPlayers.get(blackJackIndex)._betAmount+=amount;
		}
		public double getBetAmount()
		{
			return blackJackPlayers.get(blackJackIndex)._betAmount;
		}
		public boolean isGameOver()
		{
			return blackJackPlayers.get(blackJackIndex).isGameover;
		}
		public void setGameOver()
		{
		  blackJackPlayers.get(blackJackIndex).isGameover=true;
		}
		public int getBlackJackNextIndex()
		{
			//System.out.print("blackJackIndex+blackJackPlayers.size()"+blackJackIndex+blackJackPlayers.size());
			if(blackJackIndex==blackJackPlayers.size()-1)
			{
				blackJackIndex=0;
				return 0;
			}
			else
			{
				blackJackIndex++;
				return 1;
			}
				
		}
		public int getPoint1B()
		{
			return blackJackPlayers.get(blackJackIndex).point1;
		}
		public int getPoint2B()
		{
			return blackJackPlayers.get(blackJackIndex).point2;
		}
		public Card throughcard(int i)
		{ 
			if(myCards.containsKey(i))
			{
				Card crd=myCards.get(i);
				if(!crd.isPlayed)
				{
					crd.isPlayed=true;
					return crd;
				}
				else
					return null;
			}
			else
			{
 			        return null;
			}
		}
		public String[] setGameRecords(int gameid)
		{
			game_info[0]=name;
			game_info[1]=String.valueOf(gameid);
			game_info[2]=String.valueOf(getBetAmount());
			game_info[3]=blackJackPlayers.get(blackJackIndex).cardString;
			
			game_info[4]=isWon;
			game_info[5]=String.valueOf(totalWinAmount);
		//System.out.println("kya ghue"+name);
			return game_info;
			
		}


	
}