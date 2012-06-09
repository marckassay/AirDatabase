package airsqlite.errors
{
	public class FilterError extends Error
	{
		public static var INCORRECT_FILTER:FilterError = new FilterError("The field method contains an unexpected filter with the name of ",10);
		
		public function FilterError(message:*="", id:*=0)
		{
			super(message, id);
		}
	}
}