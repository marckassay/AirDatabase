package airdatabase
{
	import airdatabase.core.DataManipulator;
	import airdatabase.core.asl_internal;
	import airdatabase.core.asl_unit_testing;
	import airdatabase.interfaces.IDataNoun;
	import airdatabase.interfaces.IDataVerb;
	
	use namespace asl_internal;
	
	public class AirDatabase implements IDataVerb
	{		
		private var _config:ADBConfig;

		private var manipulator:DataManipulator;
		
		
		/**
		 * Constructor's arguments are closed for MXML component implementation.
		 */
		public function AirDatabase()
		{
		}
		
		public function select(result:Function=null, status:Function=null):IDataNoun
		{
			return manipulator.select(result,status);
		}
		
		public function insert(result:Function=null, status:Function=null):IDataNoun
		{
			return manipulator.insert(result,status);
		}
		
		public function update(result:Function=null, status:Function=null):IDataNoun
		{
			return manipulator.update(result,status);
		}
		
		public function remove(result:Function=null, status:Function=null):IDataNoun
		{
			return manipulator.remove(result,status);
		}
		
		public function close():void
		{
			if(manipulator != null)
			{
				manipulator.close();
			}
		}
		
		public function get config():ADBConfig
		{
			return _config;
		}
		public function set config(value:ADBConfig):void
		{
			_config = value;
			
			manipulator = new DataManipulator(value);
		}
		
		asl_unit_testing function get testManipulator():DataManipulator
		{
			return manipulator;
		}
	}
}