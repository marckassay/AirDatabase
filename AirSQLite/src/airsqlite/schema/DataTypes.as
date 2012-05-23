package airsqlite.schema
{
	final public class DataTypes
	{
		static public const TEXT:DataTypes 		= new DataTypes("TEXT");
		static public const NUMERIC:DataTypes 	= new DataTypes("NUMERIC");
		static public const REAL:DataTypes 		= new DataTypes("REAL");
		static public const BOOLEAN:DataTypes 	= new DataTypes("Boolean");
		static public const DATE:DataTypes 		= new DataTypes("Date");
		static public const XML:DataTypes 		= new DataTypes("XML");
		static public const XMLLIST:DataTypes 	= new DataTypes("XMLLIST");
		static public const OBJECT:DataTypes 	= new DataTypes("Object");
		static public const NONE:DataTypes 		= new DataTypes("NONE");

		private var _value:String;

		public function DataTypes(name:String)
		{
			_value = name;
		}
		
		public function get value():String
		{
			return _value;
		}
	}
}