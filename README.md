# MDResourceManager

[![Build Status](https://travis-ci.org/prudencioj/MDResourceManager.svg?branch=master)](https://travis-ci.org/prudencioj/MDResourceManager)
[![Version](https://img.shields.io/cocoapods/v/MDResourceManager.svg?style=flat)](http://cocoadocs.org/docsets/MDResourceManager)
[![License](https://img.shields.io/cocoapods/l/MDResourceManager.svg?style=flat)](http://cocoadocs.org/docsets/MDResourceManager)
[![Platform](https://img.shields.io/cocoapods/p/MDResourceManager.svg?style=flat)](http://cocoadocs.org/docsets/MDResourceManager)


## iOS Resource Management, the Android way.
Provide resources independently of your code. Manage different sizes, strings depending on the device type or orientation.
Inspired in the Resource management of Android.
Easily extended, you can provide your own criterias. e.g. handle different values depending on your product jurisdictions.

## Usage

### Create resource files

The first step is to create your resource files with .plist extension. 

<p align="center" >
  <img src="http://s23.postimg.org/gj1n2xfbe/Screen_Shot_2015_02_22_at_13_45_42.jpg" alt="AFNetworking" title="Resource files with .plist extension">
</p>

### Create ResourceManager

```objective-c

NSArray *criterias = @[[[MDDeviceResourceCriteria alloc] init],
                       [[MDOrientationResourceCriteria alloc] init]];
    
MDResourceManager *resourceManager = [[MDResourceManager alloc] initWithPrefixFileName:@"dimensions"
                                                                             criterias:criterias];
    
```

### Ask the manager for values 

```objective-c

CGFloat labelFontSize1 = [resourceManager floatForKey:@"labelFontSize1"];
CGFloat labelFontSize2 = [resourceManager floatForKey:@"labelFontSize2"];

```

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

MDResourceManager is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "MDResourceManager"

## Author

Joao Prudencio, joao.prudencio@mindera.com

## License

MDResourceManager is available under the MIT license. See the LICENSE file for more info.