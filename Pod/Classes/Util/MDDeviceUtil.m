//
//  MDDeviceUtil.m
//  Pods
//
//  Created by Joao Prudencio on 22/02/15.
//
//

#import "MDDeviceUtil.h"
#import <UIKit/UIKit.h>
#import <sys/utsname.h>

#define iOSVersionGreaterThan(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)

@implementation MDDeviceUtil

+ (BOOL)isDevicePortrait {
    
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    return UIDeviceOrientationIsPortrait(interfaceOrientation);
}

+ (BOOL)isDevicePad {
    
    return [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad;
}

+ (NSString *)deviceVersion {
    
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *code = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([code isEqualToString:@"i386"] || [code isEqualToString:@"x86_64"]) {
        
        NSString *simulatorDeviceType = [self simulatorDeviceType];
        // Detecting your device version is not accurate in simulator.
        return simulatorDeviceType;
    } else {
        
        return self.deviceNamesByCode[code];
    }
}

#pragma mark - Helpers

// FIXME names in constants

+ (NSDictionary*)deviceNamesByCode {
    
    static NSDictionary* deviceNamesByCode = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        deviceNamesByCode = @{
                              //iPhones
                              @"iPhone3,1" :@"iphone4",     // iPhone 4
                              @"iPhone3,2" :@"iphone4",     // iPhone 4
                              @"iPhone3,3" :@"iphone4",     // iPhone 4
                              @"iPhone4,1" :@"iphone4s",    // iPhone 4s
                              @"iPhone4,2" :@"iphone4s",    // iPhone 4s
                              @"iPhone4,3" :@"iphone4s",    // iPhone 4s
                              @"iPhone5,1" :@"iphone5",     // iPhone 5
                              @"iPhone5,2" :@"iphone5",     // iPhone 5
                              @"iPhone5,3" :@"iphone5c",    // iPhone 5c
                              @"iPhone5,4" :@"iphone5c",    // iPhone 5c
                              @"iPhone6,1" :@"iphone5s",    // iPhone 5s
                              @"iPhone6,2" :@"iphone5s",    // iPhone 5s
                              @"iPhone7,2" :@"iphone6",     // iPhone 6
                              @"iPhone7,1" :@"iphone6plus", // iPhone 6 Plus
                              @"iPhone8,1" :@"iphone6",     // iPhone 6s
                              @"iPhone8,2" :@"iphone6plus", // iPhone 6s Plus
                              @"iPhone8,4" :@"iphone5",     // iPhone SE
                              @"iPhone9,1" :@"iphone6",     // iPhone 7
                              @"iPhone9,3" :@"iphone6",     // iPhone 7
                              @"iPhone9,2" :@"iphone6plus", // iPhone 7 Plus
                              @"iPhone9,4" :@"iphone6plus", // iPhone 7 Plus
                              @"iPhone10,1" :@"iphone6",    // iPhone 8
                              @"iPhone10,4" :@"iphone6",    // iPhone 8
                              @"iPhone10,2" :@"iphone6plus",// iPhone 8 Plus
                              @"iPhone10,5" :@"iphone6plus",// iPhone 8 Plus
                              @"iPhone10,3" :@"iphonex",    // iPhone X
                              @"iPhone10,6" :@"iphonex",    // iPhone X
                              @"i386"      :@"simulator",
                              @"x86_64"    :@"simulator",
                              
                              //iPads
                              @"iPad1,1" :@"ipad1",
                              @"iPad2,1" :@"ipad2",
                              @"iPad2,2" :@"ipad2",
                              @"iPad2,3" :@"ipad2",
                              @"iPad2,4" :@"ipad2",
                              @"iPad2,5" :@"ipadmini",
                              @"iPad2,6" :@"ipadmini",
                              @"iPad2,7" :@"ipadmini",
                              @"iPad3,1" :@"ipad3",
                              @"iPad3,2" :@"ipad3",
                              @"iPad3,3" :@"ipad3",
                              @"iPad3,4" :@"ipad4",
                              @"iPad3,5" :@"ipad4",
                              @"iPad3,6" :@"ipad4",
                              @"iPad4,1" :@"ipadair",
                              @"iPad4,2" :@"ipadair",
                              @"iPad4,3" :@"ipadair",
                              @"iPad4,4" :@"ipadmini2",
                              @"iPad4,5" :@"ipadmini2",
                              @"iPad4,6" :@"ipadmini2",
                              @"iPad4,7" :@"ipadmini3",
                              @"iPad4,8" :@"ipadmini3",
                              @"iPad4,9" :@"ipadmini3",
                              @"iPad5,3" :@"ipadair2",
                              @"iPad5,4" :@"ipadair2",
                              
                              };
    });
    
    return deviceNamesByCode;
}

/**
 *  When running in a simulator we can't get the device type.
 *  As a workaround we try to estimate based on the screen dimensions.
 *  It's far from being accurate, and it should not go to release builds.
 *  @return device identifier
 */
+ (NSString *)simulatorDeviceType {
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        
        return @"ipad";
    }
    
    CGFloat screenHeight = 0;
    
    if (iOSVersionGreaterThan(@"8")) {
        
        UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
        
        if (orientation ==  UIDeviceOrientationPortrait) {
            
            screenHeight = [[UIScreen mainScreen] bounds].size.height;
        } else if((orientation == UIDeviceOrientationLandscapeRight) || (orientation == UIInterfaceOrientationLandscapeLeft)) {
            
            screenHeight = [[UIScreen mainScreen] bounds].size.width;
        }
    } else {
        
        screenHeight = [[UIScreen mainScreen] bounds].size.height;
    }
    
    if (screenHeight == 480) {
        
        return @"iphone4";
    } else if(screenHeight == 568) {
        
        return @"iphone5";
    } else if(screenHeight == 667) {
     
        return  @"iphone6";
    } else if(screenHeight == 736) {
        
        return @"iphone6plus";
    } else if (screenHeight == 812) {
        
        return @"iphonex";
    } else {
     
        return @"iphone";
    }
}

@end
