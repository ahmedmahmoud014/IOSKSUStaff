//
//  JobInfoViewController.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 12/31/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "BaseViewController.h"
#import "ProfileObj.h"
#import "DataTransfer.h"
@interface JobInfoViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,DataTransferDelegate>{
    
    UILabel *titleLbl;
    UITableView *tableView;
    ProfileObj *pObj;
}

@property(nonatomic,retain) IBOutlet UILabel *titleLbl;
@property(nonatomic,retain) IBOutlet UITableView *tableView;
@end
