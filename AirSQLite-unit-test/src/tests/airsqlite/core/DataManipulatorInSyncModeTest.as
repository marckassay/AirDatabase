package tests.airsqlite.core
{
	import airsqlite.ASLConfig;
	import airsqlite.ASLStatement;
	import airsqlite.core.DataManipulator;
	import airsqlite.interfaces.IDataNoun;
	import airsqlite.statement.DataManipulationVerb;
	
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
			var config:ASLConfig = new ASLConfig();
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
			
			assertThat(statement, instanceOf(ASLStatement));
			assertStrictlyEquals((statement as ASLStatement).manipulator, fixture);
			
			assertEquals((statement as ASLStatement).manipulationVerb, DataManipulationVerb.SELECT);
		}
		
		[Test]
		public function testInsertMethodIsReturningAsExpected():void 
		{
			var result:Function = function():void{};
			var status:Function = function():void{};
			
			var statement:IDataNoun = fixture.insert(result, status);
			
			assertThat(statement, instanceOf(ASLStatement));
			assertStrictlyEquals((statement as ASLStatement).manipulator, fixture);
			assertEquals((statement as ASLStatement).manipulationVerb, DataManipulationVerb.INSERT);
		}
		
		[Test]
		public function testUpdateMethodIsReturningAsExpected():void 
		{
			var result:Function = function():void{};
			var status:Function = function():void{};
			
			var statement:IDataNoun = fixture.update(result, status);
			
			assertThat(statement, instanceOf(ASLStatement));
			assertStrictlyEquals((statement as ASLStatement).manipulator, fixture);
			assertEquals((statement as ASLStatement).manipulationVerb, DataManipulationVerb.UPDATE);
		}
		
		[Test]
		public function testRemoveMethodIsReturningAsExpected():void 
		{
			var result:Function = function():void{};
			var status:Function = function():void{};
			
			var statement:IDataNoun = fixture.remove(result, status);
			
			assertThat(statement, instanceOf(ASLStatement));
			assertStrictlyEquals((statement as ASLStatement).manipulator, fixture);
			assertEquals((statement as ASLStatement).manipulationVerb, DataManipulationVerb.REMOVE);
		}
	}
}