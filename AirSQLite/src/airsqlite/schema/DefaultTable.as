package airsqlite.schema
{
	import airsqlite.core.CRUDOperator;
	import airsqlite.core.asl_internal;
	import airsqlite.interfaces.ICRUDOperator;

	use namespace asl_internal;
	
	
	public class DefaultTable extends AbstractTable
	{
		private var _operator:CRUDOperator;
		
		/**
		 * Constructor's arguments are closed for MXML component implementation.
		 */
		public function DefaultTable()
		{
		}
		
		override public function select(...params):*
		{
			params.push(this);
			return operator.select(params);
		}
		
		override public function create(...params):*
		{
			params.push(this);
			return operator.create(params);
		}
		
		override public function update(...params):*
		{
			params.push(this);
			return operator.update(params);
		}
		
		override public function del(...params):*
		{
			params.push(this);
			return operator.del(params);
		}
		
		asl_internal function get operator():CRUDOperator
		{
			return _operator;
		}
		asl_internal function set operator(value:CRUDOperator):void
		{
			_operator = value;
		}
	}
}