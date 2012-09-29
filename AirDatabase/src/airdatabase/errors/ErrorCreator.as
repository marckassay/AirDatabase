package airdatabase.errors
{
	import airdatabase.core.asl_unit_testing;
	import airdatabase.errors.messages.FilterErrorMessage;
	import airdatabase.errors.messages.IErrorMessage;
	import airdatabase.errors.messages.IncorrectTypeErrorMessage;
	import airdatabase.errors.messages.NotImplementedErrorMessage;
	
	import asx.string.replaceTokens;
	
	import flash.utils.getQualifiedClassName;
	
	use namespace asl_unit_testing;
	
	[ExcludeClass]
	public class ErrorCreator extends AbstractErrorCreator
	{
		public static function getInstance():ErrorCreator 
		{
			return ErrorCreatorHolder.instance;
		}
		
		override protected function constructError(message:IErrorMessage, data:Object=null):IError
		{
			var product:IError;
			
			var qualifiedNameSpace:String = getQualifiedClassName(message);
			var description:String = (data == null)? message.message : replaceTokensWithData(message, data);
			
			switch(qualifiedNameSpace)
			{
				case 'airdatabase.errors.messages::FilterErrorMessage':
					product = new FilterError(description, message.id);
					break;
				
				case 'airdatabase.errors.messages::NotImplementedErrorMessage':
					product = new NotImplementedError(description, message.id);
					break;
				
				case 'airdatabase.errors.messages::IllegalStatementErrorMessage':
					product = new IllegalStatementError(description, message.id);
					break;
				
				case 'airdatabase.errors.messages::IncorrectTypeErrorMessage':
					product = new IncorrectTypeError(description, message.id);
					break;
				
				case 'airdatabase.errors.messages::IncorrectValueErrorMessage':
					product = new IncorrectValueError(description, message.id);
					break;
			}
			
			return product;
		}
		
		private function replaceTokensWithData(message:IErrorMessage, data:Object):String
		{
			return replaceTokens(message.message, data);
		}
		
		asl_unit_testing function testConstructError(message:IErrorMessage, data:Object=null):IError
		{
			return constructError(message, data);
		}
		
		asl_unit_testing function testReplaceTokensWithData(message:IErrorMessage, data:Object):String
		{
			return replaceTokens(message.message, data);
		}
	}
}

import airdatabase.errors.ErrorCreator;

class ErrorCreatorHolder
{
	public static var instance:ErrorCreator = new ErrorCreator();
}