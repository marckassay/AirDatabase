package airdatabase.errors
{
	import airdatabase.errors.messages.IErrorMessage;
	
	[ExcludeClass]
	public class FilterError extends Error implements IError
	{
		public function FilterError(description:String, id:int)
		{
			super(description, id);
		}
	}
}