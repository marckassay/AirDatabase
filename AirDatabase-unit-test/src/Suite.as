package
{
	import tests.airdatabase.ADBConfigTest;
	import tests.airdatabase.ADBStatementTest;
	import tests.airdatabase.AirDatabaseEncryptionTest;
	import tests.airdatabase.AirDatabaseTest;
	import tests.airdatabase.core.DataConnectorInSyncModeTest;
	import tests.airdatabase.core.DataManipulatorInSyncModeTest;
	import tests.airdatabase.core.TransactionQueueManagerTest;
	import tests.airdatabase.errors.ErrorCreatorTest;
	import tests.airdatabase.errors.ThrowErrorTest;
	import tests.airdatabase.schema.DefaultTableTest;
	import tests.airdatabase.statement.InsertDelegateTest;
	import tests.airdatabase.statement.RemoveDelegateTest;
	import tests.airdatabase.statement.SelectDelegateTest;
	import tests.airdatabase.statement.UpdateDelegateTest;
	
	
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
		
		public var t9:ADBStatementTest;
		public var t10:AirDatabaseTest;
		public var t11:AirDatabaseEncryptionTest;
		
		public var t12:ThrowErrorTest;
		public var t13:ErrorCreatorTest;
		
		public var t14:ADBConfigTest;
	}
}