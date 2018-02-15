//
//  ScheduleViewController.h
//  KSU_Students
//
//  Created by EJ-Mac book on 8/2/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "BaseViewController.h"
#import "DataTransfer.h"
#import "FullScheduleObj.h"

@interface ScheduleViewController :  BaseViewController<DataTransferDelegate,UITableViewDataSource,UITableViewDelegate>{
    IBOutlet UILabel *titleLbl;
    UITableView *tableView;
    UIView *controlsView;
    
    FullScheduleObj *mySchedule;
    UISegmentedControl *daySeg;
    
    UIImageView * noDataImg;
}
@property(nonatomic,retain) IBOutlet UILabel *titleLbl;
@property(nonatomic,retain) IBOutlet UITableView *tableView;
@property(nonatomic,retain) IBOutlet UIView *controlsView;

@property(nonatomic,retain) IBOutlet UISegmentedControl *daySeg;

@property(nonatomic,retain) IBOutlet UIImageView * noDataImg;


-(IBAction)onDaysChanged:(id)sender;

@end
