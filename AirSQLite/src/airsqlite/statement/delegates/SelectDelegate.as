package airsqlite.statement.delegates
{
	import airsqlite.ASLStatement;
	import airsqlite.filters.Filter;
	import airsqlite.interfaces.IDataPreposition;
	import airsqlite.statement.FieldObject;
	
	/**
	 * All Select queries will not be setting/mutating any field.
	 */
	public class SelectDelegate extends ASLStatementDelegate
	{
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
					
					results += " WHERE "+fieldName+fieldFilter.operator+fieldFilter.colonValue;
					statement.parameters[fieldFilter.colonValue] = fieldFilter.value
				}
				
				if(fields[1] != null)
				{
					var andObject:FieldObject 	= fields[1];
					fieldName 					= andObject.field;
					fieldFilter 				= andObject.condition as Filter;
					
					results += " AND "+fieldName+fieldFilter.operator+fieldFilter.colonValue;
					statement.parameters[fieldFilter.colonValue] = fieldFilter.value;
				} 
				
				statement.text = results;
			}
		}
	}
}