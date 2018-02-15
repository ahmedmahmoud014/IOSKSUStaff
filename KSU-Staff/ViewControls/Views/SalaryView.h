//
//  SalaryView.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 1/11/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SalaryObj.h"
#import "HijriDateView.h"

@interface SalaryView : UIView<UITableViewDataSource,UITableViewDelegate>{
    
    UITableView *tableView;
    SalaryObj *sObj;
    
    UILabel *monthLbl;
    UILabel *yearLbl;
    
    HijriDateView *dateView;
    UIView *bgForDate;
    
    UILabel * totalDeserveValLbl;
    UILabel * totalDiscountValLbl;
    UILabel * totalNetValLbl;
    
    UILabel * totalDeserveLbl;
    UILabel * totalDiscountLbl;
    UILabel * totalNetLbl;
    
}
@property(nonatomic,retain) IBOutlet UITableView *tableView;

@property(nonatomic,retain) IBOutlet UILabel *monthLbl;
@property(nonatomic,retain) IBOutlet UILabel *yearLbl;

@property(nonatomic,retain) IBOutlet HijriDateView *dateView;
@property(nonatomic,retain) IBOutlet UIView *bgForDate;

@property(nonatomic,retain) IBOutlet UILabel * totalDeserveValLbl;
@property(nonatomic,retain) IBOutlet UILabel * totalDiscountValLbl;
@property(nonatomic,retain) IBOutlet UILabel * totalNetValLbl;

@property(nonatomic,retain) IBOutlet UILabel * totalDeserveLbl;
@property(nonatomic,retain) IBOutlet UILabel * totalDiscountLbl;
@property(nonatomic,retain) IBOutlet UILabel * totalNetLbl;

-(IBAction)onLeftPressed:(id)sender;
-(IBAction)onRightPressed:(id)sender;

-(void)locatizeLables;
-(void)switchToLeftLayout;
-(void)switchToRightLayout;

-(void)initControls;
@end
