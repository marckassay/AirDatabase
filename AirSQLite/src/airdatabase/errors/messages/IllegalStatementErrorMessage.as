package airdatabase.errors.messages
{
	public class IllegalStatementErrorMessage extends BaseErrorMessage
	{
		/**
		 * Contains no token.
		 */
		public static var INCORRECT_SYNTAX:IllegalStatementErrorMessage = new IllegalStatementErrorMessage(
		"The syntax for this statement is not correct.  Please refer to wiki article titled, 'Statement Syntax'.",
		ErrorID.IllegalStatementErrorMessage_INCORRECT_SYNTAX_ID);
		
		public function IllegalStatementErrorMessage(message:String, id:int)
		{
			super(message, id);
		}
	}
}