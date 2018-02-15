//
//  DelegationViewController.h
//  KSU_Students
//
//  Created by EJ-Mac book on 8/2/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "BaseViewController.h"
#import "DataTransfer.h"
#import "PermissionObj.h"

@interface PermissionsViewController :  BaseViewController<DataTransferDelegate,UITableViewDataSource,UITableViewDelegate>{
    UILabel *titleLbl;
    
    //ParentTableView *parentTableView;
    UITableView *tableView;
    UIView *controlsView;
    
    NSMutableArray *permissionsList;
    NSMutableArray *sectionRowsCount;
    
    UIImageView * noDataImg;
    
    
}
@property(nonatomic,retain) IBOutlet UILabel *titleLbl;

//@property(nonatomic,retain) IBOutlet ParentTableView *parentTableView;
@property(nonatomic,retain) IBOutlet UITableView *tableView;
@property(nonatomic,retain) IBOutlet UIView *controlsView;

@property(nonatomic,retain) NSMutableArray *permissionsList;
@property(nonatomic,retain) NSMutableArray *sectionRowsCount;

@property(nonatomic,retain) IBOutlet UIImageView * noDataImg;


@end
