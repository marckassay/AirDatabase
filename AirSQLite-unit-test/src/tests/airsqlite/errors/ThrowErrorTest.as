package tests.airsqlite.errors
{
	import airsqlite.errors.FilterError;
	import airsqlite.errors.IError;
	import airsqlite.errors.messages.FilterErrorMessage;
	import airsqlite.errors.throwError;
	
	import org.flexunit.assertThat;
	import org.flexunit.asserts.assertEquals;
	import org.hamcrest.object.instanceOf;

	public class ThrowErrorTest
	{
		[Test]
		public function testThrowThatFactoryIsWorking():void
		{
			var error:Error = throwError(FilterErrorMessage.INCORRECT_FILTER, {nameOfFilter: 'lessThen'});
			
			assertThat(error, instanceOf(FilterError));
			assertEquals(error.message, "The field method contains an unexpected filter with the name of lessThen.");
			assertEquals(error.errorID, FilterErrorMessage.INCORRECT_FILTER.id);
		}
		
		[Ignore]
		[Test(expects="airsqlite.errors.messages.FilterError")]
		public function testThrowThatItCanThrow():void
		{
			throwError(FilterErrorMessage.INCORRECT_FILTER, {nameOfFilter: 'lessThen'});
		}
	}
}