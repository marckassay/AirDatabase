package tests.airsqlite.statement
{
	import airsqlite.ASLStatement;
	import airsqlite.filters.equals;
	import airsqlite.statement.delegates.InsertDelegate;
	import airsqlite.statement.delegates.UpdateDelegate;
	
	import org.flexunit.asserts.assertEquals;
	
	public class UpdateDelegateTest
	{
		private const CHARACTERS:String = "Characters";
		
		private var fixture:UpdateDelegate;
		
		
		[Before]
		public function runBeforeEveryTest():void
		{
			fixture = new UpdateDelegate();
		}
		
		[After]
		public function runAfterEveryTest():void
		{
			fixture = null;
		}
		
		
		[Test]
		public function testThatOneFieldInvocationConstructCorrectly():void 
		{
			fixture.field('first', equals('Dagny')).to(CHARACTERS);
			
			var statement:ASLStatement = new ASLStatement();
			
			fixture.constructStatement(statement);
			
			assertEquals("INSERT INTO Characters (first) VALUES ('Dagny')", statement.text);
		}
	}
}