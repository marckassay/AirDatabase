package airsqlite.errors
{
	import airsqlite.errors.messages.IErrorMessage;
	
	public function throwError(message:IErrorMessage, data:Object):void
	{
		throw ErrorCreator.getInstance().throwError(message, data);
	}
}