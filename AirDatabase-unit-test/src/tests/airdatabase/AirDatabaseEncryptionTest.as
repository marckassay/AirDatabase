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
	import flash.display.DisplayObject;
	import flash.filesystem.File;
	import flash.utils.ByteArray;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNull;
	
	use namespace asl_unit_testing;
	
	
	public class AirDatabaseEncryptionTest
	{
		private const DATA_BASE_FILE:String = "testing.db";
		
		private const CHARACTERS:String = "Characters";
		
		private var fixture:AirDatabase;
		
		
		[Before]
		public function runBeforeEveryTest():void 
		{
			fixture = new AirDatabase();
		}
		
		[After]
		public function runAfterEveryTest():void 
		{
			deleteDataBaseFile();
			
			fixture = null;
		}
		
		[Test(expects="flash.errors.SQLError")]
		public function testThatExceptionIsThrownForIncorrectEncrytionKey():void
		{
			fixture.config = getASQLiteConfig();

			fixture.insert().field('first', equals('Dagny')).field('last', equals('Taggart')).field('key', equals(3)).to('Characters');
			
			// close database file and null the fixture, but don't delete the db file...
			var databaseFile:File = File.applicationStorageDirectory.resolvePath(DATA_BASE_FILE);
			if(databaseFile.exists == true)
			{
				fixture.testManipulator.testSQL.close();
			}
			fixture = null;
			
			// create a new database session with encryption set to false...
			fixture = new AirDatabase();
			getASQLiteConfig(false);
			
			// exception should be thrown since the database is encrypted.
			var results:SQLResult = fixture.select().field('first', equals('Dagny')).field('last', equals('Taggart')).from('Characters');
			
			assertNull(results);
		}
		
		[Test(expects="airdatabase.errors.IncorrectTypeError")]
		public function ensureThatIncorrectTypeErrorIsThrown():void
		{
			fixture.config = getASQLiteConfig(true, new DisplayObject());
		}
		
		[Test]
		public function ensureThatAutogeneratedKeyIsCreated():void
		{
			
		}
		
		[Test]
		public function ensureThatAutogeneratedKeyIsNotCreated():void
		{
			
		}
		
		////////////////////////////////////////////
		// helper methods
		////////////////////////////////////////////
		
		private function getASQLiteConfig(encrypt:Boolean=true, key:*=null):ADBConfig
		{
			var config:ADBConfig 	 = new ADBConfig();
			config.asyncConnection 	 = false;
			config.tables 			 = getTables();
			config.enableEncryption	 = true;
			config.encryptionKey	 = key;
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