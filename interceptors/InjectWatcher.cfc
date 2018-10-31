/**
* Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
* www.ortussolutions.com
* ---
*/
component{

	/**
	* Every time WireBox finishes autowiring a CFC, makea note of everything that was injected into it
	* The mapping object contains the list of DI properties and setters that were processed.
	*/
	function afterInstanceAutowire() {
			// DIProperty injection
			processInjection( interceptData.mapping.getDIProperties(), interceptData.targetID );
			// DISetter injection
			processInjection( interceptData.mapping.getDISetters(), interceptData.targetID );
	}
	
	
	private function processInjection( required DIData, required targetID ){
		
		// Init a controller-level setting to hold the data.  This will persist across requests but will clear on fwreinit
		if( !controller.settingExists( '__instanceMapData' ) ) {
			controller.setSetting( '__instanceMapData', {} );
		}
		
		// Since setting is a struct, we are modifying it reference.
		var instanceMapData = controller.getSetting( '__instanceMapData' );
		
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
			instanceMapData[ arguments.targetID ] = instanceMapData[ arguments.targetID ] ?: [];
			if( !instanceMapData[ arguments.targetID ].contains( thisInstanceName ) ) {
				instanceMapData[ arguments.targetID ].append( thisInstanceName );	
			}
			
			//systemoutput( "Dependency: #thisInstanceName# --> injected into #arguments.targetID#", 1 );

		} // end iteration

	}
		
}

