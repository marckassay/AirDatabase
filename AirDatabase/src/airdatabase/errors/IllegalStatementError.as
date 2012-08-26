package airdatabase.errors
{
	import airdatabase.errors.messages.IErrorMessage;

	public class IllegalStatementError extends Error implements IError
	{
		public function IllegalStatementError(description:String, id:int)
		{
			super(description, id);
		}
	}
}