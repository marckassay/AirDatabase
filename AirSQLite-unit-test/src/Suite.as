package
{
	import tests.airsqlite.ASLStatementTest;
	import tests.airsqlite.core.DataConnectorInSyncModeTest;
	import tests.airsqlite.core.DataManipulatorInSyncModeTest;
	import tests.airsqlite.core.TransactionQueueManagerTest;
	import tests.airsqlite.schema.DefaultTableTest;
	import tests.airsqlite.statement.InsertDelegateTest;
	import tests.airsqlite.statement.RemoveDelegateTest;
	import tests.airsqlite.statement.SelectDelegateTest;
	import tests.airsqlite.statement.UpdateDelegateTest;


	[Suite]
	[RunWith("org.flexunit.runners.Suite")]	
	public class Suite 
	{
		public var t1:TransactionQueueManagerTest;
		public var t2:DataConnectorInSyncModeTest;
		public var t3:DataManipulatorInSyncModeTest;
		public var t4:DefaultTableTest;
		
		public var t5:SelectDelegateTest;
		public var t6:InsertDelegateTest;
		public var t7:UpdateDelegateTest;
		public var t8:RemoveDelegateTest;
		
		public var t9:ASLStatementTest;
	}
}