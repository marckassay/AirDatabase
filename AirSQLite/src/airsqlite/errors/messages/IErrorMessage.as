package airsqlite.errors.messages
{
	public interface IErrorMessage
	{
		function get message():String;
		function get id():int;
	}
}