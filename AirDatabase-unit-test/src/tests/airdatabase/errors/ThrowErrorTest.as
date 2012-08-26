package tests.airdatabase.errors
{
	import airdatabase.errors.FilterError;
	import airdatabase.errors.messages.FilterErrorMessage;
	import airdatabase.errors.throwError;
	
	import org.flexunit.asserts.assertTrue;
	
	public class ThrowErrorTest
	{
		[Test(description="Testing here so that I am sure that it fully works.  This is how it is to be used in source code.")]
		public function testThrowThatItCanThrow():void
		{
			var filterErrorThrown:Boolean;
			
			try
			{	
				throwError(FilterErrorMessage.INCORRECT_FILTER, {nameOfFilter: 'lessThen'});
			}
			catch(error:FilterError)
			{
				filterErrorThrown = true;
			}
			
			assertTrue( filterErrorThrown );
		}
	}
}