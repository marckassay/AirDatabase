package airdatabase.statement.delegates
{
	import airdatabase.ADBStatement;
	import airdatabase.errors.messages.FilterErrorMessage;
	import airdatabase.errors.messages.NotImplementedErrorMessage;
	import airdatabase.errors.throwError;
	import airdatabase.filters.Filter;
	import airdatabase.interfaces.IADBStatement;
	import airdatabase.interfaces.IADBStatementDelegate;
	import airdatabase.statement.FieldObject;
	
	/**
	 * All Select queries will not be setting/mutating any field.
	 */
	public class SelectDelegate extends ADBStatementDelegate
	{
		override public function record(reference:*):IADBStatement
		{
			throwError( NotImplementedErrorMessage.ERROR );
			
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
			var results:String = "SELECT * "+
				"FROM "+tableName;
			
			if(fields.length > 0)
			{
				var fieldName:String;
				var fieldFilter:Filter;
				
				if(fields[0] != null)
				{
					var whereObject:FieldObject = fields[0];
					fieldName 					= whereObject.field;
					fieldFilter 				= whereObject.condition as Filter;
					
					results += " WHERE "+fieldName+fieldFilter.operator+whereObject.colonField;
					statement.parameters[whereObject.colonField] = fieldFilter.value;
				}
				
				for(var fieldPointer:int = 1; fields[fieldPointer]!=null; fieldPointer++)
				{
					var andObject:FieldObject 	= fields[fieldPointer];
					fieldName 					= andObject.field;
					fieldFilter 				= andObject.condition as Filter;
					
					results += " AND "+fieldName+fieldFilter.operator+andObject.colonField;
					statement.parameters[andObject.colonField] = fieldFilter.value;
				}
			}
			else if(hasAllBeenCalled == false)
			{
				throwError(FilterErrorMessage.INCORRECT_FILTER);
			}
			
			statement.text = results;
		}
	}
}