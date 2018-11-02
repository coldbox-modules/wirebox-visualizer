# WireBox Visualizer

[![Build Status](https://travis-ci.org/coldbox-modules/wirebox-visualizer.svg?branch=master)](https://travis-ci.org/coldbox-modules/wirebox-visualizer)

This module creates a nifty visual representation of all the CFCs in your application that WireBox manages as well as what they have injected into them.  

## Installation

```bash
install wirebox-visualizer --saveDev
```

Next, reinitialize your application to pick up the new module.

## Usage

In order to view the visualizer, hit your app at this route:

```
localhost/wireboxVisualizer/
```

### I don't see all my CFCs

The data is loaded from all of the mappings that WireBox has loaded at the time you hit the page.  That means any CFCs explicitly mapped on app startup will automatically show up.
However, if you have a transient CFC that is not explicitly mapped but looked up via scan location on demand, you'll need to hit the part of your app that loads that CFC before the WireBox Visualizer will be able to display it.
This is due to how WireBox lazy loads mappings that are found via scan locations or ad-hoc CFC creations. 

### Not for production

This module is meant for development use only.  It could expose information about your application so don't deploy it to production.  
That's why we recommend using the `--saveDev` flag shown above so it doesn't get deployed on production.  See our docs on production installs:
https://commandbox.ortusbooks.com/package-management/installing-packages/installation-options#production-installation