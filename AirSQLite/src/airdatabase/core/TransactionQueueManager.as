package airdatabase.core
{
	import airdatabase.core.asl_unit_testing;
	import airdatabase.ADBStatement;

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
		
		public function addTransactionToBeginningOfQueue(statement:ADBStatement):void
		{			
			_queuedTransactions.unshift(statement);
		}
		
		public function addTransactionToQueue(statement:ADBStatement):void
		{			
			_queuedTransactions.push(statement);
		}
		
		public function processNextQueuedTransaction():void
		{
			if(_queuedTransactions.length > 0)
			{
				var nextTransaction:ADBStatement = _queuedTransactions.shift() as ADBStatement;
				
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