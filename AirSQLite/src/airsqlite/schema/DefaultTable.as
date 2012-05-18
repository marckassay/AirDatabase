package airsqlite.schema
{
	import airsqlite.ASLStatement;
	import airsqlite.core.DataManipulator;
	import airsqlite.core.asl_internal;
	import airsqlite.interfaces.IDataNoun;

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
			var statement:* = manipulator.select(result, status) as ASLStatement;
			statement.tableName = name;
			return statement;
		}
		
		override public function create(result:Function=null, status:Function=null):IDataNoun
		{
			var statement:ASLStatement = manipulator.create(result, status) as ASLStatement;
			statement.tableName = name;
			return statement;
		}
		
		override public function update(result:Function=null, status:Function=null):IDataNoun
		{
			var statement:ASLStatement = manipulator.update(result, status) as ASLStatement;
			statement.tableName = name;
			return statement;
		}
		
		override public function remove(result:Function=null, status:Function=null):IDataNoun
		{
			var statement:ASLStatement = manipulator.remove(result, status) as ASLStatement;
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