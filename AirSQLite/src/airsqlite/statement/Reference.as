package airsqlite.statement
{
	import airsqlite.ASLStatement;
	import airsqlite.interfaces.IDataNoun;
	import airsqlite.interfaces.IDataPreposition;

	public class Reference
	{		
	 	public function record(reference:*):void
		{
			if(reference is Object)
			{
				
			}
			else if((reference is String) || (reference is Number))
			{
			
			}
		}
		
		public function field(field:String, matcher:Object):void
		{
			
		}
	}
}