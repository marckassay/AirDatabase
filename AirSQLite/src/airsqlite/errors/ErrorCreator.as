package airsqlite.errors
{
	import airsqlite.core.asl_unit_testing;
	import airsqlite.errors.messages.FilterErrorMessage;
	import airsqlite.errors.messages.IErrorMessage;
	import airsqlite.errors.messages.NotImplementedErrorMessage;
	
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
				case 'airsqlite.errors.messages::FilterErrorMessage':
					product = new FilterError(description, message.id);
					break;
				
				case 'airsqlite.errors.messages::NotImplementedErrorMessage':
					product = new NotImplementedError(description, message.id);
					break;
				
				case 'airsqlite.errors.messages::IllegalStatementErrorMessage':
					product = new IllegalStatementError(description, message.id);
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

import airsqlite.errors.ErrorCreator;

class ErrorCreatorHolder
{
	public static var instance:ErrorCreator = new ErrorCreator();
}