//
//  ProfileViewController.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 10/15/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "BaseViewController.h"
#import "ProfileObj.h"
#import "DataTransfer.h"
#import "PassportObj.h"

@interface ProfileViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,DataTransferDelegate>{
 
    UILabel *titleLbl;
    UITableView *tableView;
    ProfileObj *pObj;
    PassportObj *passObj;
}

@property(nonatomic,retain) IBOutlet UILabel *titleLbl;
@property(nonatomic,retain) IBOutlet UITableView *tableView;
@end
