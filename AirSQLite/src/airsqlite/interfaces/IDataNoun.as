package airsqlite.interfaces
{
	public interface IDataNoun
	{
		/**
		 * To be used to reference records by passing value to the <code>reference</code>
		 * param.  The expected value may be an Object or a primary key.  If its an object,
		 * then the object must be registered using, for instance, RemoteObject metatag.  If 
		 * <code>reference</code> is a key, then it must return <code>true</code> when passed 
		 * in the <code>UIDUtil.isUID()</code> static method.
		 * 
		 * @see mx.utils.UIDUtil.isUID()  
		 */
		function record(reference:*):IASLStatementDelegate
		
		/**
		 * To be used to retrieve records with columns, via <code>field</code> param 
		 * under conditions given to the <code>condition</code> param.  This method may be
		 * used in series with another field method call.
		 * 
		 * @param field the name of the column
		 * @param condition may be a String or Number value that will filter the results.
 		 * @example
	 	 * <code>
		 * 	asl.select().field('first', 'Dagny').field('password', 'Abc123').from('Characters');
		 * 	asl.select().field('username', startsWith('Da')).from('Characters');
	 	 * </code>
		 */
		function field(field:String, condition:*):IASLStatementDelegate
	}
}