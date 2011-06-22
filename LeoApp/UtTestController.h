//
//  UtTestController.h
//  LeoApp
//
//  Created by David Tjokroaminoto on 6/18/11.
//  Copyright 2011 Republic Polytechnic. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UtTestController : UIViewController {
    IBOutlet UITableView *mytableView;
    IBOutlet UIBarButtonItem *refreshButton;
}
- (IBAction)refreshTimetable:(id)sender;

@property (nonatomic,retain) UITableView *mytableView;
@property (nonatomic,retain) UIBarButtonItem *refreshButton;

@end
