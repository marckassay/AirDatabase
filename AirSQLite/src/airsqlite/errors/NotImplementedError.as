package airsqlite.errors
{
	import airsqlite.errors.messages.IErrorMessage;

	public class NotImplementedError extends Error implements IError
	{
		public function NotImplementedError(description:String, id:int)
		{
			super(description, id);
		}
	}
}