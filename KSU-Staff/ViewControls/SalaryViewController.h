//
//  SalaryViewController.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 10/19/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "BaseViewController.h"
#import "SalaryObj.h"
#import "HijriDateView.h"
#import "DataTransfer.h"

@interface SalaryViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,DataTransferDelegate>{
    
    UILabel *titleLbl;
    UITableView *tableView;
    SalaryObj *sObj;
    
    UILabel *monthLbl;
    UILabel *yearLbl;
    
   // NSMutableArray *sectionRowsCount;
    HijriDateView *dateView;
    UIView *bgForDate;

    
    UILabel * totalDeserveValLbl;
    UILabel * totalDiscountValLbl;
    UILabel * totalNetValLbl;
    
    UILabel * totalDeserveLbl;
    UILabel * totalDiscountLbl;
    UILabel * totalNetLbl;
    
    UIView  * summaryView;
    UILabel * summaryLbl;
    
    UIView  * selectionView;
    
    UIButton *paymentBtn;
    UIButton *allowanceBtn;
    UIButton *deductionBtn;
    
    UIView *paymentSelection;
    UIView *allowanceSelection;
    UIView *deductionSelection;
    SalarySections activeSection;
    NSDate *date;
    
    UIButton *sendClaimBtn;
    UIButton *ClaimLstBtn;
    
    UIButton *sendClaimImgBtn;
    UIButton *ClaimLstImgBtn;
    
    UIView *controlsView;
    
    UIImageView * noDataImg;
    
    

}




@property(nonatomic,retain) IBOutlet UILabel *titleLbl;
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
@property(nonatomic,retain) IBOutlet UIView  * summaryView;
@property(nonatomic,retain) IBOutlet UILabel * summaryLbl;

@property(nonatomic,retain) IBOutlet UIView  * selectionView;

@property(nonatomic,retain) IBOutlet UIButton *paymentBtn;
@property(nonatomic,retain) IBOutlet UIButton *allowanceBtn;
@property(nonatomic,retain) IBOutlet UIButton *deductionBtn;

@property(nonatomic,retain) IBOutlet UIView *paymentSelection;
@property(nonatomic,retain) IBOutlet UIView *allowanceSelection;
@property(nonatomic,retain) IBOutlet UIView *deductionSelection;

@property(nonatomic,retain) IBOutlet UIButton *sendClaimBtn;
@property(nonatomic,retain) IBOutlet UIButton *ClaimLstBtn;

@property(nonatomic,retain) IBOutlet UIButton *sendClaimImgBtn;
@property(nonatomic,retain) IBOutlet UIButton *ClaimLstImgBtn;

@property(nonatomic,retain) IBOutlet UIView *controlsView;

@property(nonatomic,retain) IBOutlet UIImageView * noDataImg;

-(IBAction)onLeftPressed:(id)sender;
-(IBAction)onRightPressed:(id)sender;

-(IBAction)ontabChange:(id)sender;

-(IBAction)onSendClaimPressed:(id)sender;
-(IBAction)onClaimLstPressed:(id)sender;
@end
