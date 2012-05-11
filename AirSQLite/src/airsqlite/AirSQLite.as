package airsqlite
{
	import airsqlite.interfaces.ICRUDOperator;
	import airsqlite.schema.AbstractTable;
	
	import flash.events.EventDispatcher;
	import airsqlite.core.CRUDOperator;
	import airsqlite.core.DataSender;
	
	public class AirSQLite extends EventDispatcher implements ICRUDOperator
	{		
		private var _config:ASLConfig;

		private var operator:CRUDOperator;
		
		private var sender:DataSender;
		
		/**
		 * Constructor is arguments are closed for MXML component implementation.
		 */
		public function AirSQLite()
		{
			sender = DataSender.getInstance();
		}
		
		public function select(...params):*
		{
			return table().select(params);
		}
		
		public function create(...params):*
		{
			return table().create(params);
		}
		
		public function update(...params):*
		{
			return table().update(params);
		}
		
		public function del(...params):*
		{
			return table().del(params);			
		}
		
		public function table(name:String=null):ICRUDOperator
		{
			if(name == null)
				name = AbstractTable.DEFAULT_TABLE;
			
			return operator.tables[name];
		}
		
		
		public function get config():ASLConfig
		{
			return _config;
		}
		public function set config(value:ASLConfig):void
		{
			_config = value;
			
			operator = new CRUDOperator(value);
		}
	}
}