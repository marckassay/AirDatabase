package tests.airdatabase
{
	import airdatabase.ADBConfig;
	import airdatabase.AirDatabase;
	import airdatabase.core.asl_unit_testing;
	import airdatabase.filters.equals;
	import airdatabase.interfaces.IDataColumn;
	import airdatabase.interfaces.IDataVerb;
	import airdatabase.schema.DataTypes;
	import airdatabase.schema.DefaultColumn;
	import airdatabase.schema.DefaultTable;
	
	import flash.data.SQLResult;
	import flash.filesystem.File;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNull;
	
	use namespace asl_unit_testing;
	
	
	public class AirDatabaseTest
	{
		private const DATA_BASE_FILE:String = "testing.db";
		
		private const CHARACTERS:String = "Characters";
		
		private var fixture:AirDatabase;
		
		
		[Before]
		public function runBeforeEveryTest():void 
		{
			fixture = new AirDatabase();
			fixture.config = getASQLiteConfig();
		}
		
		[After]
		public function runAfterEveryTest():void 
		{
			deleteDataBaseFile();
			
			fixture = null;
		}
		
		[Test]
		public function testSelectMethodByLastColumn():void
		{
			fixture.insert().field('first', equals('Dagny')).field('last', equals('Taggart')).field('key', equals(3)).to('Characters');
			
			var results:SQLResult = fixture.select().field('last', equals('Taggart')).from('Characters');
			
			assertEquals((results.data[0] as Object).first, 'Dagny');
			assertEquals((results.data[0] as Object).last, 'Taggart');
			assertEquals((results.data[0] as Object).key, 3);
		}
		
		[Test]
		public function testSelectMethodByKeyColumn():void
		{
			fixture.insert().field('first', equals('Dagny')).field('last', equals('Taggart')).field('key', equals(3)).to('Characters');
			
			var results:SQLResult = fixture.select().field('key', equals(3)).from('Characters');
			
			assertEquals((results.data[0] as Object).first, 'Dagny');
			assertEquals((results.data[0] as Object).last, 'Taggart');
			assertEquals((results.data[0] as Object).key, 3);
		}
		
		[Test]
		public function testRemoveMethodByKeyColumn():void
		{
			fixture.insert().field('first', equals('Dagny')).field('last', equals('Taggart')).field('key', equals(3)).to('Characters');
			
			var results:SQLResult = fixture.remove().field('key', equals(3)).from('Characters');
			
			assertNull(results.data);
		}
		
		[Test]
		public function testUpdateMethodByKeyColumn():void
		{
			fixture.insert().field('first', equals('Dgnya')).field('last', equals('Taggart')).field('key', equals(3)).to('Characters');
			
			fixture.update().field('first', equals('Dagny')).where().field('key', equals(3)).to('Characters');
			
			var results:SQLResult = fixture.select().field('key', equals(3)).from('Characters');
			
			assertEquals((results.data[0] as Object).first, 'Dagny');
			assertEquals((results.data[0] as Object).last, 'Taggart');
			assertEquals((results.data[0] as Object).key, 3);
		}
		
		
		////////////////////////////////////////////
		// helper methods
		////////////////////////////////////////////
		
		private function getASQLiteConfig():ADBConfig
		{
			var config:ADBConfig 	 = new ADBConfig();
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