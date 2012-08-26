package airdatabase
{
	import flash.events.Event;
	
	public class ADBEvent extends Event
	{
		public static const CONNECTED:String 	= "ADBEvent.CONNECTED";
		public static const RESULT:String 		= "ADBEvent.RESULT";
		
		private var _data:*;
		
		
		public function ADBEvent(type:String, data:*=null)
		{
			super(type);
			
			_data = data;
		}
		
		override public function clone():Event
		{
			return new ADBEvent(type, data);
		}
		
		public function get data():*
		{
			return _data;
		}
	}
}