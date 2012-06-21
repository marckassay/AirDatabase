package airsqlite.errors.messages
{
	public class IllegalStatementErrorMessage extends BaseErrorMessage
	{
		public static var INCORRECT_SYNTAX:IllegalStatementErrorMessage = new IllegalStatementErrorMessage("The syntax for this statement" +
			"is not correct.  Please refer to wiki article titled, 'Statement Syntax'.",30);
		
		public function IllegalStatementErrorMessage(message:String, id:int)
		{
			super(message, id);
		}
	}
}