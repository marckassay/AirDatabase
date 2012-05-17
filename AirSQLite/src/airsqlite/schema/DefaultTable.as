package airsqlite.schema
{
	import airsqlite.ASLStatement;
	import airsqlite.core.DataManipulator;
	import airsqlite.core.asl_internal;
	import airsqlite.interfaces.IDataNoun;

	use namespace asl_internal;
	
	
	public class DefaultTable extends AbstractTable
	{
		private var _connector:DataManipulator;
		
		/**
		 * Constructor's arguments are closed for MXML component implementation.
		 */
		public function DefaultTable()
		{
		}
		
		override public function select(result:Function=null, status:Function=null):IDataNoun
		{
			var statement:ASLStatement = connector.select(result, status) as ASLStatement;
			statement.tableName = name;
			return statement;
		}
		
		override public function create(result:Function=null, status:Function=null):IDataNoun
		{
			var statement:ASLStatement = connector.select(result, status) as ASLStatement;
			statement.tableName = name;
			return statement;
		}
		
		override public function update(result:Function=null, status:Function=null):IDataNoun
		{
			var statement:ASLStatement = connector.select(result, status) as ASLStatement;
			statement.tableName = name;
			return statement;
		}
		
		override public function remove(result:Function=null, status:Function=null):IDataNoun
		{
			var statement:ASLStatement = connector.select(result, status) as ASLStatement;
			statement.tableName = name;
			return statement;
		}
		
		asl_internal function get connector():DataManipulator
		{
			return _connector;
		}
		asl_internal function set connector(value:DataManipulator):void
		{
			_connector = value;
		}
	}
}