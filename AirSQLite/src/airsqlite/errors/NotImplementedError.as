package airsqlite.errors
{
	public class NotImplementedError extends Error
	{
		public static const ERROR:NotImplementedError = new NotImplementedError("The syntax that you have choosen may be correct, " +
			"unfortunately it hasn't been implemented at this time in development.  Check for project updates or implement it on your own.",20);
		
		public function NotImplementedError(message:*="", id:*=0)
		{
			super(message, id);
		}
	}
}