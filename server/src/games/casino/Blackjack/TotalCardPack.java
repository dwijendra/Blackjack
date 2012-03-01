package games.casino.Blackjack;

import java.util.ArrayList;
import java.util.Collections;
public class TotalCardPack 
{
	private ArrayList<Card> totalCards;
	private int index;
	TotalCardPack(int i)
	{
		totalCards=new ArrayList<Card>();
		for(int k=0;k<i;k++)
		{
	      totalCards.addAll(new CardPack(k).getAllCards());
       	}
		index=totalCards.size();
		Collections.shuffle(totalCards);
	}
	
	public Card getCard()
	{
		if(index>0)
		{
		   index--;
		   return totalCards.get(index);
		}
		else
		{
			return null;
		}
		
	}
	
	

}
