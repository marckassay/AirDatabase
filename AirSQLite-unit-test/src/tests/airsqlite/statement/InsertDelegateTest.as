package tests.airsqlite.statement
{
	import airsqlite.ASLStatement;
	import airsqlite.errors.FilterError;
	import airsqlite.filters.equals;
	import airsqlite.filters.numbers.greaterThan;
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
		
		
		[Test]
		public function testThatOneFieldInvocationConstructCorrectly():void 
		{
			fixture.field('first', equals('Dagny')).to(CHARACTERS);
			
			var statement:ASLStatement = new ASLStatement();
			
			fixture.constructStatement(statement);
			
			assertEquals("INSERT INTO Characters (first) VALUES (:first)", statement.text);
			assertEquals(statement.parameters[':first'], 'Dagny');
		}
		
		[Test]
		public function testThatTwoFieldInvocationsConstructCorrectly():void 
		{
			fixture.field('first', equals('Dagny')).field('last', equals('Taggart')).to(CHARACTERS);
			
			var statement:ASLStatement = new ASLStatement();
			
			fixture.constructStatement(statement);
			
			assertEquals("INSERT INTO Characters (first, last) VALUES (:first, :last)", statement.text);
			assertEquals(statement.parameters[':first'], 'Dagny');
			assertEquals(statement.parameters[':last'], 'Taggart');
		}
		
		[Test]
		public function testThatThreeFieldInvocationsConstructCorrectly():void 
		{
			fixture.field('first', equals('Dagny')).field('last', equals('Taggart')).field('password', equals('Abc123')).to(CHARACTERS);
			
			var statement:ASLStatement = new ASLStatement();
			
			fixture.constructStatement(statement);
			
			assertEquals("INSERT INTO Characters (first, last, password) VALUES (:first, :last, :password)", statement.text);
			assertEquals(statement.parameters[':first'], 'Dagny');
			assertEquals(statement.parameters[':last'], 'Taggart');
			assertEquals(statement.parameters[':password'], 'Abc123');
		}
		[Ignore]
		[Test(expects="airsqlite.errors.FilterError")]
		public function testThatExceptionIsThrownForUnexpectedFilter():void
		{
			fixture.field('first', greaterThan(5)).to(CHARACTERS);
			
			var statement:ASLStatement = new ASLStatement();
			
			fixture.constructStatement(statement);
		}
	}
}