package airsqlite.core
{
	import airsqlite.ASLConfig;
	import airsqlite.ASLStatement;
	import airsqlite.interfaces.IDataNoun;
	import airsqlite.interfaces.IDataVerb;
	import airsqlite.statement.DataManipulationVerb;

	[ExcludeClass]
	public class DataManipulator extends DataConnector implements IDataVerb
	{
		public function DataManipulator(config:ASLConfig)
		{
			super(config);
		}

		public function select(result:Function=null, status:Function=null):IDataNoun
		{
			var statement:ASLStatement = initializeStatement(result, status);
			statement.manipulator 	   = this;
			statement.manipulationVerb = DataManipulationVerb.SELECT;
			return statement;
		}

		public function insert(result:Function=null, status:Function=null):IDataNoun
		{
			var statement:ASLStatement = initializeStatement(result, status);
			statement.manipulator 	   = this;
			statement.manipulationVerb = DataManipulationVerb.INSERT;
			return statement;
		}
		
		public function update(result:Function=null, status:Function=null):IDataNoun
		{
			var statement:ASLStatement = initializeStatement(result, status);
			statement.manipulator 	   = this;			
			statement.manipulationVerb = DataManipulationVerb.UPDATE;
			return statement;
		}
		
		public function remove(result:Function=null, status:Function=null):IDataNoun
		{
			var statement:ASLStatement = initializeStatement(result, status);
			statement.manipulator 	   = this;
			statement.manipulationVerb = DataManipulationVerb.REMOVE;
			return statement;
		}
		
		public function processASLStatement(statement:ASLStatement):*
		{
			return super.processStatement(statement);
		}
	}
}