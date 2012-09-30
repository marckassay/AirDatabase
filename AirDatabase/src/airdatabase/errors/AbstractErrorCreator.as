package airdatabase.errors
{
	import airdatabase.errors.messages.IErrorMessage;
	
	import flash.errors.IllegalOperationError;
	
	[ExcludeClass]
	public class AbstractErrorCreator
	{
		public function throwError(message:IErrorMessage, data:Object=null):Error
		{
			var error:IError = constructError(message, data);
			return error as Error;
		}
		
		protected function constructError(message:IErrorMessage, data:Object=null):IError
		{
			throw new IllegalOperationError("Abstract method: must be overridden in a subclass.")
			return null;
		}
	}
}