package airdatabase.statement
{
	[ExcludeClass]
	public class FieldObject
	{
		private var _field:String;
		private var _condition:*;
		
		public function FieldObject(field:String, condition:*)
		{
			_field 		= field;
			_condition 	= condition;
		}
		
		/**
		 * The value of the first parameter of the <code>field</code> method.
		 * This value represents the column to manipulate.  The <code>condition</code>
		 * field of this class determines what kind of manipulation occurs.
		 */
		public function get field():String
		{
			return _field;
		}
		
		/**
		 * This value wraps and returns a <code>Filter</code> type.  This is a 
		 * method class that resides in the filters package.
		 * 
		 * @see airdatabase.filters.Filter
		 */
		public function get condition():*
		{
			return _condition;
		}
		
		/**
		 * To be used in the sub delegate.  This value is used in the <code>parameter</code>
		 * Object property of a statement.  For instance if the following was called, 
		 * <code>field('first', equals('Dagny'))</code>, this value would be <code>:first</code>.
		 */
		public function get colonField():String
		{
			return ":"+_field;
		}
	}
}