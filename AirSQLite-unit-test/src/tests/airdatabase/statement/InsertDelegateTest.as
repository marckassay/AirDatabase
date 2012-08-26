package tests.airdatabase.statement
{
	import airdatabase.ADBStatement;
	import airdatabase.filters.equals;
	import airdatabase.filters.numbers.greaterThan;
	import airdatabase.statement.delegates.InsertDelegate;
	
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
		
		
		[Test]
		public function testThatOneFieldInvocationConstructCorrectly():void 
		{
			fixture.field('first', equals('Dagny')).to(CHARACTERS);
			
			var statement:ADBStatement = new ADBStatement();
			
			fixture.constructStatement(statement);
			
			assertEquals("INSERT INTO Characters (first) VALUES (:first)", statement.text);
			assertEquals(statement.parameters[':first'], 'Dagny');
		}
		
		[Test]
		public function testThatTwoFieldInvocationsConstructCorrectly():void 
		{
			fixture.field('first', equals('Dagny')).field('last', equals('Taggart')).to(CHARACTERS);
			
			var statement:ADBStatement = new ADBStatement();
			
			fixture.constructStatement(statement);
			
			assertEquals("INSERT INTO Characters (first, last) VALUES (:first, :last)", statement.text);
			assertEquals(statement.parameters[':first'], 'Dagny');
			assertEquals(statement.parameters[':last'], 'Taggart');
		}
		
		[Test]
		public function testThatThreeFieldInvocationsConstructCorrectly():void 
		{
			fixture.field('first', equals('Dagny')).field('last', equals('Taggart')).field('password', equals('Abc123')).to(CHARACTERS);
			
			var statement:ADBStatement = new ADBStatement();
			
			fixture.constructStatement(statement);
			
			assertEquals("INSERT INTO Characters (first, last, password) VALUES (:first, :last, :password)", statement.text);
			assertEquals(statement.parameters[':first'], 'Dagny');
			assertEquals(statement.parameters[':last'], 'Taggart');
			assertEquals(statement.parameters[':password'], 'Abc123');
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