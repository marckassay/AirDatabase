package airdatabase.interfaces
{
	[ExcludeClass]
	public interface IDataPreposition
	{
		function from(tableName:String):*;
		function to(tableName:String):*;
	}
}