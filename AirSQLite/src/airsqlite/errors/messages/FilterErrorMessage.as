package airsqlite.errors.messages
{
	import airsqlite.errors.FilterError;
	
	public class FilterErrorMessage extends BaseErrorMessage
	{
		public static var INCORRECT_FILTER:FilterErrorMessage = new FilterErrorMessage("The field method contains an unexpected" +
			" filter with the name of {nameOfFilter}.",10);
		
		public function FilterErrorMessage(message:String, id:int)
		{
			super(message, id);
		}
	}
}