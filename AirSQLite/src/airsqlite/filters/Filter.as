package airsqlite.filters
{
	public class Filter
	{
		private var _operator:String;
		private var _value:*;
		
		public function Filter(operator:String, value:*)
		{
			_operator 	= operator;
			_value 		= value;
		}
		
		public function get operator():String
		{
			return _operator;
		}
		
		public function get value():*
		{
			return _value;
		}
		
		public function get colonValue():String
		{
			return ":"+(_value as Object).toString();
		}
	}
}