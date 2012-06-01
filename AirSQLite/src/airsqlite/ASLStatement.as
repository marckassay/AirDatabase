package airsqlite
{
	import airsqlite.core.DataManipulator;
	import airsqlite.interfaces.IDataNoun;
	import airsqlite.interfaces.IDataPreposition;
	import airsqlite.statement.DataManipulationVerb;
	import airsqlite.statement.delegates.ASLStatementDelegate;
	import airsqlite.statement.delegates.CreateDelegate;
	import airsqlite.statement.delegates.RemoveDelegate;
	import airsqlite.statement.delegates.SelectDelegate;
	import airsqlite.statement.delegates.UpdateDelegate;
	
	import flash.data.SQLStatement;
	import flash.net.Responder;
	
	
	public class ASLStatement extends SQLStatement implements IDataNoun, IDataPreposition
	{
		private var _manipulator:DataManipulator;
		
		private var _manipulationVerb:DataManipulationVerb;
		
		private var delegate:ASLStatementDelegate;
		
		private var _tableName:String;
		
		private var _responder:Responder;
		
		private var prefetch:int = -1;
				
		
		public function ASLStatement(result:Function=null, status:Function=null)
		{			
			if(result != null)
				_responder = new Responder(result, status);
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
			delegate.constructStatement(this);
			
			return manipulator.processASLStatement(this);
		}
		
		private function addDelegate():void
		{
			switch(manipulationVerb)
			{
				case DataManipulationVerb.SELECT:
					delegate = new SelectDelegate();
					break;
				case DataManipulationVerb.CREATE:
					delegate = new CreateDelegate();
					break;
				case DataManipulationVerb.UPDATE:
					delegate = new UpdateDelegate();
					break;
				case DataManipulationVerb.REMOVE:
					delegate = new RemoveDelegate();
					break;
			}
		}
		
		// IDataNoun implementations
		public function record(reference:*):IDataPreposition
		{
			return delegate.record(reference);
		}
		
		public function field(field:String, condition:*):IDataPreposition
		{
			return delegate.field(field, condition);
		}
		
		// IDataPreposition implementations
		public function from(tableName:String):*
		{			
			delegate.tableName = tableName;
			
			return go();
		}
		
		public function to(tableName:String):*
		{				
			delegate.tableName = tableName;
			
			return go();			
		}
		/*
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
			
			addDelegate();
		}

		
		public function get tableName():String
		{
			return _tableName;
		}
		public function set tableName(value:String):void
		{
			_tableName = value;
			
			delegate.tableName = value;
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