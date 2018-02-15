//
//  PaymentViewController.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 10/22/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "BaseViewController.h"
#import "PaymentObj.h"
#import "HijriDateView.h"
#import "DataTransfer.h"

@interface PaymentViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,DataTransferDelegate>{
    
    UILabel *titleLbl;
    UITableView *tableView;
    PaymentObj *pObj;
    
    UILabel *yearLbl;
   // UISegmentedControl *paidSegment;
    
    NSMutableArray *sectionRowsCount;
    HijriDateView *dateView;
    UIView *bgForDate;
    
    UIView *selectionView;
    UIButton *paidBtn;
    UIButton *unpaidBtn;
    
    UIView *paidSelection;
    UIView *unpaidSelection;
    NSDate *date;
    
    UIView *controlsView;
    UIImageView * noDataImg;
}

@property(nonatomic,retain) IBOutlet UILabel *titleLbl;
@property(nonatomic,retain) IBOutlet UITableView *tableView;

//@property(nonatomic,retain) IBOutlet UISegmentedControl *paidSegment;
@property(nonatomic,retain) IBOutlet UILabel *yearLbl;

@property(nonatomic,retain) IBOutlet HijriDateView *dateView;
@property(nonatomic,retain) IBOutlet UIView *bgForDate;

@property(nonatomic,retain) IBOutlet UIView *selectionView;
@property(nonatomic,retain) IBOutlet UIButton *paidBtn;
@property(nonatomic,retain) IBOutlet UIButton *unpaidBtn;

@property(nonatomic,retain) IBOutlet UIView *paidSelection;
@property(nonatomic,retain) IBOutlet UIView *unpaidSelection;

@property(nonatomic,retain) IBOutlet UIView *controlsView;

@property(nonatomic,retain) IBOutlet UIImageView * noDataImg;
-(IBAction)onLeftYearPressed:(id)sender;
-(IBAction)onRightYearPressed:(id)sender;

-(IBAction)onTypeChanged:(id)sender;


@end
