/**
* Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
* www.ortussolutions.com
* ---
*/
component{
	property name='wirebox' inject='wirebox';

	/**
	* Every time WireBox finishes autowiring a CFC, makea note of everything that was injected into it
	* The mapping object contains the list of DI properties and setters that were processed.
	*/
	function buildInstanceMap() {
		
		var instanceMap = {};
		
		wirebox.getBinder().getMappings().each( function( mappingID, mapping ){
			if( mappingID contains 'wirebox-visualizer' || mappingID.endsWith( '@coldbox' ) ) {
				return;
			}
			// DIProperty injection
			processInjection( mapping.getDIProperties(), mappingID, instanceMap );
			// DISetter injection
			processInjection( mapping.getDISetters(), mappingID, instanceMap );
		} );
		
		return instanceMap;
		
	}
	
	
	private function processInjection( required DIData, required targetID, required struct instanceMap ){
		
		for( var x=1; x lte arrayLen( arguments.DIData ); x++ ){
			var thisDIData = arguments.DIData[ x ];
			var thisInstanceName = 'Unknown';
			
			// Determine a human readable name for this instance based on the mapping definition
			if( !isNull( thisDIData.value ) ) {
				// thisDIData.argName
				thisInstanceName = 'Value: #thisDIData.name#';
			} else if( !isNull( thisDIData.dsl ) ) {
				// Clean off id: or model: from start of DSL
				thisInstanceName = reReplaceNoCase( thisDIData.dsl, '^(id:|model:)', ''  );
			} else if( !isNull( thisDIData.ref ) ) {
				thisInstanceName = thisDIData.ref;
			}
			
			//targetID = targetID.listLast( '.' );
			// Add information about this injection to our global setting
			instanceMap[ arguments.targetID ] = instanceMap[ arguments.targetID ] ?: [];
			if( !arrayContains( instanceMap[ arguments.targetID ], thisInstanceName ) ) {
				instanceMap[ arguments.targetID ].append( thisInstanceName );	
			}
			
			//systemoutput( "Dependency: #thisInstanceName# --> injected into #arguments.targetID#", 1 );

		} // end iteration

	}
		
}

