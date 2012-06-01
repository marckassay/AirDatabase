package airsqlite.statement
{
	import airsqlite.filters.Filter;

	public class FieldObject
	{
		private var _field:String;
		private var _condition:*;
		
		public function FieldObject(field:String, condition:*)
		{
			_field 		= field;
			_condition 	= condition;
		}
		
		public function get field():String
		{
			return _field;
		}
		
		public function get condition():*
		{
			return _condition;
		}
		
		public function toSetValue():Boolean
		{
			return !(_condition is Filter);
		}
	}
}