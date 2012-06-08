package tests.airsqlite.statement
{
	import airsqlite.ASLStatement;
	import airsqlite.filters.equals;
	import airsqlite.statement.delegates.SelectDelegate;
	
	import org.flexunit.asserts.assertEquals;

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
		public function testFieldInvocationConstructsWhereClauseCorrectly():void 
		{
			fixture.field('first', equals('Dagny')).from(CHARACTERS);
			
			var statement:ASLStatement = new ASLStatement();
			
			fixture.constructStatement(statement);
			
			assertEquals("SELECT * FROM Characters WHERE first = :Dagny", statement.text);
		}
		
		[Test]
		public function testFieldInvocationConstructsWhereAndClauseCorrectly():void 
		{
			fixture.field('first', equals('Dagny')).field('last', equals('Taggart')).from(CHARACTERS);
			
			var statement:ASLStatement = new ASLStatement();
			
			fixture.constructStatement(statement);
			
			assertEquals("SELECT * FROM Characters WHERE first = :Dagny AND last = :Taggart", statement.text);
		}
		
		[Test]
		public function testFieldInvocationConstructsWhereAndAndClauseCorrectly():void 
		{
			fixture.field('first', equals('Dagny')).field('middle', equals('Zino')).field('last', equals('Taggart')).from(CHARACTERS);
			
			var statement:ASLStatement = new ASLStatement();
			
			fixture.constructStatement(statement);
			
			assertEquals("SELECT * FROM Characters WHERE first = :Dagny AND middle = :Zino AND last = :Taggart", statement.text);
		}
	}
}