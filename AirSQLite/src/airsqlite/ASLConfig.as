package airsqlite
{
	import airsqlite.interfaces.ICRUDOperator;
	import airsqlite.schema.DefaultTable;
	
	import flash.filesystem.File;
	import flash.utils.ByteArray;

	public class ASLConfig 
	{
		private var _uri:String;
		
		private var _encryptionKey:ByteArray;
		
		private var _asyncConnection:Boolean;
				
		private var _tables:Vector.<ICRUDOperator>;
		
		/**
		 * Constructor's arguments are closed for MXML component implementation.
		 */
		public function ASLConfig()
		{
			_asyncConnection = false;
			//_tables = new Vector.<ASQLiteTable>(); 
		}
		
		
		public function get uri():String
		{
			return _uri;
		}
		public function set uri(value:String):void
		{
			_uri = value;
		}
		
		
		public function get tables():Vector.<ICRUDOperator>
		{
			return _tables;
		}
		public function set tables(value:Vector.<ICRUDOperator>):void
		{
			_tables = value;
		}

		
		[Inspectable(category="General", enumeration="false, true", defaultValue="false")]
		public function get asyncConnection():Boolean
		{
			return _asyncConnection;
		}
		public function set asyncConnection(value:Boolean):void
		{
			_asyncConnection = value;
		}
		
		
		public function get encryptionKey():ByteArray
		{
			return _encryptionKey;
		}
		public function set encryptionKey(value:ByteArray):void
		{
			_encryptionKey = value;
		}
	}
}