//
//  userSettingsController.h
//  LeoApp
//
//  Created by David Tjokroaminoto on 6/18/11.
//  Copyright 2011 Republic Polytechnic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>


@interface userSettingsController : UIViewController <ADBannerViewDelegate> {
    IBOutlet UITextField *username;
    IBOutlet UITextField *password;
    IBOutlet UIButton *saveButton;
    ADBannerView *bannerView;
    BOOL bannerIsVisible;
}

@property (nonatomic,assign) BOOL bannerIsVisible;
@property (nonatomic,retain) UITextField *username;
@property (nonatomic,retain) UITextField *password;
@property (nonatomic,retain) UIButton *saveButton;

-(IBAction)saveCredentials:(id)sender;

@end
