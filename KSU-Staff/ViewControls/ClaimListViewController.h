//
//  ClaimListViewController.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 2/2/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "BaseViewController.h"
#import "DataTransfer.h"

@interface ClaimListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,DataTransferDelegate>{
    UITableView *tableView;
    UILabel *titleLbl;
    NSMutableArray *claimLstArr;
    UILabel *descrpLbl;
    UILabel *dateLbl;
    UILabel *ticketNoLbl;
    UIView *controlsView;
}

@property(nonatomic,retain) IBOutlet UILabel *titleLbl;
@property(nonatomic,retain) IBOutlet UITableView *tableView;

@property(nonatomic,retain) IBOutlet UILabel *descrpLbl;
@property(nonatomic,retain) IBOutlet UILabel *dateLbl;
@property(nonatomic,retain) IBOutlet UILabel *ticketNoLbl;
@property(nonatomic,retain) IBOutlet UIView *controlsView;

@end
