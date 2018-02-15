//
//  CustodyViewController.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 1/4/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "BaseViewController.h"
#import "DataTransfer.h"
#import "CustodyObj.h"

@interface CustodyViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,DataTransferDelegate>{
    UILabel *titleLbl;
    UITableView *tableView;
    
    NSMutableArray * custodyArr;
    
    UIView *headerView;
    UILabel *remarksHeaderLbl;
    UILabel *decrpHeaderLbl;
    UILabel *quantityHeaderLbl;
    UIView *headerSperatorView;
    UIView *headerSperator2View;
    
    UIView *controlsView;
    UIImageView * noDataImg;
}

@property(nonatomic,retain) IBOutlet UILabel *titleLbl;
@property(nonatomic,retain) IBOutlet UITableView *tableView;


@property(nonatomic,retain) IBOutlet UIView *headerView;
@property(nonatomic,retain) IBOutlet UILabel *remarksHeaderLbl;
@property(nonatomic,retain) IBOutlet UILabel *decrpHeaderLbl;
@property(nonatomic,retain) IBOutlet UILabel *quantityHeaderLbl;

@property(nonatomic,retain) IBOutlet UIView *headerSperatorView;
@property(nonatomic,retain) IBOutlet UIView *headerSperator2View;
@property(nonatomic,retain) IBOutlet UIView *controlsView;


@property(nonatomic,retain) IBOutlet UIImageView * noDataImg;



@end
