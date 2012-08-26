package tests.airdatabase.core
{
	import airdatabase.ADBConfig;
	import airdatabase.ADBStatement;
	import airdatabase.core.DataManipulator;
	import airdatabase.interfaces.IDataNoun;
	import airdatabase.statement.DataManipulationVerb;
	
	import org.flexunit.assertThat;
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertStrictlyEquals;
	import org.hamcrest.object.instanceOf;
	
	
	public class DataManipulatorInSyncModeTest
	{
		private const DATA_BASE_FILE:String = "testing.db";
	
		private var fixture:DataManipulator;
		
		[Before]
		public function runBeforeEveryTest():void 
		{
			var config:ADBConfig = new ADBConfig();
			config.asyncConnection 	 = false;
			config.uri				 = DATA_BASE_FILE;
			
			fixture = new DataManipulator(config);
		}
		
		[After]  
		public function runAfterEveryTest():void 
		{
			fixture = null;  
		}
		
		[Test]
		public function testSelectMethodIsReturningAsExpected():void 
		{
			var result:Function = function():void{};
			var status:Function = function():void{};
			
			var statement:IDataNoun = fixture.select(result, status);
			
			assertThat(statement, instanceOf(ADBStatement));
			assertStrictlyEquals((statement as ADBStatement).manipulator, fixture);
			
			assertEquals((statement as ADBStatement).manipulationVerb, DataManipulationVerb.SELECT);
		}
		
		[Test]
		public function testInsertMethodIsReturningAsExpected():void 
		{
			var result:Function = function():void{};
			var status:Function = function():void{};
			
			var statement:IDataNoun = fixture.insert(result, status);
			
			assertThat(statement, instanceOf(ADBStatement));
			assertStrictlyEquals((statement as ADBStatement).manipulator, fixture);
			assertEquals((statement as ADBStatement).manipulationVerb, DataManipulationVerb.INSERT);
		}
		
		[Test]
		public function testUpdateMethodIsReturningAsExpected():void 
		{
			var result:Function = function():void{};
			var status:Function = function():void{};
			
			var statement:IDataNoun = fixture.update(result, status);
			
			assertThat(statement, instanceOf(ADBStatement));
			assertStrictlyEquals((statement as ADBStatement).manipulator, fixture);
			assertEquals((statement as ADBStatement).manipulationVerb, DataManipulationVerb.UPDATE);
		}
		
		[Test]
		public function testRemoveMethodIsReturningAsExpected():void 
		{
			var result:Function = function():void{};
			var status:Function = function():void{};
			
			var statement:IDataNoun = fixture.remove(result, status);
			
			assertThat(statement, instanceOf(ADBStatement));
			assertStrictlyEquals((statement as ADBStatement).manipulator, fixture);
			assertEquals((statement as ADBStatement).manipulationVerb, DataManipulationVerb.REMOVE);
		}
	}
}