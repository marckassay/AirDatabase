# AirDatabase

AirDatabase is a Flex project that gives Flex AIR applications the ability to access its local SQLite database with ease.  With a small amount of code to configure AirDatabase, it allows you to create a SQLite database file with tables which you can then start to perform CRUD operations synchronously. 

Below is code taken from Example_101.mxml file from the AirDatabase-examples project.  This snippet of code instantiates AirDatabase with one table and three columns:

	<fx:Declarations>
		<adb:AirDatabase id="airdb">
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

And this snippet references the AirDatabase instance from above and then performs an insert operation followed by a select operation:
 
	<fx:Script>
		<![CDATA[
			import airdatabase.filters.equals;
			import mx.events.FlexEvent;
			
			[Bindable]
			private var characters:ArrayList;
			
			protected function applicationCompleteHandler(event:FlexEvent):void
			{
				// insert a record by setting value to the key, firstName and lastName fields on the Characters table... 
				airdb.insert().field('key',			equals(3)).
							   field('firstName',	equals('Dagny')).
							   field('lastName',	equals('Taggart')).to('Characters');
				
				// select record with the key field...
				var results:SQLResult = airdb.select().field('key', equals(3)).from('Characters');
				
				trace(results.data[0].firstName); //output: Dagny
				
				// use results.data to create a new Arraylist for perhaps a DataGrid...
				characters = new ArrayList(results.data);
			}
		]]>
	</fx:Script>

This AirDatabase consists of 3 Flex projects:

* AirDatabase
* AirDatabase-examples
* AirDatabase-unit-test

## AirDatabase

Contains the source code for the project.  The output file for this project is a SWC.

## AirDatabase-examples

Will contain examples to assist developers on how to use AirDatabase with their projects.

## AirDatabase-unit-test

The AirDatabase project was and will continue to be developed with unit tests.  AirDatabase-unit-test contains all unit tests for this project.

### Roadmap: Short-term
* ~~Allow databases to be encrypted.~~

### Roadmap: Long-term
* Have the project use strong-typed objects for storage.
* Use Hamcrest Matcher "like" methods for transactions, such as: containsString, startsWith and greaterThan. 
 
### Thanks to...
* Drew Bourne for your [Mockolate](https://github.com/drewbourne/mockolate) and [Hamcrest](https://github.com/drewbourne/hamcrest-as3) projects.
* To all Flex engineers who contributed to Flex and FlexUnit.