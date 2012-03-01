           package  
{
	/**
	 * ...
	 * @author
	 */
	import flash.display.DisplayObject;
    import flash.display.Sprite;

	 import flash.utils.getDefinitionByName;

	public class Resources
	{
		
		
		
		[Embed(source = "assets/V1Sound.swf", symbol = "backgroundsound")]
	public static var backgroundSound:Class;
	
		[Embed(source = "assets/V1Sound.swf", symbol = "tick")]
		public static var ticksound:Class;
		

		[Embed (source = "assets/EmotionIcons.swf" , symbol = "Emoticon")]
		public static var emoticons:Class;
	
        [Embed(source = "assets/New Bingo Background.swf", symbol = "ButtonPrize")]
	    public static var filtersym :Class;
		
		[Embed(source = "assets/New Bingo Background.swf", symbol = "ChatonoffScreen")]
	    public static var chatOnOff :Class;
		[Embed(source = "assets/New Bingo Background.swf", symbol = "UserBlockSymbol")]
	    public static var userBlockSymbol :Class;
		[Embed(source = "assets/New Bingo Background.swf", symbol = "RedBall")]
	    public static var redBall :Class;
		[Embed(source = "assets/New Bingo Background.swf", symbol = "BallGeneratorGlass")]
	    public static var ballGeneratorGlass :Class;
		[Embed(source = "assets/New Bingo Background.swf", symbol = "Clock")]
	    public static var clock:Class;
		//[Embed(source = "assets/BingoRoom.swf", symbol = "User")]
	    //public static var user:Class;
		[Embed(source = "assets/New Bingo Background.swf", symbol = "AnnounceSymbol")]
	    public static var announceSymbol:Class;
		[Embed(source = "assets/New Bingo Background.swf", symbol = "UserSlider")]
	    public static var userSlider:Class;
		[Embed(source = "assets/New Bingo Background.swf", symbol = "NumberGenerator")]
	    public static var numberGenerator:Class;
		[Embed(source = "assets/New Bingo Background.swf", symbol = "BingoCard")]
		public static var card:Class;
		[Embed(source = "assets/New Bingo Background.swf", symbol = "LobbySlider")]
		public static var lobbyslider:Class;
		[Embed(source = "assets/New Bingo Background.swf" , symbol = "oningame")]
		public static var OnInGame:Class;
		[Embed(source = "assets/New Bingo Background.swf" , symbol = "onnotingame")]
		public static var OnNotInGame:Class;
		[Embed(source = "assets/New Bingo Background.swf" , symbol = "offingame")]
		public static var OffInGame:Class;
		[Embed(source = "assets/New Bingo Background.swf", symbol = "BallScreen")]
	    public static var ballScreen:Class;
		
		[Embed(source = "assets/New Bingo Background.swf", symbol = "CashAmountScreen_Duch")]
	   public static var CashAmountScreen_Duch :Class;
		[Embed(source = "assets/New Bingo Background.swf", symbol = "GameAmountSymbol_Duch")]
	   public static var gameAmountSymbol_Duch :Class;
		[Embed(source = "assets/New Bingo Background.swf", symbol = "PattarnScreen_Duch")]
	    public static var patScreen_Duch:Class;
		[Embed(source = "assets/New Bingo Background.swf" , symbol = "BanedScreen_Duch")]
		public static var bannedScreen_Duch:Class;
		[Embed(source = "assets/New Bingo Background.swf" , symbol = "NotActiveScreen_Duch")]
		public static var nonActiveScreen_Duch:Class;
		[Embed(source = "assets/New Bingo Background.swf" , symbol = "FunScreen_Duch")]
		public static var funScreen_Duch:Class;
		[Embed(source = "assets/New Bingo Background.swf" , symbol = "pwinner_Duch")]
		public static var PWinner_Duch:Class;
		[Embed(source = "assets/New Bingo Background.swf" , symbol = "bwinner_Duch")]
		public static var BWinner_Duch:Class;

		[Embed(source = "assets/New Bingo Background.swf", symbol = "ErrorLoginScreen_Duch")]
		public static var errorloginScreen_Duch:Class;
	
		[Embed(source = "assets/New Bingo Background.swf", symbol = "BingoWinnerScreen_Duch")]
		 public static var bingoWinnerScreen_Duch:Class;
		[Embed(source = "assets/New Bingo Background.swf", symbol = "PatternWinnerScreen_Duch")]
		  public static var patternWinnerScreen_Duch:Class;
		[Embed(source = "assets/New Bingo Background.swf", symbol = "CardBuyScreen_Duch")]
	    public static var buyCardScreen_Duch:Class;
		[Embed(source = "assets/New Bingo Background.swf", symbol = "MusicScreen_Duch")]
	    public static var musicScreen_Duch:Class;
		[Embed(source = "assets/New Bingo Background.swf", symbol = "UserClickedScreen_Duch")]
	    public static var userClickedScreen_Duch:Class;
		[Embed(source = "assets/New Bingo Background.swf", symbol = "PrivateChatScreen_Duch")]
	    public static var privateChatScreen_Duch:Class;
		[Embed(source = "assets/New Bingo Background.swf", symbol = "BallGenerator")]
	    public static var ballGenerator:Class;
		[Embed(source = "assets/New Bingo Background.swf", symbol = "PublicChatScreen_Duch")]
	    public static var publicChatScreen_Duch:Class;
		[Embed(source = "assets/New Bingo Background.swf", symbol = "ConnectionBrokenScreen_Duch")]
	    public static var connectionBrokenScreen_Duch :Class;
		[Embed(source = "assets/New Bingo Background.swf", symbol = "KassaScreen_Duch")]
	    public static var kassaScreen_Duch :Class;
		[Embed(source = "assets/New Bingo Background.swf", symbol = "FunKassaScreen_Duch")]
	    public static var FunKassaScreen_Duch :Class;
		[Embed(source = "assets/New Bingo Background.swf", symbol = "CardContainer_Duch")]
	    public static var cardContainerButton_Duch:Class;
		
		
		[Embed(source = "assets/New Bingo Background.swf", symbol = "CashAmountScreen_Spenish")]
	   public static var CashAmountScreen_Spanish :Class;
		[Embed(source = "assets/New Bingo Background.swf", symbol = "GameAmountSymbol_Spenish")]
	   public static var gameAmountSymbol_Spanish :Class;
		[Embed(source = "assets/New Bingo Background.swf", symbol = "PattarnScreen_Spenish")]
	    public static var patScreen_Spanish:Class;
		[Embed(source = "assets/New Bingo Background.swf" , symbol = "BanedScreen_Spenish")]
		public static var bannedScreen_Spanish:Class;
		[Embed(source = "assets/New Bingo Background.swf" , symbol = "NotActiveScreen_Spenish")]
		public static var nonActiveScreen_Spanish:Class;
		[Embed(source = "assets/New Bingo Background.swf" , symbol = "FunScreen_Spenish")]
		public static var funScreen_Spanish:Class;
		[Embed(source = "assets/New Bingo Background.swf", symbol = "CardContainer_Spenish")]
	    public static var cardContainerButton_Spanish:Class;
		[Embed(source = "assets/New Bingo Background.swf" , symbol = "pwinner_Spenish")]
		public static var PWinner_Spanish:Class;
		[Embed(source = "assets/New Bingo Background.swf" , symbol = "bwinner_Spenish")]
		public static var BWinner_Spanish:Class;
		[Embed(source = "assets/New Bingo Background.swf" , symbol = "RoomSymbol_Spenish")]
   		public static var roomSymbolClass_Spanish:Class;
		[Embed(source = "assets/New Bingo Background.swf" , symbol = "RoomBackGround_Spenish")]
		public static var roomBG_Spanish:Class;
		[Embed(source = "assets/New Bingo Background.swf", symbol = "LoginScreen_Spenish")]
		public static var loginScreen_Spanish:Class;
		[Embed(source = "assets/New Bingo Background.swf", symbol = "ErrorLoginScreen_Spenish")]
		public static var errorloginScreen_Spanish:Class;
		[Embed(source = "assets/New Bingo Background.swf", symbol = "Background_Spenish")]
		public static var gameScreen_Spanish:Class;
		[Embed(source = "assets/New Bingo Background.swf", symbol = "BingoWinnerScreen_Spenish")]
		 public static var bingoWinnerScreen_Spanish:Class;
		[Embed(source = "assets/New Bingo Background.swf", symbol = "PatternWinnerScreen_Spenish")]
		  public static var patternWinnerScreen_Spanish:Class;
		[Embed(source = "assets/New Bingo Background.swf", symbol = "CardBuyScreen_Spenish")]
	    public static var buyCardScreen_Spanish:Class;
		[Embed(source = "assets/New Bingo Background.swf", symbol = "MusicScreen_Spenish")]
	    public static var musicScreen_Spanish:Class;
		[Embed(source = "assets/New Bingo Background.swf", symbol = "UserClickedScreen_Spenish")]
	    public static var userClickedScreen_Spanish:Class;
		[Embed(source = "assets/New Bingo Background.swf", symbol = "PrivateChatScreen_Spenish")]
	    public static var privateChatScreen_Spanish:Class;

		[Embed(source = "assets/New Bingo Background.swf", symbol = "PublicChatScreen_Spenish")]
	    public static var publicChatScreen_Spanish:Class;
		[Embed(source = "assets/New Bingo Background.swf", symbol = "ConnectionBrokenScreen_Spenish")]
	    public static var connectionBrokenScreen_Spanish :Class;
		[Embed(source = "assets/New Bingo Background.swf", symbol = "KassaScreen_Spenish")]
	    public static var kassaScreen_Spanish :Class;
		[Embed(source = "assets/New Bingo Background.swf", symbol = "FunKassaScreen_Spenish")]
	    public static var FunKassaScreen_Spanish :Class;
		
		
		[Embed(source = "assets/New Bingo Background.swf", symbol = "CashAmountScreen_German")]
	     public static var CashAmountScreen_Germany :Class;
		[Embed(source = "assets/New Bingo Background.swf", symbol = "GameAmountSymbol_German")]
	    public static var gameAmountSymbol_Germany :Class;
		[Embed(source = "assets/New Bingo Background.swf", symbol = "PattarnScreen_German")]
	    public static var patScreen_Germany:Class;
		[Embed(source = "assets/New Bingo Background.swf" , symbol = "BanedScreen_German")]
		public static var bannedScreen_Germany:Class;
		[Embed(source = "assets/New Bingo Background.swf" , symbol = "NotActiveScreen_German")]
		public static var nonActiveScreen_Germany:Class;
		[Embed(source = "assets/New Bingo Background.swf" , symbol = "FunScreen_German")]
		public static var funScreen_Germany:Class;
		[Embed(source = "assets/New Bingo Background.swf", symbol = "CardContainer_German")]
	    public static var cardContainerButton_Germany:Class;
		[Embed(source = "assets/New Bingo Background.swf" , symbol = "pwinner_German")]
		public static var PWinner_Germany:Class;
		[Embed(source = "assets/New Bingo Background.swf" , symbol = "bwinner_German")]
		public static var BWinner_Germany:Class;
		[Embed(source = "assets/New Bingo Background.swf" , symbol = "RoomSymbol_German")]
   		public static var roomSymbolClass_Germany:Class;
		[Embed(source = "assets/New Bingo Background.swf" , symbol = "RoomBackGround_German")]
		public static var roomBG_Germany:Class;
		[Embed(source = "assets/New Bingo Background.swf", symbol = "LoginScreen_German")]
		public static var loginScreen_Germany:Class;
		[Embed(source = "assets/New Bingo Background.swf", symbol = "ErrorLoginScreen_German")]
		public static var errorloginScreen_Germany:Class;
		[Embed(source = "assets/New Bingo Background.swf", symbol = "Background_German")]
		public static var gameScreen_Germany:Class;
		[Embed(source = "assets/New Bingo Background.swf", symbol = "BingoWinnerScreen_German")]
		 public static var bingoWinnerScreen_Germany:Class;
		[Embed(source = "assets/New Bingo Background.swf", symbol = "PatternWinnerScreen_German")]
		  public static var patternWinnerScreen_Germany:Class;
		[Embed(source = "assets/New Bingo Background.swf", symbol = "CardBuyScreen_German")]
	    public static var buyCardScreen_Germany:Class;
		[Embed(source = "assets/New Bingo Background.swf", symbol = "MusicScreen_German")]
	    public static var musicScreen_Germany:Class;
		[Embed(source = "assets/New Bingo Background.swf", symbol = "UserClickedScreen_German")]
	    public static var userClickedScreen_Germany:Class;
		[Embed(source = "assets/New Bingo Background.swf", symbol = "PrivateChatScreen_German")]
	    public static var privateChatScreen_Germany:Class;
	
		[Embed(source = "assets/New Bingo Background.swf", symbol = "PublicChatScreen_German")]
	    public static var publicChatScreen_Germany:Class;
		[Embed(source = "assets/New Bingo Background.swf", symbol = "ConnectionBrokenScreen_German")]
	    public static var connectionBrokenScreen_Germany :Class;
		[Embed(source = "assets/New Bingo Background.swf", symbol = "KassaScreen_German")]
	    public static var kassaScreen_Germany :Class;
		[Embed(source = "assets/New Bingo Background.swf", symbol = "FunKassaScreen_German")]
	    public static var FunkassaScreen_Germany :Class;
		//-----------------------------------slots---------------------
		[Embed(source = "assets/slotinfo.swf", symbol = "SlotScreen_Duch")]
	    public static var slotScreen_Duch :Class;
		[Embed(source = "assets/slotinfo.swf", symbol = "SlotInfoScreen_Duch")]
	    public static var slotInfoScreen_Duch :Class; 
		[Embed(source = "assets/slotinfo.swf", symbol = "CashAmountScreen_Duch")]
	    public static var cashAmountScreen_Duch :Class;
		[Embed(source = "assets/slotinfo.swf", symbol = "InfoSymbol")]
	    public static var infoSymbol:Class;
		[Embed(source = "assets/slotinfo.swf", symbol = "PublicChatScreen_Duch")]
	    public static var publicChatScreen:Class;
		[Embed (source = "assets/EmotionIcons.swf" , symbol = "smileWithSymbol")]
		public static var smilies:Class;

		
	
	   //-------------------------------------------------------------------blackjack
	   
	   [Embed(source = "assets/cardsold.swf", symbol = "txt")]
	    public static var txt:Class;
		 [Embed(source = "assets/blackjack.swf", symbol = "Background_Duch")]
	    public static var background_Duch:Class;
		 [Embed(source = "assets/blackjack.swf", symbol = "LoginScreen_Duch")]
	    public static var loginScreen_Duch:Class;
		 [Embed(source = "assets/blackjack.swf", symbol = "RoomBackGround_Duch")]
	    public static var roomBG_Duch:Class;
		
		[Embed(source = "assets/blackjack.swf", symbol = "BetScreen")]
	    public static var betScreen:Class;
		[Embed(source = "assets/blackjack.swf", symbol = "ButtonScreen")]
	    public static var buttonScreen:Class;
		
	    [Embed(source = "assets/cardsold.swf", symbol = "coin")]
		public static var coin:Class;
		[Embed(source = "assets/cardsold.swf", symbol = "WinSym")]
		public static var winSym:Class;
		[Embed(source = "assets/blackjack.swf" , symbol = "RoomSymbol_Duch")]
   		public static var roomSymbolClass_Duch:Class;
	   
		[Embed(source = "assets/cardsold.swf", symbol = "AnimatedCard")]
		public static var Cardback:Class;
		
	   [Embed(source = "assets/cardsold.swf", symbol = "Spade1")]
		public static var spade1:Class;
		
		
		 [Embed(source = "assets/cardsold.swf", symbol = "Spade2")]
		public static var spade2:Class;
		
		 [Embed(source = "assets/cardsold.swf", symbol = "Spade3")]
		public static var spade3:Class;
		
		 [Embed(source = "assets/cardsold.swf", symbol = "Spade4")]
		public static var spade4:Class;
		
		 [Embed(source = "assets/cardsold.swf", symbol = "Spade5")]
		public static var spade5:Class;
		
		 [Embed(source = "assets/cardsold.swf", symbol = "Spade6")]
		public static var spade6:Class;
		
		[Embed(source = "assets/cardsold.swf", symbol = "Spade7")]
		public static var spade7:Class;
		
		[Embed(source = "assets/cardsold.swf", symbol = "Spade8")]
		public static var spade8:Class;
		
		[Embed(source = "assets/cardsold.swf", symbol = "Spade9")]
		public static var spade9:Class;
		
		[Embed(source = "assets/cardsold.swf", symbol = "Spade10")]
		public static var spade10:Class;
		
		[Embed(source = "assets/cardsold.swf", symbol = "Spade11")]
		public static var spade11:Class;
		
		[Embed(source = "assets/cardsold.swf", symbol = "Spade12")]
		public static var spade12:Class;
		
		[Embed(source = "assets/cardsold.swf", symbol = "Spade13")]
		public static var spade13:Class;
		
		//2)club cardsold********************************************
		
		[Embed(source = "assets/cardsold.swf", symbol = "Club1")]
		public static var club1:Class;
		
		[Embed(source = "assets/cardsold.swf", symbol = "Club2")]
		public static var club2:Class;
		
		[Embed(source = "assets/cardsold.swf", symbol = "Club3")]
		public static var club3:Class;
		
		[Embed(source = "assets/cardsold.swf", symbol = "Club4")]
		public static var club4:Class;
		
		[Embed(source = "assets/cardsold.swf", symbol = "Club5")]
		public static var club5:Class;
		
		[Embed(source = "assets/cardsold.swf", symbol = "Club6")]
		public static var club6:Class;
		
		
		[Embed(source = "assets/cardsold.swf", symbol = "Club7")]
		public static var club7:Class;
		
		[Embed(source = "assets/cardsold.swf", symbol = "Club8")]
		public static var club8:Class;
		
		[Embed(source = "assets/cardsold.swf", symbol = "Club9")]
		public static var club9:Class;
		
		[Embed(source = "assets/cardsold.swf", symbol = "Club10")]
		public static var club10:Class;
		
		[Embed(source = "assets/cardsold.swf", symbol = "Club11")]
		public static var club11:Class;
		
		[Embed(source = "assets/cardsold.swf", symbol = "Club12")]
		public static var club12:Class;
		
		[Embed(source = "assets/cardsold.swf", symbol = "Club13")]
		public static var club13:Class;
		
		//3) heart cardsold**************************************
		
		[Embed(source = "assets/cardsold.swf", symbol = "Heart1")]
		public static var heart1:Class;
		
		[Embed(source = "assets/cardsold.swf", symbol = "Heart2")]
		public static var heart2:Class;
		
		[Embed(source = "assets/cardsold.swf", symbol = "Heart3")]
		public static var heart3:Class;
		
		[Embed(source = "assets/cardsold.swf", symbol = "Heart4")]
		public static var heart4:Class;
		
		[Embed(source = "assets/cardsold.swf", symbol = "Heart5")]
		public static var heart5:Class;
		
		[Embed(source = "assets/cardsold.swf", symbol = "Heart6")]
		public static var heart6:Class;
		
		[Embed(source = "assets/cardsold.swf", symbol = "Heart7")]
		public static var heart7:Class;
		
		[Embed(source = "assets/cardsold.swf", symbol = "Heart8")]
		public static var heart8:Class;
		
		[Embed(source = "assets/cardsold.swf", symbol = "Heart9")]
		public static var heart9:Class;
		
		[Embed(source = "assets/cardsold.swf", symbol = "Heart10")]
		public static var heart10:Class;
		
		[Embed(source = "assets/cardsold.swf", symbol = "Heart11")]
		public static var heart11:Class;
		
		[Embed(source = "assets/cardsold.swf", symbol = "Heart12")]
		public static var heart12:Class;
		
		[Embed(source = "assets/cardsold.swf", symbol = "Heart13")]
		public static var heart13:Class;
		
		// Diamond cardsold*****************************************
		
		[Embed(source = "assets/cardsold.swf", symbol = "Diamond1")]
		public static var diamond1:Class;
		
		[Embed(source = "assets/cardsold.swf", symbol = "Diamond2")]
		public static var diamond2:Class;
		
		[Embed(source = "assets/cardsold.swf", symbol = "Diamond3")]
		public static var diamond3:Class;
		
		[Embed(source = "assets/cardsold.swf", symbol = "Diamond4")]
		public static var diamond4:Class;
		
		[Embed(source = "assets/cardsold.swf", symbol = "Diamond5")]
		public static var diamond5:Class;
		
		[Embed(source = "assets/cardsold.swf", symbol = "Diamond6")]
		public static var diamond6:Class;
		
		[Embed(source = "assets/cardsold.swf", symbol = "Diamond7")]
		public static var diamond7:Class;
		
		[Embed(source = "assets/cardsold.swf", symbol = "Diamond8")]
		public static var diamond8:Class;
		
		[Embed(source = "assets/cardsold.swf", symbol = "Diamond9")]
		public static var diamond9:Class;
		
		[Embed(source = "assets/cardsold.swf", symbol = "Diamond10")]
		public static var diamond10:Class;
		
		[Embed(source = "assets/cardsold.swf", symbol = "Diamond11")]
		public static var diamond11:Class;
		
		[Embed(source = "assets/cardsold.swf", symbol = "Diamond12")]
		public static var diamond12:Class;
		
		[Embed(source = "assets/cardsold.swf", symbol = "Diamond13")]
		public static var diamond13:Class;
		
		public static var _cardArray:Array = [Cardback,spade1, spade2, spade3, spade4, spade5, spade6, spade7, spade8, spade9, spade10, spade11, spade12, spade13,heart1, heart2, heart3, heart4, heart5, heart6, heart7, heart8, heart9, heart10, heart11, heart12, heart13,club1,club2, club3, club4, club5, club6, club7, club8, club9, club10, club11, club12, club13, diamond1,diamond2, diamond3, diamond4, diamond5, diamond6, diamond7, diamond8, diamond9, diamond10, diamond11, diamond12, diamond13];
		
	//--a------------------------------------------------------------------------------------blackjack
	}
}