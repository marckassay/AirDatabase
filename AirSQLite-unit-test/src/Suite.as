package
{
	import tests.airsqlite.core.DataConnectorInSyncModeTest;
	import tests.airsqlite.core.DataManipulatorInSyncModeTest;
	import tests.airsqlite.core.TransactionQueueManagerTest;
	import tests.airsqlite.schema.DefaultTableTest;


	[Suite]
	[RunWith("org.flexunit.runners.Suite")]	
	public class Suite 
	{
		public var t1:TransactionQueueManagerTest;
		public var t2:DataConnectorInSyncModeTest;
		public var t3:DataManipulatorInSyncModeTest;
		public var t4:DefaultTableTest;
	}
}