package airdatabase.filters
{
	/**
	 * The class is to be used with the <code>field</code> method. It gives
	 * the SQL manipulation process a conditional or "filter" which is needed 
	 * in some cases or helpful in others.
	 */
	[ExcludeClass]
	public class Filter
	{
		private var _filter:String;
		private var _operator:String;
		private var _value:*;
		
		public function Filter(filter:String, operator:String, value:*)
		{
			_filter		= filter;
			_operator 	= operator;
			_value 		= value;
		}
		
		/**
		 * The name of one of the filters that resides in the <code>filter</code>
		 * package.
		 */
		public function get filter():String
		{
			return _filter;
		}
		
		/**
		 * The string value of the operator.  For instance, if <code>filter</code>
		 * has a value of 'equals' this value will be ' = '.  The space before and after
		 * are used to prevent the sub delegates needing to add them.
		 */
		public function get operator():String
		{
			return _operator;
		}
		
		/**
		 * The value that was a parameter when it invoked a method class.  For 
		 * instance if the following was called, <code>equals('Dagny')</code>, 
		 * this value would be 'Dagny'.
		 */
		public function get value():*
		{
			return _value;
		}
	}
}