package airsqlite.statement.delegates
{
	import airsqlite.ASLStatement;
	import airsqlite.interfaces.IASLStatementDelegate;
	import airsqlite.interfaces.IDataPreposition;
	import airsqlite.statement.FieldObject;
	
	public class ASLStatementDelegate implements IASLStatementDelegate
	{		
		private var _tableName:String;
		
		protected var fields:Array;
		
		
		public function ASLStatementDelegate()
		{
			fields = new Array();	
		}
		
		public function constructStatement(statement:ASLStatement):void
		{
		}
		
		public function record(reference:*):IDataPreposition
		{
			return this;
		}
		
		public function field(field:String, condition:*):IDataPreposition
		{			
			fields.push(new FieldObject(field, condition));
			
			return this;
		}
		
		// IDataPreposition implementations
		public function from(tableName:String):*
		{			
			this.tableName = tableName;
		}
		
		public function to(tableName:String):*
		{				
			this.tableName = tableName;
		}
		
		
		public function get tableName():String
		{
			return _tableName;
		}
		public function set tableName(value:String):void
		{
			_tableName = value;
		}
	}
}