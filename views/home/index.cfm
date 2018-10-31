<cfoutput>
	<h2>
		WireBox Visualizer	
	</h2>
		
	<!---
		http://visjs.org/network_examples.html
		http://visjs.org/examples/network/basicUsage.html
	--->


  <script type="text/javascript" src="#event.buildLink( 'wireboxvisualizer' )#/asset/vis/vis.min.js"></script>
  <link href="#event.buildLink( 'wireboxvisualizer' )#/asset/vis/vis-network.min.css" rel="stylesheet" type="text/css" />

  <style type="text/css">
    ##mynetwork {
      // width: 600px;
       height: 800px;
      border: 1px solid lightgray;
    }
  </style>



<cfset instanceMapData = controller.getSetting( name='__instanceMapData', defaultValue={} )>

<cfif structCount( instanceMapData ) >
	
	<div id="mynetwork"></div>
	
	<script type="text/javascript">
	  // create an array with nodes
	  var nodes = new vis.DataSet([]);
	
	  // create an array with edges
	  var edges = new vis.DataSet([]);
	  
	   
		
		<!--- Shows all mappings in WireBox even if they don't have dependencies or aren't a depednency 
		 <cfloop collection="#wirebox.getBinder().getMappings()#" item="target">
			nodes.add({id: '#encodeForJavascript( target )#', label: '#encodeForJavascript( target )#',  shape: 'box' } );
		</cfloop>
		--->
		
		<cfloop collection="#instanceMapData#" item="target">
			if( nodes.getIds( { filter: function( node ) { return node.id == '#encodeForJavascript( target )#' } } ).length == 0 ) {
				nodes.add({id: '#encodeForJavascript( target )#', label: '#encodeForJavascript( target )#',  shape: 'box'} );
			}
			
			<cfloop array="#instanceMapData[ target ]#" index="dependency">
				edges.add( {from: '#encodeForJavascript( dependency )#', to: '#encodeForJavascript( target )#', arrows:'to'} );
				if( nodes.getIds( { filter: function( node ) { return node.id == '#encodeForJavascript( dependency )#' } } ).length == 0 ) {
					nodes.add({id: '#encodeForJavascript( dependency )#', label: '#encodeForJavascript( dependency )#',  shape: 'box'} );
				}
			</cfloop>
		</cfloop>
	
	  // create a network
	  var container = document.getElementById('mynetwork');
	  var data = {
	    nodes: nodes,
	    edges: edges
	  };
	  var options = {
	    physics:true
	  };
	  var network = new vis.Network(container, data, options);
	</script>
<cfelse>
	<h2>
		No WireBox Data Found
	</h2>
	Please add the following interceptor declaration to your "config/Coldbox.cfc" file.
	<pre>
		interceptors = [
			{ class: 'modules.wireboxVisualizer.interceptors.InjectWatcher' }
		];
	</pre>
	Reinit your app and then you should start picking up data.
</cfif>
</cfoutput>