package airsqlite.errors.messages
{
	import airsqlite.errors.NotImplementedError;
	
	public class NotImplementedErrorMessage extends BaseErrorMessage
	{
		public static const ERROR:NotImplementedErrorMessage = new NotImplementedErrorMessage("The syntax that you have choosen may be correct, " +
		"unfortunately it hasn't been implemented at this time in development.  Check for project updates or implement it on your own.",20);
		
		public function NotImplementedErrorMessage(message:String, id:int)
		{
			super(message, id);
		}
	}
}