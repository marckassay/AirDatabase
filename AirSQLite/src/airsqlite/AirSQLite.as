package airsqlite
{
	import airsqlite.core.DataManipulator;
	import airsqlite.core.asl_internal;
	import airsqlite.interfaces.IDataVerb;
	import airsqlite.interfaces.IDataNoun;
	
	use namespace asl_internal;
	
	public class AirSQLite implements IDataVerb
	{		
		private var _config:ASLConfig;

		private var manipulator:DataManipulator;
		
		
		/**
		 * Constructor is arguments are closed for MXML component implementation.
		 */
		public function AirSQLite()
		{
		}
		
		public function select(result:Function=null, status:Function=null):IDataNoun
		{
			return manipulator.select(result,status);
		}
		
		public function create(result:Function=null, status:Function=null):IDataNoun
		{
			return manipulator.create(result,status);
		}
		
		public function update(result:Function=null, status:Function=null):IDataNoun
		{
			return manipulator.update(result,status);
		}
		
		public function remove(result:Function=null, status:Function=null):IDataNoun
		{
			return manipulator.remove(result,status);
		}
		
		
		public function get config():ASLConfig
		{
			return _config;
		}
		public function set config(value:ASLConfig):void
		{
			_config = value;
			
			manipulator = new DataManipulator(value);
		}
	}
}