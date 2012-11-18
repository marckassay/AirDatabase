package airdatabase.core
{
	import airdatabase.ADBConfig;
	import airdatabase.ADBStatement;
	import airdatabase.interfaces.IDataNoun;
	import airdatabase.interfaces.IDataVerb;
	import airdatabase.statement.DataManipulationVerb;

	[ExcludeClass]
	public class DataManipulator extends DataConnector implements IDataVerb
	{
		public function DataManipulator(config:ADBConfig)
		{
			super(config);
		}

		public function select(result:Function=null, status:Function=null):IDataNoun
		{
			var statement:ADBStatement = initializeStatement(result, status);
			statement.manipulator 	   = this;
			statement.manipulationVerb = DataManipulationVerb.SELECT;
			return statement;
		}

		public function insert(result:Function=null, status:Function=null):IDataNoun
		{
			var statement:ADBStatement = initializeStatement(result, status);
			statement.manipulator 	   = this;
			statement.manipulationVerb = DataManipulationVerb.INSERT;
			return statement;
		}
		
		public function update(result:Function=null, status:Function=null):IDataNoun
		{
			var statement:ADBStatement = initializeStatement(result, status);
			statement.manipulator 	   = this;			
			statement.manipulationVerb = DataManipulationVerb.UPDATE;
			return statement;
		}
		
		public function remove(result:Function=null, status:Function=null):IDataNoun
		{
			var statement:ADBStatement = initializeStatement(result, status);
			statement.manipulator 	   = this;
			statement.manipulationVerb = DataManipulationVerb.REMOVE;
			return statement;
		}
		// TODO: this will need to support async connections, if async is every implemented
		public function close():void
		{
			sql.close();
			
			connected = false;
		}
		
		public function processADBStatement(statement:ADBStatement):*
		{
			return super.processStatement(statement);
		}
	}
}