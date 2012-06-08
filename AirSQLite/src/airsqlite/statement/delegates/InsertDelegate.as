package airsqlite.statement.delegates
{
	import airsqlite.ASLStatement;
	import airsqlite.filters.Filter;
	import airsqlite.statement.FieldObject;

	public class InsertDelegate extends ASLStatementDelegate
	{
		override public function constructStatement(statement:ASLStatement):void
		{
			if(fields.length > 0)
			{
				var results:String = "INSERT INTO "+tableName+" Values (";
				
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
				
				for(var fieldPointer:int = 1; fields[fieldPointer]!=null; fieldPointer++)
				{
					var andObject:FieldObject 	= fields[fieldPointer];
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