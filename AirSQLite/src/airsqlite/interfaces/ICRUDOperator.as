package airsqlite.interfaces
{
	import airsqlite.interfaces.IDataColumn;
	
	import flash.net.Responder;

	public interface ICRUDOperator
	{
		function select(...params):*
		function create(...params):*
		function update(...params):*
		function del(...params):*
	}
}