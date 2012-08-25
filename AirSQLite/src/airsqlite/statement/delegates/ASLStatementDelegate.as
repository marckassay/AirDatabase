package airsqlite.statement.delegates
{
	import airsqlite.ASLStatement;
	import airsqlite.interfaces.IASLStatement;
	import airsqlite.interfaces.IASLStatementDelegate;
	import airsqlite.statement.FieldObject;
	
	import flash.errors.IllegalOperationError;
	
	public class ASLStatementDelegate implements IASLStatement
	{	
		private var _tableName:String;
		
		protected var fields:Array;
		
		protected var hasWhereBeenCalled:Boolean;
		
		protected var hasAllBeenCalled:Boolean;
		
		
		public function ASLStatementDelegate()
		{
			fields = new Array();
			hasWhereBeenCalled = false;
			hasAllBeenCalled = false;
		}
		
		public function constructStatement(statement:ASLStatement):void
		{
			throw new IllegalOperationError("ASLStatementDelegate's constructStatement() must be overridden by it's subclass.");
		}
		
		// IDataNoun implementations
		public function record(reference:*):IASLStatement
		{
			return this;
		}
		
		public function field(field:String, condition:*):IASLStatement
		{
			fields.push(new FieldObject(field, condition));
			
			return this;
		}
		
		public function where():IASLStatement
		{
			hasWhereBeenCalled = true;
			
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
		
		public function all():void
		{
			hasAllBeenCalled = true;
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