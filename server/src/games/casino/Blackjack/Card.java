package games.casino.Blackjack;

public class Card
{
	
    private int weight;
	private int color;
    private int cardId;
    private int cardValue;
    public boolean isPlayed;
	Card(int clr,int no )
	 {
		  color=clr;
		  cardId=no;
		  cardValue=(no-1)%13+1;
		  isPlayed=false;
	 }
	 public void setCardWeight(int wt)
   	 {
	    	weight=wt;
	 }
	 public int getcolor()
	 {
		 return color;
	 }
	 public int getWeight()
	 {
		 return weight;
	 }
	 public int getcardValue()
	 {
		 return cardValue;
	 }
	 public int getcardId()
	 {
		 return cardId;
	 }
	 
	    	
}
