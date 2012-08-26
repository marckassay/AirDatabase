package tests.airdatabase.statement
{
	import airdatabase.ADBStatement;
	import airdatabase.filters.equals;
	import airdatabase.filters.numbers.greaterThan;
	import airdatabase.statement.delegates.InsertDelegate;
	import airdatabase.statement.delegates.UpdateDelegate;
	
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
		public function testThatOneFieldInvocationConstructedCorrectly():void 
		{
			fixture.field('first', equals('Dagny')).where().field('last', equals('Taggart')).to(CHARACTERS);
			
			var statement:ADBStatement = new ADBStatement();
			
			fixture.constructStatement(statement);
			
			assertEquals("UPDATE Characters SET first = :first WHERE last = :last", statement.text);
			assertEquals(statement.parameters[':first'], 'Dagny');
			assertEquals(statement.parameters[':last'], 'Taggart');
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