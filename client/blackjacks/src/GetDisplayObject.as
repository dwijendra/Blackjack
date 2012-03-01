package  
{
	/**
	 * ...
	 * @author dwijendra
	 */
	public class GetDisplayObject
	{
		public static var i:int = 1;
		public static var registerArray:Array = [" http://www.myglobalgames.es/account/register.php", "http://www.myglobalgames.com/account/register.php", " http://www.myglobalgames.de/account/register.php"];
	    public static var pwd:Array = ["http://www.myglobalgames.es/account/forgotten_password.php", "http://www.myglobalgames.com/account/forgotten_password.php", "http://www.myglobalgames.de/account/account/forgotten_password.php"];
		public static var bonus1:Array = [ "Felicidades MyGlobalGames (€","Gefeliciteerd MyGlobalGames heeft (€","Herzlichen Glückwunsch MyGlobalGames (€"];
		public static var bonus2:Array = [")se ha sumado a la cantidad de Bingo.", ")toegevoegd aan het Bingo bedrag.", ")hat den Betrag Bingo hat"];
	    public static var declarationArray:Array = [" http://www.myglobalgames.es/pg/faq/", "http://www.myglobalgames.com/pg/faq/", "http://www.myglobalgames.de/pg/faq/"];
		public static var profileArray:Array = ["http://www.myglobalgames.es/pg/profile/", "http://www.myglobalgames.com/pg/profile/", "http://www.myglobalgames.de/pg/profile/"];
		public static var BalanceRequestArray:Array = ["http://omega.myglobalgames.es","http://omega.globalstarsgames.com","http://omega.myglobalgames.de"];
        public static var paymentArray:Array = ["https://secure.payments4all.com/es/", "https://secure.payments4all.com/nl/", "https://secure.payments4all.com/de/"];
		public static var winAnnounce1:Array = [ "Felicidades  "," Gefeliciteerd  "," Glückwünsche "];
		public static  var pwinAnnounce2:Array = [" con la cantidad de patrón € ", "  met het patroon bedrag van  €", "  mit gewinner der musters €"];
		public static  var bwinAnnounce2:Array = [" con la cantidad de  bingo €", "  met het bingo bedrag van  €", "  mit gewinner der bingo €"];
		public static var lng:String="_Dutch";
       // public static var lng:String="_Germany";
   //   public static var lng:String="_Spanish";

       
		


   		public static function setType():void
		{
			if (lng == "_Spanish")
			{
				i = 0;
			}
			if (lng == "_Dutch")
			{
				lng = "_Duch";
				i = 1;
			}
			if (lng == "_Germany")
			{
				i = 2;
			}
		}
	    public static function getBonusP1():String
		{
			return bonus1[i];
		}
		public static function winAnnounceP1():String
		{
			return winAnnounce1[i];
		}
		public static function pwinAnnounceP2():String
		{
			return pwinAnnounce2[i];
		}
		public static function bwinAnnounceP2():String
		{
			return bwinAnnounce2[i];
		}
		 public static function getBalanceRequestURL():String
		{
			return BalanceRequestArray[i];
		}
		 public static function getBonusP2():String
		{
			return bonus2[i];
		}
		 public static function getPaymentArray():String
		{
			return paymentArray[i];
		}
		 public static function getDeclarationArray():String
		{
			return declarationArray[i];
		}
		 public static function getProfileArray():String
		{
			return profileArray[i];
		}
	
		public function GetDisplayObject() 
		{
			
		}
		public static function getPath(cmd:int):String
		{
			setType();
			if (cmd == 1)
			{
				return pwd[i];
			}
			if (cmd == 2)
			{
				return registerArray[i];
			}
			return "0"
			
		}
		public static function getSymbol(str:String):*
		{
			var Symbol:*=new Resources[str+lng]();
			return Symbol;
		}
		
			
	}

}