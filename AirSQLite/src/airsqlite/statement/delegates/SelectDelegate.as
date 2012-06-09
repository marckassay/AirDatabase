package airsqlite.statement.delegates
{
	import airsqlite.ASLStatement;
	import airsqlite.errors.NotImplementedError;
	import airsqlite.filters.Filter;
	import airsqlite.interfaces.IASLStatementDelegate;
	import airsqlite.statement.FieldObject;
	
	/**
	 * All Select queries will not be setting/mutating any field.
	 */
	public class SelectDelegate extends ASLStatementDelegate
	{
		override public function record(reference:*):IASLStatementDelegate
		{
			throw NotImplementedError.ERROR;
			
			super.record(reference);
		}
		
		override public function field(field:String, condition:*):IASLStatementDelegate
		{
			if( (condition as Filter).filter != 'equals')
			{
				throw NotImplementedError.ERROR;
			}
			
			return super.field(field, condition);
		}
		
		override public function constructStatement(statement:ASLStatement):void
		{
			if(fields.length > 0)
			{
				var results:String = "SELECT * "+
									 "FROM "+tableName;
				
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
		}
	}
}