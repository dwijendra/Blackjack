package games.casino.Blackjack;
import java.util.ArrayList;
import java.util.HashMap;


import it.gotoandplay.smartfoxserver.data.User;
//main Game code..............
public class GameStatus
{
   	public enum States { NOPLAYER, TIMER, GAMEON };
	public States state;
	public  GameStatus()
	{
		state=States.TIMER;	
	}
}
	
	

