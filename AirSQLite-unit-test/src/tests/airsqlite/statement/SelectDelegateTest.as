package tests.airsqlite.statement
{
	import airsqlite.ASLStatement;
	import airsqlite.filters.strings.contains;
	import airsqlite.statement.delegates.SelectDelegate;
	
	import org.flexunit.asserts.assertEquals;
	import airsqlite.filters.equals;

	public class SelectDelegateTest
	{		
		private const CHARACTERS:String = "Characters";
		
		private var fixture:SelectDelegate;	
		
		
		[Before]
		public function runBeforeEveryTest():void 
		{			
			fixture = new SelectDelegate();
		}
		
		[After]
		public function runAfterEveryTest():void 
		{   			
			fixture = null;  
		}
		
		[Test]
		public function testSelectMethodIsReturningAsExpected():void 
		{
			fixture.field('first', equals('Dagny')).from(CHARACTERS);
			
			var statement:ASLStatement = new ASLStatement();
			
			fixture.constructStatement(statement);
			
			assertEquals(statement.text, "SELECT * FROM Characters WHERE first = :Dagny");
		}
	}
}