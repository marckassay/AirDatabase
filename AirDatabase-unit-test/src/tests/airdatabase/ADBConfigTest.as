package tests.airdatabase
{
	import airdatabase.ADBConfig;
	import airdatabase.core.asl_unit_testing;
	
	import flash.utils.ByteArray;
	
	import mx.utils.UIDUtil;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertTrue;

	use namespace asl_unit_testing;
	
	public class ADBConfigTest
	{
		private var fixture:ADBConfig;
		
		[Before]
		public function runBeforeEveryTest():void 
		{
			fixture = new ADBConfig();
		} 
		
		[After]
		public function runAfterEveryTest():void 
		{
			fixture = null;
		}
		
		[Test]
		public function testAutoGeneratePasswordIs16Bytes():void
		{
			var results:ByteArray = fixture.getByteArrayKey();
			
			assertEquals(16, results.length);
		}
		
		[Test]
		public function testSelfUIDIs16Bytes():void
		{
			var results:ByteArray = fixture.getByteArrayKey(UIDUtil.createUID());
			
			assertEquals(16, results.length);
		}
		
		[Test]
		public function testThatEncryptionKeyChangeIsTrue():void
		{
			// clear out any exisitng key, if there is one...
			fixture.enableEncryption = true;
			fixture.encryptionKey = null;
			
			// set the first key...
			fixture.encryptionKey = UIDUtil.createUID();
			
			// set the second key...
			fixture.encryptionKey = UIDUtil.createUID();
			
			assertTrue(fixture.getEncryptionKeyChangedField());
		}
		
		[Test]
		public function testThatEncryptionKeyChangeIsFalse():void
		{
			// clear out any exisitng key, if there is one...
			fixture.enableEncryption = true;
			fixture.encryptionKey = null;
			
			assertFalse(fixture.getEncryptionKeyChangedField());
		}
	}
}