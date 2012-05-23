package tests.airsqlite
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
	import org.hamcrest.object.nullValue;
	
	use namespace asl_unit_testing;
	
	
	public class ASLStatementTest
	{
		private const TABLE_A:String = "tableA";
		
		private var fixture:ASLStatement;	

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
			fixture = new ASLStatement();
		}   
		
		[After]  
		public function runAfterEveryTest():void 
		{   			
			fixture = null;  
		}
		
		[Test]
		public function testSelectMethodIsReturningAsExpected():void 
		{		
			mock(manipulator).method('processASLStatement').args(fixture).returns(fixture);
			fixture.manipulator = manipulator;
			
			fixture.manipulationVerb = DataManipulationVerb.SELECT;

			var statement:ASLStatement = fixture.all().from(TABLE_A);
			
			assertEquals(statement.text, "SELECT * FROM tableA");
		}
	}
}