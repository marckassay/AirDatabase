package tests.airsqlite.schema
{
	import airsqlite.ASLConfig;
	import airsqlite.ASLStatement;
	import airsqlite.core.DataConnector;
	import airsqlite.core.DataManipulator;
	import airsqlite.core.asl_internal;
	import airsqlite.core.asl_unit_testing;
	import airsqlite.interfaces.IDataColumn;
	import airsqlite.interfaces.IDataNoun;
	import airsqlite.interfaces.IDataVerb;
	import airsqlite.schema.DataTypes;
	import airsqlite.schema.DefaultColumn;
	import airsqlite.schema.DefaultTable;
	
	import flash.data.SQLResult;
	import flash.filesystem.File;
	
	import mockolate.ingredients.Invocation;
	import mockolate.mock;
	import mockolate.runner.MockolateRule;
	import mockolate.stub;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertTrue;
	import org.hamcrest.core.anything;
	
	use namespace asl_unit_testing;
	
	public class DefaultTableTest
	{
		private const TABLE_A:String = "tableA";

		private var fixture:DefaultTable;	
		
		[Rule]
		public var rule:MockolateRule = new MockolateRule();
		
		[Mock(args="getASQLiteConfig")]
		public var manipulator:DataManipulator;
		
		//[Mock]
		//public var statement:ASLStatement;
		
		public function getASQLiteConfig():Array 
		{
			var arg1:ASLConfig = new ASLConfig();
			arg1.uri = "/This/Uri/WillNot/Be/Used";
			return [ arg1 ];
		}
		
		[Before]
		public function runBeforeEveryTest():void 
		{			
			fixture = new DefaultTable();
			
			fixture.id = TABLE_A;
		}   
		
		[After]  
		public function runAfterEveryTest():void 
		{   			
			fixture = null;  
		}
		
		[Ignore]
		[Test]
		public function testSelectMethodIsReturningAsExpected():void 
		{			
			mock(manipulator).method('select').args(anything()).callsWithInvocation(function(invocation:Invocation):ASLStatement 
			{
				return new ASLStatement();
			});

			fixture.asl_internal::manipulator = manipulator;
			
			var result:IDataNoun = fixture.select();
			
			assertEquals((result as ASLStatement).tableName, TABLE_A);
			assertEquals(fixture.id, TABLE_A);
		}
	}
}