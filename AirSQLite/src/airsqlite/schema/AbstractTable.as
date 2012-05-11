package airsqlite.schema
{
	import airsqlite.core.DataSender;
	import airsqlite.interfaces.ICRUDOperator;
	import airsqlite.interfaces.IDataColumn;
	
	import flash.errors.IllegalOperationError;
	
	import mx.utils.UIDUtil;

	public class AbstractTable implements ICRUDOperator
	{
		public static const DEFAULT_TABLE:String = "https://github.com/marckassay/airsqlite/default";
		
		private var _id:String;
		
		private var _name:String;
		
		private var _columns:Vector.<IDataColumn>;
		
		private var _sender:DataSender;
		
		
		public function AbstractTable()
		{
			_sender = DataSender.getInstance();
		}
		
		public function select(...params):*
		{
			throw new IllegalOperationError("AbstractTable's select() must be overridden by it's subclass.");
			
			return;
		}
		
		public function create(...params):*
		{
			throw new IllegalOperationError("AbstractTable's create() must be overridden by it's subclass.");
			
			return;
		}
		
		public function update(...params):*
		{
			throw new IllegalOperationError("AbstractTable's update() must be overridden by it's subclass.");
			
			return;
		}
		
		public function del(...params):*
		{
			throw new IllegalOperationError("AbstractTable's del() must be overridden by it's subclass.");
			
			return;
		}
		
		public function createPrimaryKey():String
		{
			return UIDUtil.createUID();	
		}
		
		public function isPrimaryKey(value:String):Boolean
		{
			return UIDUtil.isUID(value);	
		}
			
		
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
		
		
		public function get columns():Vector.<IDataColumn>
		{
			return _columns;
		}
		public function set columns(value:Vector.<IDataColumn>):void
		{
			_columns = value;
		}
		
		
		public function get sender():DataSender
		{
			return _sender;
		}
	}
}