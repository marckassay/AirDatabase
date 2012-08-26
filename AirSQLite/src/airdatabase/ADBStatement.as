package airdatabase
{
	import airdatabase.core.DataManipulator;
	import airdatabase.interfaces.IADBStatement;
	import airdatabase.interfaces.IDataPreposition;
	import airdatabase.statement.DataManipulationVerb;
	import airdatabase.statement.delegates.ADBStatementDelegate;
	import airdatabase.statement.delegates.InsertDelegate;
	import airdatabase.statement.delegates.RemoveDelegate;
	import airdatabase.statement.delegates.SelectDelegate;
	import airdatabase.statement.delegates.UpdateDelegate;
	
	import flash.data.SQLStatement;
	import flash.net.Responder;
	
	
	public class ADBStatement extends SQLStatement implements IADBStatement
	{
		private var _manipulator:DataManipulator;
		
		private var _manipulationVerb:DataManipulationVerb;
		
		private var delegate:ADBStatementDelegate;
		
		private var _tableName:String;
		
		private var _responder:Responder;
		
		private var prefetch:int = -1;
		
		
		public function ADBStatement(result:Function=null, status:Function=null)
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
		 * This method sends this instance of <code>ADBStatement</code> to 
		 * <code>DataManipulator</code>.
		 */
		public function go():*
		{
			delegate.constructStatement(this);
			
			return manipulator.processADBStatement(this);
		}
		
		private function addDelegate():void
		{
			switch(manipulationVerb)
			{
				case DataManipulationVerb.SELECT:
					delegate = new SelectDelegate();
					break;
				case DataManipulationVerb.INSERT:
					delegate = new InsertDelegate();
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
		public function record(reference:*):IADBStatement
		{
			delegate.record(reference);
			
			return this;
		}
		
		public function field(field:String, condition:*):IADBStatement
		{
			delegate.field(field, condition);
			
			return this;
		}
		
		public function where():IADBStatement
		{
			delegate.where();
			
			return this;
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
		
		public function all():IDataPreposition
		{
			delegate.all();
			
			return this;
		}
		/*
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