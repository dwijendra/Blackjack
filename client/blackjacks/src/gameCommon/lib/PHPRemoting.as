package gameCommon.lib 
{
	
	/**
	 * ...
	 * @author ...
	 */
	import  flash.net.NetConnection;
	import flash.net.Responder;
	public class PHPRemoting 
	{
		
		public function PHPRemoting() 
		{
	
		}
		
		static public function initialize():void
		{
			var conn:NetConnection = new NetConnection();
			conn.connect(GameConstants.phpUrl);	
			var responder:Responder = new Responder(onResult, onFault);
			var arg:String = 'foo';
			conn.call( "HelloWorld.say", responder, arg);
		}
		
		static public function onResult( result:* ) : void
		{
			trace('onResult invoked');
			trace(result);
		}
		
		static public function onFault( fault : String ) : void
		{
			trace('onFault invoked');
			trace( fault );
		}		
	}	
}