package airsqlite.statement
{
	final public class DataManipulationVerb
	{
		static public const SELECT:DataManipulationVerb = new DataManipulationVerb("SELECT");
		static public const CREATE:DataManipulationVerb = new DataManipulationVerb("INSERT");
		static public const UPDATE:DataManipulationVerb = new DataManipulationVerb("UPDATE");
		static public const REMOVE:DataManipulationVerb = new DataManipulationVerb("DELETE");
		
		private var _value:String;
		
		public function DataManipulationVerb(name:String)
		{
			_value = name;
		}
		
		public function get value():String
		{
			return _value;
		}
	}
}