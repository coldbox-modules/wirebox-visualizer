
# WireBox Visualizer

[![Build Status](https://travis-ci.org/coldbox-modules/wirebox-visualizer.svg?branch=master)](https://travis-ci.org/coldbox-modules/wirebox-visualizer)

This module creates a nifty visual representation of all the CFCs in your application that WireBox manages as well as what they have injected into them.  

## Installation

```bash
install wirebox-visualizer --saveDev
```

**Manual Step**

Since this module needs to start listening to WireBox as soon as the framework comes online, you will need to manually add an interceptor into your core `config/ColdBox.cfc` file.  It will start the magic working before the module is even loaded.


`config/ColdBox.cfc`

```js

interceptors = [
	{ class: 'modules.wireboxVisualizer.interceptors.InjectWatcher' }
];
```

*Modify the path as necessary if you've placed the module in a non-standard location

Finally, reinitialize your application to pick up the new module.

## Usage

In order to view the visualizer, hit your app at this route:

```
localhost/wireboxVisualizer/
```

### Lazy Loaded

The data is loaded into the visualizer after WireBox processes the instances.  That means you want to browse around your application so the code will run and CFCs will be created.  CFCs that are not created simply by hitting your site's home page won't show up in the visualizer.  You get live data so you've got to warm it up first!

### Not for production

This module is meant for development use only.  It could expose information about your application so don't deploy it to production.