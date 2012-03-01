package games.casino.Blackjack;

public class BlackJackPlayer 
{
	private TotalCardPack TCP;
	public int point1;
	public int point2;
	public String cardString;
	public Double _betAmount;
	public Boolean isGameover;
	public BlackJackPlayer(TotalCardPack tp,Double bet)
	{
	    _betAmount=bet;
		point1=0;
		point2=0;
		cardString="";
		TCP=tp;
		isGameover=false;
	}
	public Card getCard()
	{
	  Card crd= TCP.getCard();
	  if(cardString.equals(""))
	  {
		  cardString=Integer.toString(crd.getcardId());
	  }
	  else
	  {
		  cardString+="-"+crd.getcardId(); 
	  }
	  if(crd.getcardValue()==1)
	  {
		 point1+=1; 
		 point2+=11;
	  }
	  else if(crd.getcardValue()>10)
	  {
		 point1+=10;
		 point2+=10;
	  }
	  else
	  {
		  point1+=crd.getcardValue();
		  point2+=crd.getcardValue();
	  }
	  return crd;
	}

}
