/**
* Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
* www.ortussolutions.com
* ---
*/
component {

	// Module Properties
	this.title 				= "WireBox Visualizer";
	this.author 			= "Ortus Solutions";
	this.webURL 			= "https://www.ortussolutions.com";
	// Model Namespace
	this.modelNamespace		= "wireBoxVisualizer";
	this.autoMapModels		= true;
	// CF Mapping
	this.cfmapping			= "wireBoxVisualizer";
	this.entryPoint			= "wireBoxVisualizer";
	// Dependencies
	this.dependencies 		= [];

	/**
	* Configure Module
	*/
	function configure(){
		settings = {

		};
		
		// SES Routes
		routes = [
			// Module Entry Point
			{ pattern="/", handler="home", action="index" },
			{ pattern="/asset/:assetName", handler="home", action="asset" },
			// Convention Route
			{ pattern="/:handler/:action?" }
		];
	}

	/**
	* Fired when the module is registered and activated.
	*/
	function onLoad(){

	}

	/**
	* Fired when the module is unregistered and unloaded
	*/
	function onUnload(){

	}

}
