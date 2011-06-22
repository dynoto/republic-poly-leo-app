//
//  LeoAppAppDelegate.h
//  LeoApp
//
//  Created by David Tjokroaminoto on 6/15/11.
//  Copyright 2011 Republic Polytechnic. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LeoAppViewController;

@interface LeoAppAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@end
