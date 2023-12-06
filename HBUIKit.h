//
//  HBUIKit.h
//  Pods
//
//  Created by HBLove on 2023/12/6.
//


#import <Foundation/Foundation.h>

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#elif TARGET_OS_MAC
#import <Cocoa/Cocoa.h>
#elif TARGET_OS_WATCH
#import <WatchKit/WatchKit.h>
#endif

//! Project version number for HBUIKit.
FOUNDATION_EXPORT double HBUIKitVersionNumber;

//! Project version string for HBUIKit.
FOUNDATION_EXPORT const unsigned char HBUIKitVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <HBUIKit/PublicHeader.h>
