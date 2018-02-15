//
//  CalenderViewController.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 11/13/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"


@interface CalenderViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>{
    UILabel *titleLbl;
    UITableView *tableView;
    
    NSMutableArray * calenderArr;
    bool isVacationView;
    
}
@property(nonatomic,retain) IBOutlet UILabel *titleLbl;
@property(nonatomic,retain) IBOutlet UITableView *tableView;

-(void)changeToVacationCalender;

@end
