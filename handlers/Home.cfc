/**
* Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
* www.ortussolutions.com
* ---
*/
component{

	function index( event, rc, prc ){
		event.setView( "home/index" );
	}

	// Safely serve static assets, even from outside the web root
	function asset( event, rc, prc ){
		// Ignore malicious-looking requests
		rc.assetName = replace( event.getCurrentRoutedURL(), 'wireboxvisualizer/asset/', '' );
		rc.assetName = reReplace( rc.assetName, '/$', '' );
		
		if( isNull( rc.assetName ) || rc.assetName contains '../' ) {
			cfHeader( statuscode=404 );
			return 'Gone' ;
		}
		var thispath = expandPath( '/wireboxVisualizer/includes/#rc.assetName#' );
		if( !fileExists( thispath ) ) {
			cfHeader( statuscode=404 );
			return 'Gone' ;
		}
		cfcontent( type='text/plain', file=thispath, reset=true  );
	}

}
