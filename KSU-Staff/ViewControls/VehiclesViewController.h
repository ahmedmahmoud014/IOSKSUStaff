//
//  VehiclesViewController.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 1/28/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "BaseViewController.h"
#import "DataTransfer.h"

@interface VehiclesViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,DataTransferDelegate>{
    UILabel *titleLbl;
    UITableView *tableView;
    NSMutableArray *vehiclesArr;
}

@property(nonatomic,retain) IBOutlet UILabel *titleLbl;
@property(nonatomic,retain) IBOutlet UITableView *tableView;
@end
