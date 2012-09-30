package airdatabase.errors
{
	import airdatabase.errors.messages.IErrorMessage;
	
	[ExcludeClass]
	public class NotImplementedError extends Error implements IError
	{
		public function NotImplementedError(description:String, id:int)
		{
			super(description, id);
		}
	}
}