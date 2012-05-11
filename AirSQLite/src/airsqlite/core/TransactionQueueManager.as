package airsqlite.core
{
	import airsqlite.core.asl_unit_testing;
	import airsqlite.ASLStatement;

	use namespace asl_unit_testing;
	
	[ExcludeClass]
	public class TransactionQueueManager
	{
		private var _connector:DataConnector;
		private var _queuedTransactions:Array;
		
		
		public function TransactionQueueManager(connector:DataConnector=null)
		{
			_connector = connector;
			
			_queuedTransactions = new Array();
		}
		
		public function addTransactionToBeginningOfQueue(statement:ASLStatement):void
		{			
			_queuedTransactions.unshift(statement);
		}
		
		public function addTransactionToQueue(statement:ASLStatement):void
		{			
			_queuedTransactions.push(statement);
		}
		
		public function processNextQueuedTransaction():void
		{
			if(_queuedTransactions.length > 0)
			{
				var nextTransaction:ASLStatement = _queuedTransactions.shift() as ASLStatement;
				
				connector.executeStatement(nextTransaction);
			}
		}
		
		asl_unit_testing function get connector():DataConnector
		{
			return _connector;
		}
		asl_unit_testing function set connector(value:DataConnector):void
		{
			_connector = value;
		}
		
		asl_unit_testing function get queuedTransactions():Array
		{
			return _queuedTransactions;
		}
	}
}