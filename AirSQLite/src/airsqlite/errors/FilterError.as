package airsqlite.errors
{
	import airsqlite.errors.messages.IErrorMessage;
	
	public class FilterError extends Error implements IError
	{
		public function FilterError(description:String, id:int)
		{
			super(description, id);
		}
	}
}