package airsqlite.statement.delegates
{
	import airsqlite.ASLStatement;
	import airsqlite.errors.FilterError;
	import airsqlite.errors.NotImplementedError;
	import airsqlite.filters.Filter;
	import airsqlite.interfaces.IASLStatementDelegate;
	import airsqlite.statement.FieldObject;
	
	public class UpdateDelegate extends ASLStatementDelegate
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
			if(hasWhereBeenCalled == false)
				// TODO: throw StatementSyntaxError
			
			if(fields.length > 0)
			{
				var results:String		= "UPDATE "+tableName;
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
					valueData	+= "'"+(fieldFilter.value as String)+"',";
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