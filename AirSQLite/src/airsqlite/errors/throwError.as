package airsqlite.errors
{
	import airsqlite.errors.messages.IErrorMessage;
	
	public function throwError(message:IErrorMessage, data:Object):Error
	{
		return ErrorCreator.getInstance().throwError(message, data);
	}
}