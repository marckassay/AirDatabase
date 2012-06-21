package airsqlite.statement.delegates
{
	import airsqlite.ASLStatement;
	import airsqlite.errors.NotImplementedError;
	import airsqlite.filters.Filter;
	import airsqlite.interfaces.IASLStatementDelegate;
	import airsqlite.statement.FieldObject;
	
	public class UpdateDelegate extends ASLStatementDelegate
	{
		override public function record(reference:*):IASLStatementDelegate
		{
			//throw NotImplementedError.ERROR;
			
			super.record(reference);
			
			return null;
		}
		
		override public function field(field:String, condition:*):IASLStatementDelegate
		{
			if( (condition as Filter).filter != 'equals')
			{
				//throw NotImplementedError.ERROR;
			}
			
			return super.field(field, condition);
		}
		
		override public function constructStatement(statement:ASLStatement):void
		{
			//if(hasWhereBeenCalled == false)
				// TODO: throw StatementSyntaxError
				
			// if we dont got a pair of fields...
			//if(fields.length == 2)
				// TODO: throw StatementSyntaxError
			
			var results:String				= "UPDATE "+tableName;
			var setData:String				= " SET ";
			var whereData:String			= " WHERE ";
			
			
			var setField:FieldObject		= fields[0];
			var setFieldName:String			= setField.field;
			var setFieldFilter:Filter		= setField.condition as Filter;
			
			var whereField:FieldObject		= fields[1];
			var whereFieldName:String		= whereField.field;
			var whereFieldFilter:Filter		= whereField.condition as Filter;
			
			setData += setFieldName+setFieldFilter.operator+setField.colonField;
			statement.parameters[setField.colonField] = setFieldFilter.value;
			
			whereData += whereFieldName+whereFieldFilter.operator+whereField.colonField;
			statement.parameters[whereField.colonField] = whereFieldFilter.value;
			
			results += setData + whereData;
			
			statement.text = results;
		}
	}
}