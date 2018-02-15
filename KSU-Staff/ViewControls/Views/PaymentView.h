//
//  PaymentView.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 1/11/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaymentObj.h"
#import "HijriDateView.h"

@interface PaymentView : UIView<UITableViewDataSource,UITableViewDelegate>{
    
    UITableView *tableView;
    PaymentObj *pObj;
    
    UILabel *yearLbl;
   // UISegmentedControl *paidSegment;
    
    NSMutableArray *sectionRowsCount;
    HijriDateView *dateView;
    UIView *bgForDate;
    UIButton *paidBtn;
    UIButton *unpaidBtn;
    
    UIView *paidSelection;
    UIView *unpaidSelection;
    
}

@property(nonatomic,retain) IBOutlet UITableView *tableView;

//@property(nonatomic,retain) IBOutlet UISegmentedControl *paidSegment;
@property(nonatomic,retain) IBOutlet UILabel *yearLbl;

@property(nonatomic,retain) IBOutlet HijriDateView *dateView;
@property(nonatomic,retain) IBOutlet UIView *bgForDate;

@property(nonatomic,retain) IBOutlet UIButton *paidBtn;
@property(nonatomic,retain) IBOutlet UIButton *unpaidBtn;

@property(nonatomic,retain) IBOutlet UIView *paidSelection;
@property(nonatomic,retain) IBOutlet UIView *unpaidSelection;

-(IBAction)onLeftYearPressed:(id)sender;
-(IBAction)onRightYearPressed:(id)sender;
-(IBAction)onTypeChanged:(id)sender;


-(void)locatizeLables;
-(void)switchToLeftLayout;
-(void)switchToRightLayout;

-(void)initControls;

@end
