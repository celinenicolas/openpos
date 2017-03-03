# OpenPOS

OpenPOS is a SDK to to integrate a POS system into your application.
It works with REST API or local JSON files

***

## Installation

OpenPOS supports several methods for installing the library in a project.

## CocoaPods

The easiest way to get OpenPOS into your iOS project is to use CocoaPods.
```
gem install cocoapods
```

If you don't have a Podfile yet, create one in the root folder of your project.

Now you can install OpenPOS with the following command:
```
pod 'OpenPOS'
```

## Carthage

Not available. 

## Manual Installation

To help users stay up to date with the latests version of our Swift SDK, we always recommend integrating our SDK via CocoaPods, which simplifies version updates and dependency management. However, there are cases where users can't use CocoaPods. Not to worry, just follow these manual installation steps and you'll be all set.

### Step 1: Add as a Submodule

Add OpenPOS as a submodule to your local git repo like so:

```
git submodule add git@github.com:celinenicolas/openpos.git
```

Now the Mixpanel project and its files should be in your project folder! 

### Step 2: Drag OpenPOS to your project

Drag the OpenPOS.xcodeproj inside your sample project under the main sample project file:

### Step 3: Embed the framework

Select your app .xcodeproj file. Under "General", add the OpenPOS framework as an embedded binary.

***

## Integration

Import OpenPOS into AppDelegate.swift, and initialize OpenPOS within `application:didFinishLaunchingWithOptions:`

```
func application(_ application: UIApplication,
                 didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    OpenPOS.config(apiKey: "OPENPOS_APIKEY", "ENDPOINT_URL")
}
```

## Initializing
```
let openpos = OpenPOS.config(apiKey: "OPENPOS_APIKEY", "ENDPOINT_URL") 	// Use a REST API to retrieve data
let openpos = OpenPOS.config(apiKey: "OPENPOS_APIKEY") 					// Use local JSON files added to your project to Data/
```
## Usage
```
let openpos = OpenPOS.getInstance()
```

You need to implement DataManagerDelegate to receive Data 
```
openpos.dataManager?.setDelegate(delegate: self)
openpos.dataManager?.retrieveCategories(forCategory: 0, withProducts: false)
```	

Have any questions? Normal. Contact me.