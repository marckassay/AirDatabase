package airsqlite.statement.delegates
{
	import airsqlite.ASLStatement;
	import airsqlite.errors.messages.FilterErrorMessage;
	import airsqlite.errors.messages.NotImplementedErrorMessage;
	import airsqlite.errors.throwError;
	import airsqlite.filters.Filter;
	import airsqlite.interfaces.IASLStatement;
	import airsqlite.statement.FieldObject;
	
	public class RemoveDelegate extends ASLStatementDelegate
	{
		override public function record(reference:*):IASLStatement
		{
			throwError( NotImplementedErrorMessage.ERROR );
			
			super.record(reference);
			
			return null;
		}
		
		override public function field(field:String, condition:*):IASLStatement
		{
			if( (condition as Filter).filter != 'equals')
			{
				throwError(FilterErrorMessage.INCORRECT_FILTER, {nameOfFilter: (condition as Filter).filter});
			}
			
			return super.field(field, condition);
		}
		
		override public function constructStatement(statement:ASLStatement):void
		{
			var results:String;
			
			if(fields.length > 0)
			{
				results = "DELETE FROM "+tableName;
				
				var fieldName:String;
				var fieldFilter:Filter;
				
				if(fields[0] != null)
				{
					var whereObject:FieldObject = fields[0];
					fieldName 					= whereObject.field;
					fieldFilter 				= whereObject.condition as Filter;
					
					results += " WHERE "+fieldName+fieldFilter.operator+whereObject.colonField;
					statement.parameters[whereObject.colonField] = fieldFilter.value
				}
				
				for(var fieldPointer:int = 1; fields[fieldPointer]!=null; fieldPointer++)
				{
					var andObject:FieldObject 	= fields[fieldPointer];
					fieldName 					= andObject.field;
					fieldFilter 				= andObject.condition as Filter;
					
					results += " AND "+fieldName+fieldFilter.operator+andObject.colonField;
					statement.parameters[andObject.colonField] = fieldFilter.value;
				}
				
				statement.text = results;
			}
			else if(hasAllBeenCalled == true)
			{
				results = "DELETE * FROM "+tableName;
			}
			
			statement.text = results;
		}
	}
}