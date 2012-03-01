package games.casino.Blackjack;

public class GetUrlClass {
	private int lang_index;
	//["http://omega.myglobalgames.es","http://omega.myglobalgames.com","http://omega.myglobalgames.de"];
    private String[] urls={"http://omega.globalstarsgames.com","http://omega.myglobalgames.es","http://omega.myglobalgames.de"};
	
	GetUrlClass(String ZoneName)
	{
		if(ZoneName.equals("BingoV1_Germany"))
		{
			lang_index=2;	
		}
	    if(ZoneName.equals("BingoV1_Duch"))
	     {
				lang_index=0;		
		 }
			
		if(ZoneName.equals("BingoV1_Spanish"))
		{
			lang_index=1;	
		}
		
	}
	public String getUrl()
	{
		return urls[lang_index];
	}

}
