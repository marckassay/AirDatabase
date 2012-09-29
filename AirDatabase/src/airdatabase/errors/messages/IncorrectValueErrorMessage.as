package airdatabase.errors.messages
{
	import airdatabase.errors.FilterError;
	
	public class IncorrectValueErrorMessage extends BaseErrorMessage
	{
		/**
		 * Contains a token.
		 */
		public static var INCORRECT_VALUE:IncorrectValueErrorMessage = new IncorrectValueErrorMessage(
		"Although the class member can accept {type} values, it must meet the following condition(s): {condition}", 
		ErrorID.IncorrectValueErrorMessage_ERROR_ID);
		
		public function IncorrectValueErrorMessage(message:String, id:int)
		{
			super(message, id);
		}
	}
}