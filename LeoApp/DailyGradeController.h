//
//  LeoAppViewController.h
//  LeoApp
//
//  Created by David Tjokroaminoto on 6/15/11.
//  Copyright 2011 Republic Polytechnic. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DailyGradeController : UIViewController{
    
    IBOutlet UITableView *mytableView;
    IBOutlet UIBarButtonItem *refreshButton;
}
- (IBAction)refreshTimetable:(id)sender;

@property (nonatomic,retain) UIBarButtonItem *refreshButton;
@property (nonatomic,retain) UITableView *mytableView;
@end
