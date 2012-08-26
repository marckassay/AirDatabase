package airdatabase.utils
{	
	import flash.events.IEventDispatcher;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;

	[ExcludeClass]
	public class EventListenerUtility
	{		
		/**
		 * To be used internally by ASQLite.
		 */
		public static function startListeningForOpen(dispatcher:IEventDispatcher, resultHandler:Function, faultHandler:Function):void
		{
			dispatcher.addEventListener(SQLEvent.OPEN,						resultHandler);
			dispatcher.addEventListener(SQLErrorEvent.ERROR, 				faultHandler);
		}
		public static function stopListeningForOpen(dispatcher:Object, resultHandler:Function, faultHandler:Function):void
		{
			var idispatcher:IEventDispatcher = dispatcher as IEventDispatcher;

			idispatcher.removeEventListener(SQLEvent.OPEN, 					resultHandler);
			idispatcher.removeEventListener(SQLErrorEvent.ERROR, 			faultHandler);		
		}
		
		/**
		 * To be used internally by ASQLite.
		 */
		public static function startListeningForReencrypt(dispatcher:IEventDispatcher, resultHandler:Function, faultHandler:Function):void
		{
			dispatcher.addEventListener(SQLEvent.REENCRYPT,					resultHandler);
			dispatcher.addEventListener(SQLErrorEvent.ERROR, 				faultHandler);
		}
		public static function stopListeningForReencrypt(dispatcher:Object, resultHandler:Function, faultHandler:Function):void
		{
			var idispatcher:IEventDispatcher = dispatcher as IEventDispatcher;

			idispatcher.removeEventListener(SQLEvent.REENCRYPT, 			resultHandler);
			idispatcher.removeEventListener(SQLErrorEvent.ERROR, 			faultHandler);		
		}
		
		/**
		 * To be used internally by ASQLite.
		 */
		public static function startListeningForResult(dispatcher:IEventDispatcher, resultHandler:Function, faultHandler:Function):void
		{
			dispatcher.addEventListener(SQLEvent.RESULT,					resultHandler);
			dispatcher.addEventListener(SQLErrorEvent.ERROR, 				faultHandler);
		}
		public static function stopListeningForResult(dispatcher:Object, resultHandler:Function, faultHandler:Function):void
		{
			var idispatcher:IEventDispatcher = dispatcher as IEventDispatcher;

			idispatcher.removeEventListener(SQLEvent.RESULT, 				resultHandler);
			idispatcher.removeEventListener(SQLErrorEvent.ERROR, 			faultHandler);		
		}
	}
}