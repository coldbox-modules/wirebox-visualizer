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


<form method="get" action="#event.buildLink( 'wireboxvisualizer' )#">
	<input type="text" name="filter" value="#rc.filter#">
	<input type="submit" value="Filter">
</form>
<div id="mynetwork"></div>

<script type="text/javascript">
  // create an array with nodes
  var nodes = new vis.DataSet([]);

  // create an array with edges
  var edges = new vis.DataSet([]);
  
	
	<cfloop collection="#prc.instanceMap#" item="target">
		<cfif findNoCase("#rc.filter#", target) || !len(rc.filter) >
			<cfscript>
			var targetGroup = listLast(target, '@')
			if(!len(targetGroup)){
				targetGroup = 'NA'
			}
			</cfscript>
			if( nodes.getIds( { filter: function( node ) { return node.id == '#encodeForJavascript( target )#' } } ).length == 0 ) {
				nodes.add({id: '#encodeForJavascript( target )#', label: '#encodeForJavascript( target )#',  shape: 'box', group: '#targetGroup#'} );
			}
			
			
			<cfloop array="#prc.instanceMap[ target ]#" index="dependency">
				<cfscript>
				var dependencyGroup = listLast(dependency, '@')
				if(!len(dependencyGroup)){
					dependencyGroup = 'NA'
				}
				if( listLen(dependencyGroup, ':') ){
					dependencyGroup = listFirst(dependencyGroup, ':');
				}
				</cfscript>
				edges.add( {from: '#encodeForJavascript( dependency )#', to: '#encodeForJavascript( target )#', arrows:'to'} );
				if( nodes.getIds( { filter: function( node ) { return node.id == '#encodeForJavascript( dependency )#' } } ).length == 0 ) {
					nodes.add({id: '#encodeForJavascript( dependency )#', label: '#encodeForJavascript( dependency )#',  shape: 'box', group: '#dependencyGroup#'} );
				}
			</cfloop>
		</cfif>
	</cfloop>

  // create a network
  var container = document.getElementById('mynetwork');
  var data = {
    nodes: nodes,
    edges: edges
  };
  var options = {
  	// configure: true,
  	groups: {
  		coldbox: {
  			color: {
  				background: 'blue',
  				border: 'red'
  			},
  			shape: 'image',
  			size: 50,
  			image: '#event.buildLink( 'wireboxvisualizer' )#/asset/coldbox-185-logo.png'
  		},
  		cb: {
  			color: {
  				background: 'green'
  			},
  			shape: 'image',
  			size: 50,
  			image: '#event.buildLink( 'wireboxvisualizer' )#/asset/contentbox-185-logo.png'
  		},
  		logbox: {
  			color: {
  				background: 'green'
  			},
  			shape: 'image',
  			size: 50,
  			image: '#event.buildLink( 'wireboxvisualizer' )#/asset/logbox-185.png'
  		},
  		wirebox: {
  			color: {
  				background: 'green'
  			},
  			shape: 'image',
  			size: 50,
  			image: '#event.buildLink( 'wireboxvisualizer' )#/asset/wirebox-185.png'
  		}
  	},
  	nodes: {
  		borderWidth: 2,
  		borderWidthSelected: 1,
  		color: {
  			highlight: {},
  			hover: {}
  		},
  		font: {
  			size: 32,
  			strokeWidth: 1
  		},
  		scaling: {
  			min: 1,
  			max: 126
  		},
  		shape: 'box',
  		shapeProperties: {
  			borderRadius: 10
  		},
  		size: 8
  	},
  	edges: {
  		arrows: {
  			middle: {
  				enabled: true
  			}
  		},
  		arrowStrikethrough: false,
  		font: {
  			size: 12
  		},
  		scaling: {
  			min: 0,
  			label: {
  				maxVisible: 8,
  				drawThreshold: 12
  			}
  		},
  		selfReferenceSize: 144,
  		smooth: {
  			forceDirection: 'none'
  		},
  		width: 2
  	},
  	interaction: {
  		hideEdgesOnDrag: false,
  		multiselect: true,
  		navigationButtons: true
  	},
  	physics: {
  		forceAtlas2Based: {
  			springLength: 100,
  			avoidOverlap: 0.5
  		},
  		minVelocity: 0.75,
  		solver: 'forceAtlas2Based',
  		timestep: 0.01
  	}
  };
  var network = new vis.Network(container, data, options);
</script>

</cfoutput>
