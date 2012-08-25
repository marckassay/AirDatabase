package tests.airsqlite.core
{
	import airsqlite.ASLConfig;
	import airsqlite.ASLStatement;
	import airsqlite.core.DataConnector;
	import airsqlite.core.asl_unit_testing;
	import airsqlite.interfaces.IDataColumn;
	import airsqlite.interfaces.IDataVerb;
	import airsqlite.schema.DataTypes;
	import airsqlite.schema.DefaultColumn;
	import airsqlite.schema.DefaultTable;
	
	import flash.data.SQLResult;
	import flash.filesystem.File;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertTrue;
	
	use namespace asl_unit_testing;
	
	
	public class DataConnectorInSyncModeTest
	{
		private const DATA_BASE_FILE:String = "testing.db";
		
		private const CHARACTERS:String = "Characters";
		private const KEY:String 		= "key";
		private const NAME:String 		= "name";
		
		private var fixture:DataConnector;		
		
		[Before]
		public function runBeforeEveryTest():void 
		{			
			var config:ASLConfig = new ASLConfig();
			config.asyncConnection 	 = false;
			config.tables 			 = getTables();
			config.uri 				 = DATA_BASE_FILE;
			
			fixture 				 = new DataConnector(config);
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
			var statement:ASLStatement = fixture.testInitializeStatement();
			statement.text = "SELECT key FROM Characters";
			
			fixture.testProcessStatement(statement);
			
			assertTrue( fixture.testDataBaseFile.exists );
		}

		[Test(order="2")]
		public function testInsertAndSelectOperations():void 
		{
			var insertStatement:ASLStatement = fixture.testInitializeStatement();
			insertStatement.text = "INSERT INTO Characters (key, name) VALUES (3, 'Dagny Taggart')";
			fixture.testProcessStatement(insertStatement);
			
			var selectStatement:ASLStatement = fixture.testInitializeStatement();
			selectStatement.text = "SELECT name FROM Characters WHERE key='3'";
			var results:SQLResult = fixture.testProcessStatement(selectStatement);
			var name:String = results.data[0].name;
			
			assertEquals('Dagny Taggart', name);
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
		
		private function getTables():Vector.<IDataVerb>
		{
			var _tables:Vector.<IDataVerb> 		= new Vector.<IDataVerb>();
			var characters:DefaultTable 		= new DefaultTable();
			characters.id 						= CHARACTERS;
			
			var columns:Vector.<IDataColumn> 	= new Vector.<IDataColumn>();
			var columnA:DefaultColumn			= new DefaultColumn();
			columnA.id 							= KEY;
			columnA.dataType 					= DataTypes.NUMERIC.value;
			columns.push(columnA);
			
			var columnB:DefaultColumn			= new DefaultColumn();
			columnB.id 							= NAME;
			columnB.dataType 					= DataTypes.TEXT.value;
			columns.push(columnB);
			
			characters.columns = columns;
			_tables.push(characters);
			
			return _tables;
		}
	}
}