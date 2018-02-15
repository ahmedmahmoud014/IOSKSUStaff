//
//  NotificationViewController.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 6/24/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "BaseViewController.h"
#import "DataTransfer.h"

@interface NotificationViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,DataTransferDelegate>{
    UITableView *tableView;
    UILabel *titleLbl;
    NSMutableArray *notifyLstArr;
    NSMutableArray *sectionRowsCount;
    
    UIButton *deleteBtn;
    
}

@property(nonatomic,retain) IBOutlet UILabel *titleLbl;
@property(nonatomic,retain) IBOutlet UITableView *tableView;
@property(nonatomic,retain) IBOutlet UIButton *deleteBtn;
-(void)connect;
-(IBAction)onDeletePressed:(id)sender;

@end
