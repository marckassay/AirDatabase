package tests.airdatabase
{
	import airdatabase.ADBConfig;
	import airdatabase.ADBStatement;
	import airdatabase.core.DataManipulator;
	import airdatabase.core.asl_unit_testing;
	import airdatabase.filters.equals;
	import airdatabase.statement.DataManipulationVerb;
	
	import mockolate.mock;
	import mockolate.runner.MockolateRule;
	
	import org.flexunit.asserts.assertEquals;
	
	use namespace asl_unit_testing;
	
	
	public class ADBStatementTest
	{
		private const CHARACTERS:String = "Characters";
		
		private var fixture:ADBStatement;
		
		[Rule]
		public var rule:MockolateRule = new MockolateRule();
		
		[Mock(type="nice", args="getADBConfig")]
		public var manipulator:DataManipulator;
		
		
		public function getADBConfig():Array 
		{
			var arg1:ADBConfig = new ADBConfig();
			arg1.uri = "/This/Uri/WillNot/Be/Used";
			return [ arg1 ];
		}
		
		[Before]
		public function runBeforeEveryTest():void 
		{
			fixture = new ADBStatement();
		} 
		
		[After]
		public function runAfterEveryTest():void 
		{
			fixture = null;
		}
		
		[Test]
		public function testSelectAllMethodIsReturningAsExpected():void 
		{
			mock(manipulator).method('processADBStatement').args(fixture).returns(fixture);
			fixture.manipulator = manipulator;
			
			fixture.manipulationVerb = DataManipulationVerb.SELECT;
			
			var statement:ADBStatement = fixture.all().from(CHARACTERS);
			
			assertEquals(statement.text, "SELECT * FROM Characters");
		}
		
		[Test]
		public function testRemoveAllMethodIsReturningAsExpected():void 
		{
			mock(manipulator).method('processADBStatement').args(fixture).returns(fixture);
			fixture.manipulator = manipulator;
			
			fixture.manipulationVerb = DataManipulationVerb.REMOVE;
			
			var statement:ADBStatement = fixture.all().from(CHARACTERS);
			
			assertEquals(statement.text, "DELETE * FROM Characters");
		}
		
		[Test]
		public function testToMethodIsReturningAsExpected():void 
		{
			mock(manipulator).method('processADBStatement').args(fixture).returns(fixture);
			fixture.manipulator = manipulator;
			
			fixture.manipulationVerb = DataManipulationVerb.INSERT;
			
			var statement:ADBStatement = fixture.field('first', equals('Dagny')).to(CHARACTERS);
			
			assertEquals("INSERT INTO Characters (first) VALUES (:first)", statement.text);
			assertEquals(statement.parameters[':first'], 'Dagny');
		}
	}
}