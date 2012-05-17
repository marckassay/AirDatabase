package tests.airsqlite.core
{
	import airsqlite.ASLConfig;
	import airsqlite.core.DataManipulator;
	import airsqlite.core.DataConnector;
	import airsqlite.core.asl_unit_testing;
	import airsqlite.interfaces.ICRUDOperator;
	import airsqlite.interfaces.IDataColumn;
	import airsqlite.schema.DataTypes;
	import airsqlite.schema.DefaultColumn;
	import airsqlite.schema.DefaultTable;
	
	import flash.filesystem.File;
	
	use namespace asl_unit_testing;
	
	public class CRUDOperatorInSyncModeTest
	{
		private const DATA_BASE_FILE:String = "testing.db";
		
		private const TABLE_A:String 	= "tableA";
		private const KEY:String 		= "key";
		private const NAME:String 		= "name";
		
		private var fixture:DataManipulator;		
		
		
		[Before]
		public function runBeforeEveryTest():void 
		{			
			var config:ASLConfig 	 = new ASLConfig();
			config.asyncConnection 	 = false;
			config.tables 			 = tables;
			config.uri 				 = DATA_BASE_FILE;
			
			fixture 				 = new DataManipulator(config);
		}   
		
		[After]  
		public function runAfterEveryTest():void 
		{   
			deleteDataBaseFile();
			
			fixture 				= null;  
		}
		
		[Test(order="1")]
		public function testThatDataBaseFileHasBeenWrittenToDisk():void 
		{
			
		}
		
		private function deleteDataBaseFile():void
		{
			// delete db file on disk, if it exists.
			try
			{
				var databaseFile:File = File.applicationStorageDirectory.resolvePath(DATA_BASE_FILE);
				if(databaseFile.exists == true)
				{
					fixture.testSQL.close();
					databaseFile.deleteFile();
				}
			}
			catch(error:Error)
			{
				// swallow error if any.
			}
		}
		
		private function get tables():Vector.<ICRUDOperator>
		{
			var _tables:Vector.<ICRUDOperator> 	= new Vector.<ICRUDOperator>();
			var tableA:DefaultTable 			= new DefaultTable();
			tableA.id 							= TABLE_A;
			
			var columns:Vector.<IDataColumn> 	= new Vector.<IDataColumn>();
			var columnA:DefaultColumn			= new DefaultColumn();
			columnA.id 							= KEY;
			columnA.dataType 					= DataTypes.NUMERIC.value;
			columns.push(columnA);
			
			var columnB:DefaultColumn			= new DefaultColumn();
			columnB.id 							= NAME;
			columnB.dataType 					= DataTypes.TEXT.value;
			columns.push(columnB);
			
			tableA.columns = columns;
			_tables.push(tableA);
			
			return _tables;
		}
	}
}