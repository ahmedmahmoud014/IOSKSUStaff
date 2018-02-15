//
//  RequestActionsViewController.h
//  KSU_Students
//
//  Created by EJ-Mac book on 8/2/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "BaseViewController.h"
#import "DataTransfer.h"
#import "RequestActionsObj.h"
#import "HijriDateView.h"



@interface RequestActionsViewController :  BaseViewController<DataTransferDelegate,UITableViewDataSource,UITableViewDelegate>{
    UILabel *titleLbl;
    
    
    UITableView *tableView;
    UIView *controlsView;
    UIButton *viewBackBtn;
    
    NSMutableArray *listOfRequestActions;
    
    UIView *backgroundView;
    UIView *detailsView;
    UILabel *userNameLbl;
    UIView *userNameValView;
    UILabel *userNameValLbl;
    
    UILabel *actionLbl;
    UIView *actionValView;
    UILabel *actionValLbl;
    
    UILabel *reasonLbl;
    UIView *reasonValView;
    UILabel *reasonValLbl;
    
    UILabel *dateLbl;
    UIView *dateValView;
    UILabel *dateValLbl;
    UIButton *detaislBackBtn;
    
    NSString *selectedRequest;
    
    UIImageView * noDataImg;
}
@property(nonatomic,retain) IBOutlet UILabel *titleLbl;


@property(nonatomic,retain) IBOutlet UITableView *tableView;
@property(nonatomic,retain) IBOutlet UIView *controlsView;
@property(nonatomic,retain) IBOutlet UIButton *viewBackBtn;

@property(nonatomic,retain) NSMutableArray *listOfRequestActions;

@property(nonatomic,retain) IBOutlet UIView *backgroundView;
@property(nonatomic,retain) IBOutlet UIView *detailsView;
@property(nonatomic,retain) IBOutlet UILabel *userNameLbl;
@property(nonatomic,retain) IBOutlet UIView *userNameValView;
@property(nonatomic,retain) IBOutlet UILabel *userNameValLbl;
@property(nonatomic,retain) IBOutlet UILabel *actionLbl;
@property(nonatomic,retain) IBOutlet UIView *actionValView;
@property(nonatomic,retain) IBOutlet UILabel *actionValLbl;
@property(nonatomic,retain) IBOutlet UILabel *reasonLbl;
@property(nonatomic,retain) IBOutlet UIView *reasonValView;
@property(nonatomic,retain) IBOutlet UILabel *reasonValLbl;
@property(nonatomic,retain) IBOutlet UILabel *dateLbl;
@property(nonatomic,retain) IBOutlet UIView *dateValView;
@property(nonatomic,retain) IBOutlet UILabel *dateValLbl;
@property(nonatomic,retain) IBOutlet UIButton *detaislBackBtn;

@property(nonatomic,retain) NSString *selectedRequest;

@property(nonatomic,retain) IBOutlet UIImageView * noDataImg;

-(IBAction)onPressBack:(id)sender;
-(IBAction)onPressDetails:(id)sender;

@end
