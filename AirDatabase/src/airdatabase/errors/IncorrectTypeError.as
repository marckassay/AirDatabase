package airdatabase.errors
{
	import airdatabase.errors.messages.IErrorMessage;

	public class IncorrectTypeError extends Error implements IError
	{
		public function IncorrectTypeError(description:String, id:int)
		{
			super(description, id);
		}
	}
}