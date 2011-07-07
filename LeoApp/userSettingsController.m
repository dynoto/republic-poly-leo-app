//
//  userSettingsController.m
//  LeoApp
//
//  Created by David Tjokroaminoto on 6/18/11.
//  Copyright 2011 Republic Polytechnic. All rights reserved.
//

#import "userSettingsController.h"


@implementation userSettingsController
@synthesize username,password,saveButton,bannerIsVisible;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)saveCredentials:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:username.text forKey:@"username"];
    [defaults setObject:password.text forKey:@"password"];
    [username resignFirstResponder];
    [password resignFirstResponder];
}

- (void)dealloc
{
    [username release];
    [password release];
    [saveButton release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    bannerView = [[ADBannerView alloc]initWithFrame:CGRectZero];
    bannerView.frame = CGRectOffset(bannerView.frame, 0, -5);
    bannerView.requiredContentSizeIdentifiers = [NSSet setWithObject:ADBannerContentSizeIdentifierPortrait];
    bannerView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
    [self.view addSubview:bannerView];
    bannerView.delegate=self;
    self.bannerIsVisible=NO;
    
    [bannerView release];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    if (!self.bannerIsVisible) {
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        // banner is invisible now and moved out of the screen on 50 px
        banner.frame = CGRectOffset(banner.frame, 0, 50);
        [UIView commitAnimations];
        self.bannerIsVisible = YES;

    }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    if (!self.bannerIsVisible) {
        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
        banner.frame = CGRectOffset(banner.frame, 0, -50);
        [UIView commitAnimations];
        self.bannerIsVisible = NO;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
