//
//  UtTestController.m
//  LeoApp
//
//  Created by David Tjokroaminoto on 6/18/11.
//  Copyright 2011 Republic Polytechnic. All rights reserved.
//

#import "UtTestController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "CJSONDeserializer.h"


@implementation UtTestController
@synthesize mytableView;
@synthesize refreshButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int numsecs = [[defaults objectForKey:@"ut"] count];
    return numsecs;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults boolForKey:@"error"]){
        return @"";
    }
    else{
        NSArray *classes = [defaults arrayForKey:@"ut"];
        NSString *dateStr = [[classes objectAtIndex:section]objectAtIndex:0];
        return dateStr;
        [classes release];
        [dateStr release];
    }
    [defaults release];
}   

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    UITableViewCell *cell = [mytableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if(cell == nil){
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier] autorelease];
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults boolForKey:@"error"] == TRUE) {
        cell.textLabel.text = @"";
    }
    else{
        NSArray *classes = [defaults objectForKey:@"ut"];
        cell.textLabel.text = [[classes objectAtIndex:indexPath.section]objectAtIndex:indexPath.row+1];
    }
    return cell;    
    [MyIdentifier release];
    [defaults release];
    [cell release];
    
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (IBAction)refreshTimetable:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *username = [defaults stringForKey:@"username"];
    NSString *password = [defaults stringForKey:@"password"];
    NSURL *url = [NSURL URLWithString:@"http://www.ddante.me/leo.php"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:username forKey:@"user"];
    [request setPostValue:password forKey:@"pass"];
    [request setPostValue:@"ut" forKey:@"mode"];
    [request setDelegate:self];
    [request setRequestMethod:@"POST"];
    [request startAsynchronous];
    
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *jsonValue = [request responseString];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![jsonValue isEqualToString:@"invalid"]) {
        NSData *array = [jsonValue dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *result = [[CJSONDeserializer deserializer]deserializeAsArray:array error:NULL];
        [defaults setObject:result forKey:@"ut"];
        [defaults setBool:FALSE forKey:@"error"];
        [mytableView reloadData];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error!" message:@"Data retrieve error! check internet connection and/or credentials!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        [defaults setBool:TRUE forKey:@"error"];
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
