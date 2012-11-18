package airdatabase
{
	import airdatabase.core.asl_unit_testing;
	import airdatabase.els.EncryptedLocalStorage;
	import airdatabase.errors.messages.IncorrectTypeErrorMessage;
	import airdatabase.errors.messages.IncorrectValueErrorMessage;
	import airdatabase.errors.messages.NotImplementedErrorMessage;
	import airdatabase.errors.throwError;
	import airdatabase.interfaces.IDataVerb;
	
	import flash.utils.ByteArray;
	
	import mx.utils.UIDUtil;
	
	use namespace asl_unit_testing;
	
	public class ADBConfig 
	{
		private var _uri:String;
		
		private var _encryptionKey:*;
		
		private var _previousEncryptionKey:ByteArray;
		
		private var _enableEncryption:Boolean;
		
		private var _asyncConnection:Boolean;
		
		private var _encryptionKeyChanged:Boolean;
		
		private var _tables:Vector.<IDataVerb>;
		
		/**
		 * Constructor's arguments are closed for MXML component implementation.
		 */
		public function ADBConfig()
		{
			_asyncConnection = false;
			
			_encryptionKeyChanged = false;
		}
		
		protected function getByteArrayKey(value:String=null):ByteArray
		{
			var key:ByteArray;
			
			if(value == null)
			{
				key = UIDUtil.toByteArray(UIDUtil.createUID());
			}
			else
			{
				// this is redundant check...
				if(UIDUtil.isUID(value) == true)
				{
					key = UIDUtil.toByteArray(value);
				}
			}
			
			return key;
		}
		
		public function get uri():String
		{
			return _uri;
		}
		public function set uri(value:String):void
		{
			_uri = value;
		}
		
		
		public function get tables():Vector.<IDataVerb>
		{
			return _tables;
		}
		public function set tables(value:Vector.<IDataVerb>):void
		{
			_tables = value;
		}
		
		
		public function get encryptionKeyChanged():Boolean
		{
			return _encryptionKeyChanged;
		}
		
		
		public function get previousEncryptionKey():ByteArray
		{
			return _previousEncryptionKey;
		}
		
		
		[Inspectable(category="General", enumeration="false, true", defaultValue="false")]
		public function get asyncConnection():Boolean
		{
			return _asyncConnection;
		}
		public function set asyncConnection(value:Boolean):void
		{
			if(value == true)
				throwError( NotImplementedErrorMessage.ERROR, {feature: 'asyncConnection.  AirDataBase can only be connected in synchronous mode.'} );

			_asyncConnection = value;
		}
		
		/**
		 * When a value is set, <code>enableEncryption</code> is set to <code>true</code>.  Possible
		 * data types: String or ByteArray.  If the value is a String, a ByteArray will be created with
		 * it.  If the value is a ByteArray, then that value will be used directly to encrypt the database.
		 */
		// TODO: move the logic that is in the setter, to EncryptedLocalStorage and update test-cases.
		public function get encryptionKey():*
		{
			_encryptionKey = EncryptedLocalStorage.getEncryptionKey();
			return _encryptionKey;
		}
		public function set encryptionKey(value:*):void
		{
			var previousKey:ByteArray = encryptionKey as ByteArray;
			
			if(value is String)
			{
				// it must be a UID String...
				if(UIDUtil.isUID(value) == false)
				{
					throwError(IncorrectValueErrorMessage.INCORRECT_VALUE, {type: 'String', condition: 'The value must be a UID String.  ' +
																									'See mx.utils.UIDUtil for creating a UID.'});
				}
				
				_encryptionKey = getByteArrayKey(value);
				EncryptedLocalStorage.setEncryptionKey(_encryptionKey);
				
				enableEncryption = true;
			}
			else if(value is ByteArray)
			{
				// it must be 16 bytes...
				if((value as ByteArray).length != 16)
					throwError(IncorrectValueErrorMessage.INCORRECT_VALUE, {type: 'ByteArray', condition: 'The length must be 16 in bytes.'});
					
				_encryptionKey = value;
				EncryptedLocalStorage.setEncryptionKey(_encryptionKey);
				
				enableEncryption = true;
			}
			else if((value == null) && (enableEncryption == true))
			{
				_encryptionKey = null;
				EncryptedLocalStorage.setEncryptionKey(null);
				
				enableEncryption = false;
			}
			else
			{
				throwError(IncorrectTypeErrorMessage.INCORRECT_TYPE, {possibleTypes: 'String and ByteArray'});
			}
			
			checkForEncryptionKeyChange(previousKey);
		}
		
		/**
		 * This method checks to see if <code>DataConnector</code> needs to be reencrypted.  If <code>previousKey</code> is 
		 * null, then this method will set <code>encryptionKeyChanged</code> to <code>false</code>.
		 */
		private function checkForEncryptionKeyChange(previousKey:ByteArray):void
		{
			var currentKey:ByteArray = encryptionKey as ByteArray;
			if((previousKey != null) && (currentKey == null))
			{
				// throw error...this may be that the developer is attempting to unencrypt a 
				// encrypted database.  this is not allowed by AIR.
				_encryptionKeyChanged = false;
			}
			else if((previousKey == null) && (currentKey == null))
			{
				_encryptionKeyChanged = false;
			}
			else if((previousKey != null) && (previousKey != currentKey))
			{
				_previousEncryptionKey = previousKey;
				
				_encryptionKeyChanged = true;
			}
			else
			{
				_encryptionKeyChanged = false;
			}
		}
		
		/**
		 * If set to <code>true</code>, an autogenerated key will be created.  Once the key is created, it will be stored
		 * in the user's ELS (Encrypted Local Storage) directory of their computer.  This property will also 
		 * become <code>true</code> if a value is passed into <code>encryptionKey</code> property.
		 * 
		 * @see encryptionKey
		 */
		[Inspectable(category="General", defaultValue="false")]
		public function get enableEncryption():Boolean
		{
			return _enableEncryption;
		}
		public function set enableEncryption(value:Boolean):void
		{
			_enableEncryption = value;
			
			if((value == true) && (encryptionKey == null))
			{
				encryptionKey = getByteArrayKey();
			}
			else if((value == false) && (encryptionKey != null))
			{
				encryptionKey = null;
			}
		}
		
		asl_unit_testing function getByteArrayKey(value:String=null):ByteArray
		{
			return getByteArrayKey(value);
		}
		
		asl_unit_testing function getEncryptionKeyChangedField():Boolean
		{
			return _encryptionKeyChanged;
		}
	}
}