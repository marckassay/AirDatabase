package tests.airsqlite.statement
{
	import airsqlite.ASLStatement;
	import airsqlite.filters.equals;
	import airsqlite.filters.numbers.greaterThan;
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
			
			assertEquals("SELECT * FROM Characters WHERE first = :first", statement.text);
			assertEquals(statement.parameters[':first'], 'Dagny');
		}
		
		[Test]
		public function testFieldInvocationConstructsWhereAndClauseCorrectly():void 
		{
			fixture.field('first', equals('Dagny')).field('last', equals('Taggart')).from(CHARACTERS);
			
			var statement:ASLStatement = new ASLStatement();
			
			fixture.constructStatement(statement);
			
			assertEquals("SELECT * FROM Characters WHERE first = :first AND last = :last", statement.text);
			assertEquals(statement.parameters[':first'], 'Dagny');
			assertEquals(statement.parameters[':last'], 'Taggart');
		}
		
		[Test]
		public function testFieldInvocationConstructsWhereAndAndClauseCorrectly():void 
		{
			fixture.field('first', equals('Dagny')).field('middle', equals('Zino')).field('last', equals('Taggart')).from(CHARACTERS);
			
			var statement:ASLStatement = new ASLStatement();
			
			fixture.constructStatement(statement);
			
			assertEquals("SELECT * FROM Characters WHERE first = :first AND middle = :middle AND last = :last", statement.text);
			assertEquals(statement.parameters[':first'], 'Dagny');
			assertEquals(statement.parameters[':last'], 'Taggart');
			assertEquals(statement.parameters[':middle'], 'Zino');
		}
		
		[Test(expects="airsqlite.errors.FilterError")]
		public function testThatExceptionIsThrownForUnexpectedFilter():void
		{
			fixture.field('first', greaterThan(5)).to(CHARACTERS);
			
			var statement:ASLStatement = new ASLStatement();
			
			fixture.constructStatement(statement);
		}
		
		[Test(expects="airsqlite.errors.NotImplementedError")]
		public function testThatExceptionIsNotImplemented():void
		{
			fixture.record({}).to(CHARACTERS);
			
			var statement:ASLStatement = new ASLStatement();
			
			fixture.constructStatement(statement);
		}
	}
}