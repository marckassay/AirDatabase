package airdatabase.core
{
	import airdatabase.ADBConfig;
	import airdatabase.ADBStatement;
	import airdatabase.schema.AbstractTable;
	import airdatabase.schema.DefaultColumn;
	import airdatabase.schema.DefaultTable;
	
	import flash.data.SQLConnection;
	import flash.data.SQLMode;
	import flash.filesystem.File;
	import flash.utils.Dictionary;
	
	use namespace asl_internal;
	
	[ExcludeClass]
	public class DataConnector
	{
		protected var config:ADBConfig;
		
		protected var sql:SQLConnection;
		
		protected var queueManager:TransactionQueueManager;

		protected var sender:DataSender;
		
		private var dataBaseFile:File;
		
		// TODO: use Bitwise operators to determine the status
		private var connecting:Boolean;
		
		protected var connected:Boolean;
				
		private var _tables:Dictionary;
		
		private var tableStatements:Vector.<ADBStatement>;

		protected var currentStatement:ADBStatement;


		public function DataConnector(config:ADBConfig)
		{
			this.config			= config;
			
			sql					= new SQLConnection();
			
			queueManager 		= new TransactionQueueManager(this);
			
			sender 				= DataSender.getInstance();
			
			
			connecting			= false;
			
			connected 			= false;
			
			
			_tables				= new Dictionary();
			
			tableStatements 	= new Vector.<ADBStatement>();
			
			
			createInMemoryFile();
		}
		
		/**
		 * Creates an instance of flash.filesystem.File representing the OS file.  
		 * The sql.open() or sql.openAsync() will create the actually OS file if
		 * it doesnt exist.
		 */ 
		private function createInMemoryFile():void
		{
			dataBaseFile = File.applicationStorageDirectory.resolvePath(config.uri);
		}
		
		/**
		 * Will open <code>sql</code> in synchronous or asynchronous mode depending on the 
		 * value of <code>config.asyncConnection</code>.  Also, if <code>dataBaseFile</code>
		 * doesnt exist, it will create it.  After this method call, the <code>postConnected</code>
		 * method will be called.
		 */
		private function openConnection():void
		{
			connecting = true;
			
			var sqlMode:String;

			// is this a new database file?  
			if(dataBaseFile.exists == true)
			{
				sqlMode = SQLMode.UPDATE;
			}
			// if not create the initial tables...
			else if(dataBaseFile.exists == false)
			{
				sqlMode = SQLMode.CREATE;
			}
			
			// is AirDatabase configured for sync connection...
			if(config.asyncConnection == false)
			{
				// if encryptionKeyChanged is false...
				if(config.encryptionKeyChanged == false)
				{
					sql.open( dataBaseFile, sqlMode, false, 1024, config.encryptionKey);
				}
				// else if it is true, then we need to open the connection with the previous 
				// encryption key and reencrypt it the new key...
				else
				{
					sql.open( dataBaseFile, sqlMode, false, 1024, config.previousEncryptionKey);
					sql.reencrypt(config.encryptionKey);
				}
				
				// unlike in the else-if clause below, just invoke postConnected directly...
				postConnected();
			}
			else if(config.asyncConnection == true)
			{
				sender.startListeningForConnection(sql, postConnected);
				
				sql.openAsync( dataBaseFile, sqlMode, null, false, 1024, config.encryptionKey);
			}
		}
		
		/**
		 * <p>Called after the <code>sql</code> has called its <code>openAsync</code>
		 * or <code>open</code> methods.</p>
		 * 
		 * This method unconditionally will call its <code>checkToCreateTables</code> method.
		 */
		private function postConnected():void
		{
			checkToCreateTables();
		}
		
		// TODO:  This is a CRUD operation; modify its style so that it
		// adheres with DataManipulator style and then move it into DataManipulator.
		/**
		 * <p>This method will iterate thru all of the tables declared in the 
		 * ASQLiteConfig's <code>tables</code> property and will check to see
		 * if each one exisits.  This method will run once direcotly after connecting
		 * to the database file.</p> 
		 * 
		 * <p>If there is no table that exists, then one will
		 * be made.  If there is one that exists, one will not be made, even if 
		 * the columns are different in the exisitng database and the one that has
		 * been declared.</p>
		 */
		private function checkToCreateTables():void
		{			
			var hasDefaultTableBeenCreated:Boolean;
			
			for each(var table:DefaultTable in config.tables)
			{
				if(hasDefaultTableBeenCreated == false)
				{
					hasDefaultTableBeenCreated = true;
					_tables[AbstractTable.DEFAULT_TABLE] = table;
				}
				
				_tables[table.name] = table;
			
				// create table(s) statements...
				var statement:ADBStatement = initializeStatement();
				
				// adding column(s) to table...
				var columns:String = "";
				for each(var column:DefaultColumn in table.columns)
				{
					columns += column.name+" "+column.dataType+",";
					columns += " ";
				}
				
				// remove the last comma; since there are no more columns to be added...
				columns = columns.substr(0, columns.lastIndexOf(","));
				
				// ...the final construct CREATE TABLE sql line...
				statement.text = "CREATE TABLE IF NOT EXISTS "+table.name+" ("+columns+")";
				
				tableStatements.push(statement);
			}
			
			// now add all table statements to be queued...
			for each(var tableStatement:ADBStatement in tableStatements)
			{
				queueManager.addTransactionToBeginningOfQueue(tableStatement);
			}
			
			// finally, initiate processing...
			processNextQueuedTransaction();
		}
		
		/**
		 * Instanitates an <code>ADBStatement</code> instance and assigns the <code>connector</code>
		 * field to this class.
		 * 
		 * @param result a responder function to be called when the statement has been executed successfully.
		 * @param status a responder function to be called when the statement has been failed from execution.
		 */
		protected function initializeStatement(result:Function=null, status:Function=null):ADBStatement
		{
			var statement:ADBStatement = new ADBStatement(result, status);
			statement.sqlConnection = sql;

			return statement;
		}
		
		/**
		 * Will attempt to execute the <code>statement</code> parameter.  If the <code>isConnectorReady</code>
		 * method returns <code>true</code>, then it will immediatly execute the <code>statement</code>.  If it
		 * returns <code>false</code>, then the statement will be added to the queue stack and it may call
		 * <code>openConnection</code> method.
		 */
		protected function processStatement(statement:ADBStatement):*
		{
			if(isConnectorReady() == false)
			{
				queueManager.addTransactionToQueue(statement);
				
				if(connecting == false)
					openConnection();
			}
			else if(isConnectorReady() == true)
			{
				executeStatement(statement);
			}
			
			return instantData(statement);
		}
		
		/**
		 * <code>TransactionQueueManager</code> calls this method.  When <code>sql</code>
		 * is opened in asynchronous mode, the <code>DataSender</code> will call the 
		 * <code>processNextQueuedTransaction</code> method after the <code>statement</code>
		 * parameter has been executed.
		 */
		public function executeStatement(statement:ADBStatement):void
		{
			if(config.asyncConnection == true)
				sender.startListeningForStatement(statement, processNextQueuedTransaction);
			
			currentStatement = statement;
			
			statement.execute();
			
			if(config.asyncConnection == false)
				processNextQueuedTransaction();
		}
		
		public function processNextQueuedTransaction():void
		{
			checkIfCurrentStatementIsATable();
			
			currentStatement = null;
			
			queueManager.processNextQueuedTransaction();
		}
		
		private function instantData(statement:ADBStatement):*
		{
			if(config.asyncConnection == false)
			{
				return statement.getResult();
			}
			else// if(config.asyncConnection == true)
			{
				return statement.responder;
			}
		}
		
		/**
		 * This method will be called after it has processed and executed the
		 * <code>currentStatement</code> to see if its in the <code>tableStatements</code>
		 * array.  When <code>sql</code> is opened in async mode, it will dispatch a
		 * <code>ADBEvent.CONNECTED</code> event.
		 */
		private function checkIfCurrentStatementIsATable():void
		{
			if((currentStatement != null) && (tableStatements.length > 0))
			{
				for each(var statement:ADBStatement in tableStatements)
				{
					if(currentStatement === statement)
					{
						var statementposition:int = tableStatements.indexOf(statement);
						tableStatements.splice(statementposition, 1);
						
						break;
					}
				}
			}
			
			// if we are done adding tables...
			if((connecting == true) && (tableStatements.length == 0))
			{
				// update our connection flags...
				connecting = false;
				connected = true;
				
				// and if we are in async mode, have sender dispatch event...
				if(config.asyncConnection == true)
					sender.dispatchConnectedEvent();
			}
		}
		
		private function isConnectorReady():Boolean
		{
			return ((connected == true) && (currentStatement == null));
		}
		
		public function get tables():Dictionary
		{
			return _tables;
		}
		
		asl_unit_testing function get testDataBaseFile():File
		{
			return dataBaseFile;
		}
		
		asl_unit_testing function get testDataSender():DataSender
		{
			return sender;
		}
		
		asl_unit_testing function get testSQL():SQLConnection
		{
			return sql;
		}
		
		asl_unit_testing function testInitializeStatement():ADBStatement
		{
			return initializeStatement();
		}
		
		asl_unit_testing function testProcessStatement(statement:ADBStatement):*
		{
			return processStatement(statement);
		}
		
		asl_unit_testing function testIsConnectorReady():Boolean
		{
			return isConnectorReady();
		}
	}
}