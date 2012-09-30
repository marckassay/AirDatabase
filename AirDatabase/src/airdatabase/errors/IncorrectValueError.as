package airdatabase.errors
{
	import airdatabase.errors.messages.IErrorMessage;
	
	[ExcludeClass]
	public class IncorrectValueError extends Error implements IError
	{
		public function IncorrectValueError(description:String, id:int)
		{
			super(description, id);
		}
	}
}