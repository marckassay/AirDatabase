# AirSQLite

A Flex project that gives Flex AIR applications the ability to access their local SQLite databases easily.  With just a few lines of code, it allows applications to create a SQLite database file with table(s) and perform SELECT, INSERT, UPDATE and DELETE operations in a synchronous connection.  So there is no need to listen for events, data is returned instantly!   

Below is code taken from Example_101.mxml file from the examples project, which shows AirSQLite in its simplest use:

	<s:WindowedApplication xmlns:fx="http://ns.adobe.com/mxml/2009" 
						   xmlns:s="library://ns.adobe.com/flex/spark" 
						   xmlns:mx="library://ns.adobe.com/flex/mx" 
						   xmlns:asl="https://github.com/marckassay/airsqlite"
						   applicationComplete="applicationCompleteHandler(event)">
		
		<fx:Declarations>
			<asl:AirSQLite id="sql">
				<asl:config>
					<asl:ASLConfig uri="atlasshrugged.db">
						<asl:tables>
							<asl:DefaultTable id="Characters">
								<asl:columns>
									<asl:DefaultColumn id="key"			dataType="NUMERIC"/>
									<asl:DefaultColumn id="firstName"	dataType="TEXT" />
									<asl:DefaultColumn id="lastName"	dataType="TEXT"/>
								</asl:columns>
							</asl:DefaultTable>
						</asl:tables>
					</asl:ASLConfig>
				</asl:config>
			</asl:AirSQLite>
		</fx:Declarations>
		
		<fx:Script>
			<![CDATA[
				import airsqlite.filters.equals;
				
				import mx.events.FlexEvent;
				
				[Bindable]
				private var characters:ArrayList;
				
				protected function applicationCompleteHandler(event:FlexEvent):void
				{
					// insert a record by setting value to the key, firstName and lastName fields on the Characters table... 
					sql.insert().field('key',		equals(3)).
								 field('firstName',	equals('Dagny')).
								 field('lastName',	equals('Taggart')).to('Characters');
					
					// select record with the key field...
					var results:SQLResult = sql.select().field('key', equals(3)).from('Characters');
					
					// use results.data to create a new Arraylist for DataGrid below...
					characters = new ArrayList(results.data);
				}
			]]>
		</fx:Script>
		
		<s:DataGrid top="20" left="20" right="20" bottom="20" dataProvider="{characters}">
			<s:columns>
				<s:ArrayList>
					<s:GridColumn
						headerText="Key"
						dataField="key" />
					<s:GridColumn
						headerText="First Name"
						dataField="firstName" />
					<s:GridColumn
						headerText="Last Name"
						dataField="lastName" />
				</s:ArrayList>
			</s:columns>
		</s:DataGrid>
		
	</s:WindowedApplication>

This AirSQLite consists of 3 Flex projects:

* AirSQLite
* AirSQLite-examples
* AirSQLite-unit-test

## AirSQLite

Contains the source code for the project.  The output file for this project is a SWC.

## AirSQLite-examples

Will contain examples to assist developers on how to use AirSQLite with their projects.

## AirSQLite-unit-test

The AirSQLite project was and will continue to be developed using unit tests.  AirSQLite-unit-test contains all unit tests for this project.

### Roadmap: Short-term
* Have AirSQLite to be used in Flash projects too.
* Create an Apache Ant build script so that it will output a Flex and Flash SWC file.
* Allow databases to be encrypted.

### Roadmap: Long-term
* Have the project use strong-typed objects for storage.
* Use Hamcrest Matcher "like" methods for transactions, such as: containsString, startsWith and greaterThan. 
 
### Thanks to...
* Drew Bourne for your [Mockolate](https://github.com/drewbourne/mockolate) and [Hamcrest](https://github.com/drewbourne/hamcrest-as3) projects.
* To all Flex engineers who contributed to Flex and FlexUnit.