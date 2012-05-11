package
{
	import tests.airsqlite.core.CRUDOperatorInSyncModeTest;
	import tests.airsqlite.core.DataConnectorInSyncModeTest;
	import tests.airsqlite.core.TransactionQueueManagerTest;


	[Suite]
	[RunWith("org.flexunit.runners.Suite")]	
	public class Suite 
	{
		public var t1:TransactionQueueManagerTest;
		public var t2:DataConnectorInSyncModeTest;
		public var t3:CRUDOperatorInSyncModeTest;
	}
}