package tests.airsqlite.statement
{
	import airsqlite.ASLStatement;
	import airsqlite.statement.delegates.InsertDelegate;
	
	import org.flexunit.asserts.assertEquals;
	
	public class InsertDelegateTest
	{
		private const CHARACTERS:String = "Characters";
		
		private var fixture:InsertDelegate;
		
		
		[Before]
		public function runBeforeEveryTest():void
		{
			fixture = new InsertDelegate();
		}
		
		[After]
		public function runAfterEveryTest():void
		{
			fixture = null;
		}
		
		[Ignore]
		[Test]
		public function testFieldInvocationConstructsColumnCorrectly():void 
		{
			//fixture.field('first').to(CHARACTERS);
			
			var statement:ASLStatement = new ASLStatement();
			
			fixture.constructStatement(statement);
			
			assertEquals("INSERT INTO Characters (first)", statement.text);
		}
	}
}