//
//  LeoAppViewController.m
//  LeoApp
//
//  Created by David Tjokroaminoto on 6/15/11.
//  Copyright 2011 Republic Polytechnic. All rights reserved.
//

#import "DailyGradeController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "CJSONDeserializer.h"

@implementation DailyGradeController
@synthesize mytableView;
@synthesize refreshButton;

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int numsecs = [[defaults objectForKey:@"classes"] count];
    return numsecs;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5 ;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults boolForKey:@"error"]){
        return @"";
    }
    else{
        NSArray *classes = [defaults arrayForKey:@"classes"];
        return [[classes objectAtIndex:section]objectAtIndex:0];
        [classes release];
    }
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
        NSArray *classes = [defaults objectForKey:@"classes"];
        cell.textLabel.text = [[classes objectAtIndex:indexPath.section]objectAtIndex:indexPath.row+1];
    }
    return cell;    
    [MyIdentifier release];
    [cell release];
    
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
    [request setPostValue:@"timetable" forKey:@"mode"];
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
        [defaults setObject:result forKey:@"classes"];
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

#pragma mark - View lifecycle

- (void)viewDidLoad
{ 
    [super viewDidLoad];
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
