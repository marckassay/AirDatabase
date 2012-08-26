package airdatabase.interfaces
{
	public interface IDataVerb
	{
		function select(result:Function=null, status:Function=null):IDataNoun;
		function insert(result:Function=null, status:Function=null):IDataNoun;
		function update(result:Function=null, status:Function=null):IDataNoun;
		function remove(result:Function=null, status:Function=null):IDataNoun;
	}
}