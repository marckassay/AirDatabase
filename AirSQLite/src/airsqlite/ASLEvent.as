package airsqlite
{
	import flash.events.Event;
	
	public class ASLEvent extends Event
	{
		public static const CONNECTED:String 	= "ASLEvent.CONNECTED";
		public static const RESULT:String 		= "ASLEvent.RESULT";
		
		private var _data:*;
		
		
		public function ASLEvent(type:String, data:*=null)
		{
			super(type);
			
			_data = data;
		}
		
		override public function clone():Event
		{
			return new ASLEvent(type, data);
		}
		
		public function get data():*
		{
			return _data;
		}
	}
}