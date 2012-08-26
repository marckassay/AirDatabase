package airdatabase.core
{
	import airdatabase.ADBEvent;
	import airdatabase.utils.EventListenerUtility;
	
	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.utils.Dictionary;
	import airdatabase.ADBStatement;
	
	/**
	 * This class is a Singleton that is implementing the Bill Pugh pattern.
	 * 
	 * @see http://en.wikipedia.org/wiki/Singleton_pattern#The_solution_of_Bill_Pugh
	 */
	[ExcludeClass]
	final public class DataSender extends EventDispatcher
	{
		private var events:Dictionary = new Dictionary();
		
		public static function getInstance():DataSender 
		{
			return DataSenderHolder.instance;
		}
		
		public function startListeningForStatement(statement:ADBStatement, result:Function, fault:Function=null):void
		{
			EventListenerUtility.startListeningForResult(statement, onStatementHandler, onStatementErrorHandler);
			
			addDispatcherToDictionary(statement, result, fault);
		}
		
		public function startListeningForConnection(sql:SQLConnection, result:Function, fault:Function=null):void
		{
			EventListenerUtility.startListeningForOpen(sql, onSQLOpenHandler, onSQLOpenErrorHandler);
			
			addDispatcherToDictionary(sql, result, fault);
		}
		
		private function addDispatcherToDictionary(dispatcher:IEventDispatcher, result:Function, fault:Function):void
		{
			var responder:DataResponder = new DataResponder(result, fault);
			events[dispatcher] = responder;
		}
		
		private function deleteDispatcherFromDictionary(dispatcher:IEventDispatcher):void
		{
			delete events[dispatcher];
		}
		
		private function sendResponder(dispatcher:IEventDispatcher, fault:Boolean=false):void
		{
			if(fault == false)
			{
				(events[dispatcher] as DataResponder).result.call();
			}
			else if(fault == true)
			{
				(events[dispatcher] as DataResponder).fault.call();
			}
			
			deleteDispatcherFromDictionary(dispatcher);			
		}

		////////////////////////////////////////////
		// Eventhandlers
		////////////////////////////////////////////
		
		private function onSQLOpenHandler(event:SQLEvent):void
		{
			var connection:SQLConnection = event.target as SQLConnection;
			
			EventListenerUtility.stopListeningForOpen(event.target, onSQLOpenHandler, onSQLOpenErrorHandler);

			var clientevent:ADBEvent = new ADBEvent(ADBEvent.CONNECTED);

			sendResponder(connection);
			dispatchEvent(clientevent);
		}
		
		private function onSQLOpenErrorHandler(event:SQLErrorEvent):void
		{
			var statement:SQLStatement = event.target as SQLStatement;
			
			EventListenerUtility.stopListeningForOpen(event.target, onSQLOpenHandler, onSQLOpenErrorHandler);
			
			var clientevent:ADBEvent = new ADBEvent(ADBEvent.RESULT, null);
			
			sendResponder(statement);
			dispatchEvent(clientevent);
		}
		
		private function onStatementHandler(event:SQLEvent):void 
		{
			var statement:SQLStatement = event.target as SQLStatement;
			
			EventListenerUtility.stopListeningForResult(statement, onStatementHandler, onStatementErrorHandler);

			var clientevent:ADBEvent;
			var result:SQLResult = statement.getResult();
			
			if(result && result.data)
			{
				try
				{
					clientevent = new ADBEvent(ADBEvent.RESULT, result.data);
				}
				catch(error:Error)
				{
					clientevent = new ADBEvent(ADBEvent.RESULT, null);
				}
			}
			else
			{
				clientevent = new ADBEvent(ADBEvent.RESULT, null);
			}
			
			sendResponder(statement);
			dispatchEvent(clientevent);
		} 
		
		private function onStatementErrorHandler(event:SQLErrorEvent):void
		{
			var statement:SQLStatement = event.target as SQLStatement;

			EventListenerUtility.stopListeningForResult(statement, onStatementHandler, onStatementErrorHandler);
			
			var clientevent:ADBEvent = new ADBEvent(ADBEvent.RESULT, null);

			sendResponder(statement);
			dispatchEvent(clientevent);
		}
		
		public function dispatchConnectedEvent():void
		{
			this.dispatchEvent( new ADBEvent(ADBEvent.CONNECTED) );
		}
	}
}

import airdatabase.core.DataSender;

class DataSenderHolder
{
	public static var instance:DataSender = new DataSender();
}

class DataResponder
{
	private var _result:Function;
	private var _fault:Function;
	
	
	public function DataResponder(result:Function, fault:Function)
	{
		this._result = result;
		this._fault = fault;
	}
	
	public function get result():Function
	{
		return _result;
	}
	
	public function get fault():Function
	{
		return _fault;
	}
}