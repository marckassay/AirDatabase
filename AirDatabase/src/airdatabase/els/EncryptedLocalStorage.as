package airdatabase.els
{
	import flash.data.EncryptedLocalStore;
	import flash.utils.ByteArray;

	[ExcludeClass]
	public class EncryptedLocalStorage
	{
		static private const ENCRYPTION_KEY_NAME:String = "AirDatabaseKey";
		
		static public function getEncryptionKey():ByteArray
		{
			return EncryptedLocalStore.getItem(ENCRYPTION_KEY_NAME);
		}
		
		static public function setEncryptionKey(value:ByteArray):void
		{
			if(value != null)
			{
				EncryptedLocalStore.setItem(ENCRYPTION_KEY_NAME, value);
			}
			else
			{
				EncryptedLocalStore.removeItem(ENCRYPTION_KEY_NAME);
			}
		}
	}
}