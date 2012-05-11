package airsqlite.schema
{
	import airsqlite.interfaces.IDataColumn;

	public class AbstractColumn implements IDataColumn
	{
		private var _id:String;
		private var _name:String;
		private var _dataType:String;
		private var _isPrimaryKey:Boolean;
				
		
		public function get id():String
		{
			return _id;
		}
		public function set id(value:String):void
		{
			_id = value;
			
			_name = value;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		
		[Inspectable(category="General", enumeration="TEXT,NUMERIC,REAL,BOOLEAN,DATE,XML,XMLLIST,OBJECT,NONE", defaultValue="TEXT")]
		public function get dataType():String
		{
			return _dataType;
		}
		public function set dataType(value:String):void
		{
			_dataType = value;
		}
		
		
		[Inspectable(category="General", enumeration="false,true", defaultValue="false")]
		public function get isPrimaryKey():Boolean
		{
			return _isPrimaryKey;
		}
		public function set isPrimaryKey(value:Boolean):void
		{
			_isPrimaryKey = value;
		}
	}
}