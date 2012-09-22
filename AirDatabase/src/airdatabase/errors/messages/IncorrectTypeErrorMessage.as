package airdatabase.errors.messages
{
	import airdatabase.errors.FilterError;
	
	public class IncorrectTypeErrorMessage extends BaseErrorMessage
	{
		/**
		 * Contains a token.
		 */
		public static var INCORRECT_TYPE:IncorrectTypeErrorMessage = new IncorrectTypeErrorMessage(
		"Although the class member is declared as a wildcard (*) type, it only excepts the following types: {possibleTypes}", 
		ErrorID.IncorrectTypeErrorMessage_ERROR_ID);
		
		public function IncorrectTypeErrorMessage(message:String, id:int)
		{
			super(message, id);
		}
	}
}