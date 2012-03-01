package games.casino.Blackjack;

import java.util.ArrayList;

public class CardPack
{
	private ArrayList<Card> totalCards;
	CardPack(int k)
	{
		totalCards=new ArrayList<Card>();
		for(int i=1;i<=52;i++)
		{
			totalCards.add(new Card(((k*52+i-1)/13)%4+1, k*52+i));
		}
		
	}
	public ArrayList<Card> getAllCards()
	 {
		return totalCards;
	 }

}
