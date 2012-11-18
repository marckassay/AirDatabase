package airdatabase.statement.delegates
{
	import airdatabase.ADBStatement;
	import airdatabase.errors.messages.FilterErrorMessage;
	import airdatabase.errors.throwError;
	import airdatabase.filters.Filter;
	import airdatabase.interfaces.IADBStatement;
	import airdatabase.statement.FieldObject;
	
	[ExcludeClass]
	public class InsertDelegate extends ADBStatementDelegate
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
			if(fields.length > 0)
			{
				var results:String		= "INSERT INTO "+tableName;
				var columnData:String 	= " (";
				var valueData:String 	= " VALUES (";
				
				var fieldName:String;
				var fieldFilter:Filter;
				
				for(var fieldPointer:int = 0; fields[fieldPointer]!=null; fieldPointer++)
				{
					var field:FieldObject		= fields[fieldPointer];
					fieldName					= field.field;
					fieldFilter					= field.condition as Filter;
					
					columnData	+= fieldName+", ";	
					valueData	+= field.colonField+", ";
					
					statement.parameters[field.colonField] = fieldFilter.value;
				}
				
				// remove the last comma and replace it with a right parenthesis...
				columnData = columnData.replace( /[\, ]+$/, ')');
				valueData = valueData.replace( /[\, ]+$/, ')');
				
				results += columnData;
				results += valueData;
				
				statement.text = results;
			}
		}
	}
}