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
	
	import mockolate.received;
	import mockolate.runner.MockolateRule;
	
	import mx.utils.UIDUtil;
	
	import org.flexunit.asserts.assertEquals;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.instanceOf;
	
	use namespace asl_unit_testing;
	
	
	public class AirDatabaseEncryptionTest
	{
		[Rule]
		public var mocks:MockolateRule = new MockolateRule();
		
		[Mock(type="nice")]
		public var spy_config:ADBConfig;
		
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
			fixture.config = getASQLiteConfig(false);
			
			// exception should be thrown since the database is encrypted.
			var results:SQLResult = fixture.select().field('first', equals('Dagny')).field('last', equals('Taggart')).from('Characters');
		}
		
		[Test(description="At this point in development I'm not sure if its possible to tell if a SQLite is encrypted.  We create 2 sessions here using the same uid.")]
		public function testThatTwoSessionWithSameUIDAreSuccessful():void
		{
			var uid:String = UIDUtil.createUID();
			
			fixture.config = getASQLiteConfig(false, uid);
			
			fixture.insert().field('first', equals('Dagny')).field('last', equals('Taggart')).field('key', equals(3)).to('Characters');
			
			// close database file and null the fixture, but don't delete the db file...
			var databaseFile:File = File.applicationStorageDirectory.resolvePath(DATA_BASE_FILE);
			if(databaseFile.exists == true)
			{
				fixture.testManipulator.testSQL.close();
			}
			fixture = null;
			
			// create a new database session with the SAME uid used in the previous session...
			fixture = new AirDatabase();
			fixture.config = getASQLiteConfig(false, uid);
			
			// exception should be thrown since the database is encrypted.
			var results:SQLResult = fixture.select().field('first', equals('Dagny')).field('last', equals('Taggart')).from('Characters');

			assertEquals('Dagny', results.data[0].first);
			assertEquals('Taggart', results.data[0].last);
		}
		
		
		[Test(description="Make sure that AirDataBase is able to work correctly from a previous session that encrypted it.")]
		public function testThatSecondSessionIsSuccessfulAfterFirstSessionEncryptedIt():void
		{
			var uid:String = UIDUtil.createUID();
			
			fixture.config = getASQLiteConfig(false, uid);
			
			fixture.insert().field('first', equals('Dagny')).field('last', equals('Taggart')).field('key', equals(3)).to('Characters');
			
			// close database file and null the fixture, but don't delete the db file...
			var databaseFile:File = File.applicationStorageDirectory.resolvePath(DATA_BASE_FILE);
			if(databaseFile.exists == true)
			{
				fixture.testManipulator.testSQL.close();
			}
			fixture = null;
			
			// create a new database session WITHOUT passing a UID.  this will force to retrieve the ELS value...
			fixture = new AirDatabase();
			fixture.config = getASQLiteConfig(true);
			
			// exception should be thrown since the database is encrypted.
			var results:SQLResult = fixture.select().field('first', equals('Dagny')).field('last', equals('Taggart')).from('Characters');
			
			assertEquals('Dagny', results.data[0].first);
			assertEquals('Taggart', results.data[0].last);
		}
		
		[Test]
		public function testThatReencryptIsSuccessful():void
		{
			var uid_a:String = UIDUtil.createUID();
			var uid_b:String = UIDUtil.createUID();
			
			fixture.config = getASQLiteConfig(false, uid_a);
			
			fixture.insert().field('first', equals('Dagny')).field('last', equals('Taggart')).field('key', equals(3)).to('Characters');
			
			// close database file and null the fixture, but don't delete the db file...
			var databaseFile:File = File.applicationStorageDirectory.resolvePath(DATA_BASE_FILE);
			if(databaseFile.exists == true)
			{
				fixture.testManipulator.testSQL.close();
			}
			fixture = null;
			
			// create a new database session with a DIFFERENT uid...
			fixture = new AirDatabase();
			fixture.config = getASQLiteConfig(false, uid_b);
			
			var results:SQLResult = fixture.select().field('first', equals('Dagny')).field('last', equals('Taggart')).from('Characters');
			
			assertEquals('Dagny', results.data[0].first);
			assertEquals('Taggart', results.data[0].last);
		}
		
		[Test(expects="airdatabase.errors.IncorrectTypeError")]
		public function ensureThatIncorrectTypeErrorIsThrown():void
		{
			var incorrecttype:int = 123456789;
			fixture.config = getASQLiteConfig(false,incorrecttype);
		}
		
		// I cant seem to find out how to spy with mockolates.
		[Test]
		[Ignore]
		public function ensureThatAutogeneratedKeyIsCreated():void
		{
			var spyConfig:Function = function():ADBConfig
			{
				var config:ADBConfig 	 = spy_config;
				config.asyncConnection 	 = false;
				config.tables 			 = getTables();
				config.enableEncryption	 = true;
				config.uri 				 = DATA_BASE_FILE;
				
				return config;
			}
				
			fixture.config = spyConfig.call();
			
			assertThat(fixture.config, received().method('getByteArrayKey').once());
			assertThat(fixture.config, received().method('getByteArrayKey').arg( instanceOf(String) ));
		}
		
		[Test]
		[Ignore]
		public function ensureThatAutogeneratedKeyIsNotCreated():void
		{
			fixture.config = getASQLiteConfig(false, UIDUtil.createUID());
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
			
			if(encrypt == false)
				config.encryptionKey = key;
			
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