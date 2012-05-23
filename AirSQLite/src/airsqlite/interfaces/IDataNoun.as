package airsqlite.interfaces
{
	public interface IDataNoun
	{
		function record(reference:*):IDataPreposition
		function field(field:String, matcher:Object):IDataPreposition
	}
}