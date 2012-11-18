package airdatabase.errors.messages
{
	import airdatabase.errors.NotImplementedError;
	
	public class NotImplementedErrorMessage extends BaseErrorMessage
	{
		/**
		 * Contains no token.
		 */
		public static const ERROR:NotImplementedErrorMessage = new NotImplementedErrorMessage(
		"The syntax that you have choosen may be correct, unfortunately it hasn't been implemented at this time in development." +
		"  Check for project updates or implement it on your own.  Feature not implemented: {feature}", 
		ErrorID.NotImplementedErrorMessage_ERROR_ID);
		
		public function NotImplementedErrorMessage(message:String, id:int)
		{
			super(message, id);
		}
	}
}