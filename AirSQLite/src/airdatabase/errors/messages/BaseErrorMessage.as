package airdatabase.errors.messages
{
	[ExcludeClass]
	public class BaseErrorMessage implements IErrorMessage
	{
		private var _message:String;
		private var _id:int;
		
		public function BaseErrorMessage(message:String, id:int)
		{
			_message = message;
			_id = id;
		}
		
		public function get message():String
		{
			return _message;
		}
		
		public function get id():int
		{
			return _id;
		}
	}
}