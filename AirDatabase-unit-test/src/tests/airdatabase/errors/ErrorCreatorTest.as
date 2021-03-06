package tests.airdatabase.errors
{
	import airdatabase.core.asl_unit_testing;
	import airdatabase.errors.ErrorCreator;
	import airdatabase.errors.FilterError;
	import airdatabase.errors.IllegalStatementError;
	import airdatabase.errors.messages.FilterErrorMessage;
	import airdatabase.errors.messages.IllegalStatementErrorMessage;
	
	import org.flexunit.asserts.assertEquals;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.instanceOf;
	
	
	use namespace asl_unit_testing;
	
	public class ErrorCreatorTest
	{
		private var fixture:ErrorCreator;
		
		[Before]
		public function runBeforeEveryTest():void 
		{
			fixture = new ErrorCreator();
		}
		
		[After]
		public function runAfterEveryTest():void 
		{
			fixture = null;
		}
		
		[Test]
		public function testThrowThatFactoryMethodIsWorkingWithTokens():void
		{
			var error:Error = fixture.testConstructError(FilterErrorMessage.INCORRECT_FILTER, {nameOfFilter: 'lessThen'}) as Error;
			
			assertThat(error, instanceOf(FilterError));
			assertEquals(error.errorID, FilterErrorMessage.INCORRECT_FILTER.id);
		}
		
		[Test]
		public function testThrowThatFactoryMethodIsWorkingWithoutTokens():void
		{
			var error:Error = fixture.testConstructError(IllegalStatementErrorMessage.INCORRECT_SYNTAX) as Error;
			
			assertThat(error, instanceOf(IllegalStatementError));
			assertEquals(error.errorID, IllegalStatementErrorMessage.INCORRECT_SYNTAX.id);
		}
		
		[Test]
		public function testReplaceTokensWithDataIsWorking():void
		{
			var message:String = fixture.testReplaceTokensWithData(FilterErrorMessage.INCORRECT_FILTER, {nameOfFilter: 'lessThen'});
			
			assertEquals("The field method contains an unexpected filter with the name of lessThen.", message);
		}

	}
}