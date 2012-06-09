package airsqlite.filters
{
	public class Filter
	{
		private var _filter:String;
		private var _operator:String;
		private var _value:*;
		
		public function Filter(filter:String, operator:String, value:*)
		{
			_filter		= filter;
			_operator 	= operator;
			_value 		= value;
		}
		
		public function get filter():String
		{
			return _filter;
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