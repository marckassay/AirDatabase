package airsqlite.statement
{
	import airsqlite.interfaces.IDataNoun;
	import airsqlite.interfaces.IDataPreposition;

	public class Reference implements IDataNoun
	{
	 	public function record(reference:*):IDataPreposition
		{
			return null;
		}
		
		public function field(field:String, matcher:Object):IDataPreposition
		{
			return null;
		}
	}
}