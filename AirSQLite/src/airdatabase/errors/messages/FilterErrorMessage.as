package airdatabase.errors.messages
{
	import airdatabase.errors.FilterError;
	
	public class FilterErrorMessage extends BaseErrorMessage
	{
		/**
		 * Contains a token.
		 */
		public static var INCORRECT_FILTER:FilterErrorMessage = new FilterErrorMessage(
		"The field method contains an unexpected filter with the name of {nameOfFilter}.", 
		ErrorID.FilterErrorMessage_INCORRECT_FILTER_ID);
		
		public function FilterErrorMessage(message:String, id:int)
		{
			super(message, id);
		}
	}
}