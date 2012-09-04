package airdatabase.schema
{
	import airdatabase.core.DataSender;
	import airdatabase.core.asl_internal;
	import airdatabase.interfaces.IDataColumn;
	import airdatabase.interfaces.IDataNoun;
	import airdatabase.interfaces.IDataVerb;
	
	import flash.errors.IllegalOperationError;
	
	import mx.core.IMXMLObject;
	import mx.utils.UIDUtil;

	public class AbstractTable implements IDataVerb, IMXMLObject
	{
		/**
		 * This is to be as an alias to the first (or in some cases, only) table created.
		 * It can be accessed without using the AirDatabase <code>table</code> method.
		 * 
		 *	@see airdatabase.core.DataConnector#checkToCreateTables()
		 */
		asl_internal static const DEFAULT_TABLE:String = "https://github.com/marckassay/airdatabase/default";
		
		private var _id:String;
		
		private var _name:String;
		
		private var _columns:Vector.<IDataColumn>;
		
		private var _sender:DataSender;
		
		
		public function AbstractTable()
		{
			_sender = DataSender.getInstance();
		}
		
		public function select(result:Function=null, status:Function=null):IDataNoun
		{
			throw new IllegalOperationError("AbstractTable's select() must be overridden by it's subclass.");
			
			return;
		}
		
		public function insert(result:Function=null, status:Function=null):IDataNoun
		{
			throw new IllegalOperationError("AbstractTable's insert() must be overridden by it's subclass.");
			
			return;
		}
		
		public function update(result:Function=null, status:Function=null):IDataNoun
		{
			throw new IllegalOperationError("AbstractTable's update() must be overridden by it's subclass.");
			
			return;
		}
		
		public function remove(result:Function=null, status:Function=null):IDataNoun
		{
			throw new IllegalOperationError("AbstractTable's remove() must be overridden by it's subclass.");
			
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
		
		public function initialized(document:Object, id:String):void
		{
			_name = id;
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