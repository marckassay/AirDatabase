package airsqlite
{
	import airsqlite.core.DataManipulator;
	import airsqlite.interfaces.IDataNoun;
	import airsqlite.interfaces.IDataPreposition;
	import airsqlite.statement.DataManipulationVerb;
	import airsqlite.statement.Reference;
	
	import flash.data.SQLStatement;
	import flash.net.Responder;
	
	
	public class ASLStatement extends SQLStatement implements IDataNoun, IDataPreposition
	{
		private var _manipulator:DataManipulator;
		
		private var _manipulationVerb:DataManipulationVerb;
		
		private var _tableName:String;
		
		private var _responder:Responder;
		
		private var prefetch:int = -1;
		
		private var reference:Reference;
		
		
		public function ASLStatement(result:Function=null, status:Function=null)
		{			
			if(result != null)
				_responder = new Responder(result, status);
			
			reference = new Reference();
		}
		
		/**
		 * This is called only by <code>DataConnector</code>.
		 */
		override public function execute(prefetch:int=-1, responder:Responder=null):void
		{
			super.execute(-1, this.responder);
		}
		
		/**
		 * This method sends this instance of <code>ASLStatement</code> to 
		 * <code>DataManipulator</code>.
		 */
		public function go():*
		{
			return _manipulator.processASLStatement(this);
		}

		
		// IDataNoun implementations
		public function record(reference:*):IDataPreposition
		{
			reference.record(reference);
			
			return this;
		}
		
		public function field(field:String, matcher:Object):IDataPreposition
		{
			reference.field(field, matcher);
			
			return this;
		}
		
		
		// IDataPreposition implementations
		public function from(tableName:String):*
		{			
			this.tableName = tableName;
			
			return go();
		}
		
		public function to(tableName:String):*
		{				
			this.tableName = tableName;
			
			return go();			
		}
		
		
		public function all():IDataPreposition
		{
			this.prefetch = -1;
			
			return this;
		}
		
		public function nextRecords(prefetch:int=1):IDataPreposition
		{
			this.prefetch = prefetch;
			
			return this;
		}
		/*
		public function previousRecords(prefetch:int=1):IDataPreposition
		{
			this.prefetch = prefetch * -1;
		}
		*/
		
		public function get responder():Responder
		{
			return _responder;
		}
		
		
		public function get manipulationVerb():DataManipulationVerb
		{
			return _manipulationVerb;
		}
		public function set manipulationVerb(value:DataManipulationVerb):void
		{
			_manipulationVerb = value;
		}

		
		public function get tableName():String
		{
			return _tableName;
		}
		public function set tableName(value:String):void
		{
			_tableName = value;
		}

		
		public function get manipulator():DataManipulator
		{
			return _manipulator;
		}
		public function set manipulator(value:DataManipulator):void
		{
			_manipulator = value;
		}
	}
}