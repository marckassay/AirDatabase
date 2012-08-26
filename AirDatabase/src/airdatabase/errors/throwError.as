package airdatabase.errors
{
	import airdatabase.errors.messages.IErrorMessage;
	
	public function throwError(message:IErrorMessage, data:Object=null):void
	{
		throw ErrorCreator.getInstance().throwError(message, data);
	}
}