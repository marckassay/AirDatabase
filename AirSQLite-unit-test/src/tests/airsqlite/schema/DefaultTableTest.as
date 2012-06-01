package tests.airsqlite.schema
{
	import airsqlite.ASLConfig;
	import airsqlite.ASLStatement;
	import airsqlite.core.DataManipulator;
	import airsqlite.core.asl_internal;
	import airsqlite.core.asl_unit_testing;
	import airsqlite.interfaces.IDataNoun;
	import airsqlite.schema.DefaultTable;
	import airsqlite.statement.DataManipulationVerb;
	
	import mockolate.mock;
	import mockolate.runner.MockolateRule;
	
	import org.flexunit.asserts.assertEquals;
	
	use namespace asl_unit_testing;
	
	public class DefaultTableTest
	{
		private const TABLE_A:String = "tableA";

		private var fixture:DefaultTable;	
		
		[Rule]
		public var rule:MockolateRule = new MockolateRule();
		
		[Mock(type="nice", args="getASQLiteConfig")]
		public var manipulator:DataManipulator;
		
		
		public function getASQLiteConfig():Array 
		{
			var arg1:ASLConfig = new ASLConfig();
			arg1.uri = "/This/Uri/WillNot/Be/Used";
			return [ arg1 ];
		}
		
		[Before]
		public function runBeforeEveryTest():void 
		{			
			fixture = new DefaultTable();
			
			fixture.id = TABLE_A;
		}   
		
		[After]  
		public function runAfterEveryTest():void 
		{   			
			fixture = null;  
		}
		
		[Test(order="1")]
		public function testSelectMethodIsReturningAsExpected():void 
		{			
			var statement:ASLStatement = new ASLStatement();
			statement.manipulationVerb = DataManipulationVerb.SELECT;
			mock(manipulator).method('select').args(null, null).returns( statement );

			fixture.asl_internal::manipulator = manipulator;
			
			var result:IDataNoun = fixture.select();
			
			assertEquals((result as ASLStatement).tableName, TABLE_A);
			assertEquals(fixture.id, TABLE_A);
		}
		
		[Test(order="2")]
		public function testCreateMethodIsReturningAsExpected():void 
		{			
			var statement:ASLStatement = new ASLStatement()
			statement.manipulationVerb = DataManipulationVerb.CREATE;
			mock(manipulator).method('create').args(null, null).returns( statement );

			fixture.asl_internal::manipulator = manipulator;
			
			var result:IDataNoun = fixture.create();
			
			assertEquals((result as ASLStatement).tableName, TABLE_A);
			assertEquals(fixture.id, TABLE_A);
		}
		
		[Test(order="3")]
		public function testUpdateMethodIsReturningAsExpected():void 
		{			
			var statement:ASLStatement = new ASLStatement()
			statement.manipulationVerb = DataManipulationVerb.UPDATE;
			mock(manipulator).method('update').args(null, null).returns( statement );

			fixture.asl_internal::manipulator = manipulator;
			
			var result:IDataNoun = fixture.update();
			
			assertEquals((result as ASLStatement).tableName, TABLE_A);
			assertEquals(fixture.id, TABLE_A);
		}
		
		[Test(order="4")]
		public function testRemoveMethodIsReturningAsExpected():void 
		{			
			var statement:ASLStatement = new ASLStatement()
			statement.manipulationVerb = DataManipulationVerb.REMOVE;
			mock(manipulator).method('remove').args(null, null).returns( statement );

			fixture.asl_internal::manipulator = manipulator;
			
			var result:IDataNoun = fixture.remove();
			
			assertEquals((result as ASLStatement).tableName, TABLE_A);
			assertEquals(fixture.id, TABLE_A);
		}
	}
}