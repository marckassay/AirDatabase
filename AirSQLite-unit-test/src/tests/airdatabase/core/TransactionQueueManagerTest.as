package tests.airdatabase.core
{
	import airdatabase.ADBConfig;
	import airdatabase.ADBStatement;
	import airdatabase.core.DataConnector;
	import airdatabase.core.TransactionQueueManager;
	import airdatabase.core.asl_unit_testing;
	
	import mockolate.ingredients.Invocation;
	import mockolate.mock;
	import mockolate.runner.MockolateRule;
	
	import org.flexunit.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.instanceOf;

	use namespace asl_unit_testing;
	
	public class TransactionQueueManagerTest
	{
		private var fixture:TransactionQueueManager;
		
		[Rule]
		public var rule:MockolateRule = new MockolateRule();
		
		[Mock(args="getASQLiteConfig")]
		public var connector:DataConnector;
		
		public function getASQLiteConfig():Array 
		{
			var arg1:ADBConfig = new ADBConfig();
			arg1.uri = "/This/Uri/WillNot/Be/Used";
			return [ arg1 ];
		}
		
		
		[Before]
		public function runBeforeEveryTest():void 
		{
			fixture = new TransactionQueueManager();
		}
		
		[After]
		public function runAfterEveryTest():void 
		{
			fixture = null;
		}
		
		[Test]
		public function testForQueuedTransactionsLengthBecomesZero():void 
		{
			generateStatements(10);	
			
			mock(connector).method('executeStatement').args( instanceOf(ADBStatement) ).callsWithInvocation(function(invocation:Invocation):void 
			{
				fixture.processNextQueuedTransaction();
			});
			fixture.connector = connector;
			
			
			assertThat(fixture.queuedTransactions.length, equalTo(10));
			fixture.processNextQueuedTransaction();
			assertThat(fixture.queuedTransactions.length, equalTo(0));
		}
		
		private function generateStatements(number:int):void
		{
			while(number >= 1)
			{
				fixture.addTransactionToQueue(new ADBStatement());
				number --;
			}
		}
	}
}