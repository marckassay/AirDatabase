package airdatabase.schema
{
	import airdatabase.ADBStatement;
	import airdatabase.core.DataManipulator;
	import airdatabase.core.asl_internal;
	import airdatabase.interfaces.IDataNoun;

	use namespace asl_internal;
	
	public class DefaultTable extends AbstractTable
	{
		private var _manipulator:DataManipulator;
		
		/**
		 * Constructor's arguments are closed for MXML component implementation.
		 */
		public function DefaultTable()
		{
		}
		
		override public function select(result:Function=null, status:Function=null):IDataNoun
		{
			var statement:* = manipulator.select(result, status) as ADBStatement;
			statement.tableName = name;
			return statement;
		}
		
		override public function insert(result:Function=null, status:Function=null):IDataNoun
		{
			var statement:ADBStatement = manipulator.insert(result, status) as ADBStatement;
			statement.tableName = name;
			return statement;
		}
		
		override public function update(result:Function=null, status:Function=null):IDataNoun
		{
			var statement:ADBStatement = manipulator.update(result, status) as ADBStatement;
			statement.tableName = name;
			return statement;
		}
		
		override public function remove(result:Function=null, status:Function=null):IDataNoun
		{
			var statement:ADBStatement = manipulator.remove(result, status) as ADBStatement;
			statement.tableName = name;
			return statement;
		}
		
		asl_internal function get manipulator():DataManipulator
		{
			return _manipulator;
		}
		asl_internal function set manipulator(value:DataManipulator):void
		{
			_manipulator = value;
		}
	}
}