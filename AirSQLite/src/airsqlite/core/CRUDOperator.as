package airsqlite.core
{
	import airsqlite.ASLConfig;
	import airsqlite.interfaces.ICRUDOperator;
	import airsqlite.ASLStatement;

	[ExcludeClass]
	public class CRUDOperator extends DataConnector implements ICRUDOperator
	{
		public function CRUDOperator(config:ASLConfig)
		{
			super(config);
		}
	
		public function select(...params):*
		{
			var statement:ASLStatement = initializeStatement();
			
			// TODO: find the AbstractTable instance (invocator) in 
			// the param and retrive its 'name' field. This will be
			// used in the statement.text line below.
			var tableName:String;
			
			//statement.parameters[":tableName"] = tableName;
			//statement.text 			= "SELECT id, data FROM :tableName  WHERE id='"+id+"'";
			
			return processStatement(statement);
		}
		
		public function create(...params):*
		{
			var statement:ASLStatement = initializeStatement();
			
			//statement.parameters[":id"] = id;
			//statement.text 			= "INSERT INTO urlRequests (uri, data) VALUES (:uri, :data)"; 
			
			return processStatement(statement);
		}
		
		public function update(...params):*
		{
			var statement:ASLStatement = initializeStatement();
			
			//statement.parameters[":id"] = id;
			statement.text 				= "UPDATE urlRequests SET data = :data WHERE id = :id";
			
			return processStatement(statement);

		}
		
		public function del(...params):*
		{
			var statement:ASLStatement = initializeStatement();
			
			//statement.parameters[":id"] = id;
			//statement.text 				= "UPDATE urlRequests SET data = :data WHERE id = :id";
			
			return processStatement(statement);
		}
	}
}