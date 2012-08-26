# AirDatabase

A Flex project that gives Flex AIR applications the ability to access their local SQLite databases easily.  With just a few lines of code, it allows applications to create a SQLite database file with table(s) and perform SELECT, INSERT, UPDATE and DELETE operations in a synchronous connection.  So there is no need to listen for events, data is returned instantly!   

Below is code taken from Example_101.mxml file from the examples project, which shows AirDatabase in its simplest use:

	<s:WindowedApplication xmlns:fx="http://ns.adobe.com/mxml/2009" 
						   xmlns:s="library://ns.adobe.com/flex/spark" 
						   xmlns:mx="library://ns.adobe.com/flex/mx" 
						   xmlns:adb="https://github.com/marckassay/airdatabase"
						   applicationComplete="applicationCompleteHandler(event)">
		
		<fx:Declarations>
			<adb:AirDatabase id="sql">
				<adb:config>
					<adb:ADBConfig uri="atlasshrugged.db">
						<adb:tables>
							<adb:DefaultTable id="Characters">
								<adb:columns>
									<adb:DefaultColumn id="key"			dataType="NUMERIC"/>
									<adb:DefaultColumn id="firstName"	dataType="TEXT" />
									<adb:DefaultColumn id="lastName"	dataType="TEXT"/>
								</adb:columns>
							</adb:DefaultTable>
						</adb:tables>
					</adb:ADBConfig>
				</adb:config>
			</adb:AirDatabase>
		</fx:Declarations>
		
		<fx:Script>
			<![CDATA[
				import airdatabase.filters.equals;
				
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
		
		<s:DataGrid top="20" left="20" right="20" bottom="20" dataProvider="{characters}" >
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

This AirDatabase consists of 3 Flex projects:

* AirDatabase
* AirDatabase-examples
* AirDatabase-unit-test

## AirDatabase

Contains the source code for the project.  The output file for this project is a SWC.

## AirDatabase-examples

Will contain examples to assist developers on how to use AirDatabase with their projects.

## AirDatabase-unit-test

The AirDatabase project was and will continue to be developed using unit tests.  AirDatabase-unit-test contains all unit tests for this project.

### Roadmap: Short-term
* Have AirDatabase to be used in Flash projects too.
* Create an Apache Ant build script so that it will output a Flex and Flash SWC file.
* Allow databases to be encrypted.

### Roadmap: Long-term
* Have the project use strong-typed objects for storage.
* Use Hamcrest Matcher "like" methods for transactions, such as: containsString, startsWith and greaterThan. 
 
### Thanks to...
* Drew Bourne for your [Mockolate](https://github.com/drewbourne/mockolate) and [Hamcrest](https://github.com/drewbourne/hamcrest-as3) projects.
* To all Flex engineers who contributed to Flex and FlexUnit.