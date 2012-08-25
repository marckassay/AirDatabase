package tests.airsqlite
{
	import airsqlite.ASLConfig;
	import airsqlite.AirSQLite;
	import airsqlite.core.asl_unit_testing;
	import airsqlite.filters.equals;
	import airsqlite.interfaces.IDataColumn;
	import airsqlite.interfaces.IDataVerb;
	import airsqlite.schema.DataTypes;
	import airsqlite.schema.DefaultColumn;
	import airsqlite.schema.DefaultTable;
	
	import flash.data.SQLResult;
	import flash.filesystem.File;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNotNull;
	
	use namespace asl_unit_testing;
	
	
	public class AirSQLiteTest
	{
		private const DATA_BASE_FILE:String = "testing.db";
		
		private const CHARACTERS:String = "Characters";
		
		private var fixture:AirSQLite;
		
		
		[Before]
		public function runBeforeEveryTest():void 
		{
			fixture = new AirSQLite();
			fixture.config = getASQLiteConfig();
		}
		
		[After]
		public function runAfterEveryTest():void 
		{
			deleteDataBaseFile();
		
			fixture = null;
		}
		
		[Test]
		public function testSelectMethod():void
		{
			fixture.insert().field('first', equals('Dagny')).field('last', equals('Taggart')).field('key', equals(3)).to('Characters');
			
			var results:SQLResult = fixture.select().field('last', equals('Taggart')).from('Characters');
			
			assertEquals((results.data[0] as Object).first, 'Dagny');
			assertEquals((results.data[0] as Object).last, 'Taggart');
			assertEquals((results.data[0] as Object).key, 3);
		}
		
		private function getASQLiteConfig():ASLConfig
		{
			var config:ASLConfig 	 = new ASLConfig();
			config.asyncConnection 	 = false;
			config.tables 			 = getTables();
			config.uri 				 = DATA_BASE_FILE;
			
			return config;
		}
		
		private function getTables():Vector.<IDataVerb>
		{
			var _tables:Vector.<IDataVerb> 		= new Vector.<IDataVerb>();
			var characters:DefaultTable 		= new DefaultTable();
			characters.id 						= CHARACTERS;
			
			var columns:Vector.<IDataColumn> 	= new Vector.<IDataColumn>();
			var columnA:DefaultColumn			= new DefaultColumn();
			columnA.id 							= 'first';
			columnA.dataType 					= DataTypes.TEXT.value;
			columns.push(columnA);
			
			var columnB:DefaultColumn			= new DefaultColumn();
			columnB.id 							= 'last';
			columnB.dataType 					= DataTypes.TEXT.value;
			columns.push(columnB);
			
			var columnC:DefaultColumn			= new DefaultColumn();
			columnC.id 							= 'key';
			columnC.dataType 					= DataTypes.NUMERIC.value;
			columns.push(columnC);
			
			characters.columns = columns;
			_tables.push(characters);
			
			return _tables;
		}
		
		private function deleteDataBaseFile():void
		{
			// delete db file on disk, if it exists.
			try
			{
				var databaseFile:File = File.applicationStorageDirectory.resolvePath(DATA_BASE_FILE);
				if(databaseFile.exists == true)
				{
					fixture.testManipulator.testSQL.close();
					
					databaseFile.deleteFile();
				}
			}
			catch(error:Error)
			{
				// swallow error if any.
			}
		}
	}
}