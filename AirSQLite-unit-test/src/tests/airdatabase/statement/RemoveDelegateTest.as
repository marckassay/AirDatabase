package tests.airdatabase.statement
{
	import airdatabase.ADBStatement;
	import airdatabase.filters.equals;
	import airdatabase.filters.numbers.greaterThan;
	import airdatabase.statement.delegates.RemoveDelegate;
	
	import org.flexunit.asserts.assertEquals;
	
	public class RemoveDelegateTest
	{
		private const CHARACTERS:String = "Characters";
		
		private var fixture:RemoveDelegate;	
		
		
		[Before]
		public function runBeforeEveryTest():void 
		{
			fixture = new RemoveDelegate();
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
			
			var statement:ADBStatement = new ADBStatement();
			
			fixture.constructStatement(statement);
			
			assertEquals("DELETE FROM Characters WHERE first = :first", statement.text);
			assertEquals(statement.parameters[':first'], 'Dagny');
		}
		
		[Test]
		public function testFieldInvocationConstructsWhereAndClauseCorrectly():void 
		{
			fixture.field('first', equals('Dagny')).field('last', equals('Taggart')).from(CHARACTERS);
			
			var statement:ADBStatement = new ADBStatement();
			
			fixture.constructStatement(statement);
			
			assertEquals("DELETE FROM Characters WHERE first = :first AND last = :last", statement.text);
			assertEquals(statement.parameters[':first'], 'Dagny');
			assertEquals(statement.parameters[':last'], 'Taggart');
		}
		
		[Test]
		public function testFieldInvocationConstructsWhereAndAndClauseCorrectly():void 
		{
			fixture.field('first', equals('Dagny')).field('middle', equals('Zino')).field('last', equals('Taggart')).from(CHARACTERS);
			
			var statement:ADBStatement = new ADBStatement();
			
			fixture.constructStatement(statement);
			
			assertEquals("DELETE FROM Characters WHERE first = :first AND middle = :middle AND last = :last", statement.text);
			assertEquals(statement.parameters[':first'], 'Dagny');
			assertEquals(statement.parameters[':last'], 'Taggart');
			assertEquals(statement.parameters[':middle'], 'Zino');
		}
		
		[Test(expects="airdatabase.errors.FilterError")]
		public function testThatExceptionIsThrownForUnexpectedFilter():void
		{
			fixture.field('first', greaterThan(5)).to(CHARACTERS);
			
			var statement:ADBStatement = new ADBStatement();
			
			fixture.constructStatement(statement);
		}
		
		[Test(expects="airdatabase.errors.NotImplementedError")]
		public function testThatExceptionIsNotImplemented():void
		{
			fixture.record({}).to(CHARACTERS);
			
			var statement:ADBStatement = new ADBStatement();
			
			fixture.constructStatement(statement);
		}
	}
}