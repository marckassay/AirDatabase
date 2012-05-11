package airsqlite
{
	import flash.data.SQLStatement;
	import flash.net.Responder;
	
	public class ASLStatement extends SQLStatement
	{
		private var _responder:Responder;
		
		
		public function ASLStatement(result:Function=null, status:Function=null)
		{			
			if(result != null)
				_responder = new Responder(result, status);
		}
		
		override public function execute(prefetch:int=-1, responder:Responder=null):void
		{
			super.execute(-1, this.responder);
		}

		
		public function get responder():Responder
		{
			return _responder;
		}
	}
}