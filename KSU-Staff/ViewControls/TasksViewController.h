//
//  TasksViewController.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 11/16/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "BaseViewController.h"
#import "TaskObj.h"

@interface TasksViewController :  BaseViewController<UITableViewDataSource,UITableViewDelegate>{
    
    UILabel *titleLbl;
    UITableView *tableView;
    NSMutableArray *tasksArr;
    
    NSMutableArray *sectionRowsCount;
}

@property(nonatomic,retain) IBOutlet UILabel *titleLbl;
@property(nonatomic,retain) IBOutlet UITableView *tableView;


@end
