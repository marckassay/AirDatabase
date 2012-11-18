package airdatabase.statement.delegates
{
	import airdatabase.ADBStatement;
	import airdatabase.errors.messages.FilterErrorMessage;
	import airdatabase.errors.throwError;
	import airdatabase.filters.Filter;
	import airdatabase.interfaces.IADBStatement;
	import airdatabase.statement.FieldObject;
	
	[ExcludeClass]
	public class UpdateDelegate extends ADBStatementDelegate
	{
		override public function record(reference:*):IADBStatement
		{
			super.record(reference);
			
			return null;
		}
		
		override public function field(field:String, condition:*):IADBStatement
		{
			if( (condition as Filter).filter != 'equals')
			{
				throwError(FilterErrorMessage.INCORRECT_FILTER, {nameOfFilter: (condition as Filter).filter});
			}
			
			return super.field(field, condition);
		}
		
		override public function constructStatement(statement:ADBStatement):void
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