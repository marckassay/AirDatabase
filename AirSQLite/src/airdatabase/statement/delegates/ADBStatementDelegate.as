package airdatabase.statement.delegates
{
	import airdatabase.ADBStatement;
	import airdatabase.interfaces.IADBStatement;
	import airdatabase.interfaces.IADBStatementDelegate;
	import airdatabase.statement.FieldObject;
	
	import flash.errors.IllegalOperationError;
	
	public class ADBStatementDelegate implements IADBStatement
	{	
		private var _tableName:String;
		
		protected var fields:Array;
		
		protected var hasWhereBeenCalled:Boolean;
		
		protected var hasAllBeenCalled:Boolean;
		
		
		public function ADBStatementDelegate()
		{
			fields = new Array();
			hasWhereBeenCalled = false;
			hasAllBeenCalled = false;
		}
		
		public function constructStatement(statement:ADBStatement):void
		{
			throw new IllegalOperationError("ADBStatementDelegate's constructStatement() must be overridden by it's subclass.");
		}
		
		// IDataNoun implementations
		public function record(reference:*):IADBStatement
		{
			return this;
		}
		
		public function field(field:String, condition:*):IADBStatement
		{
			fields.push(new FieldObject(field, condition));
			
			return this;
		}
		
		public function where():IADBStatement
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