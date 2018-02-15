//
//  DelegationViewController.h
//  KSU_Students
//
//  Created by EJ-Mac book on 8/2/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "BaseViewController.h"
#import "DataTransfer.h"
#import "DelegationObj.h"
#import "ServicesObj.h"
#import "HijriDateView.h"


typedef enum detailsParent{
    add=0,
    edit
    
}detailsParent;


@interface DelegationViewController :  BaseViewController<UIGestureRecognizerDelegate,UITextFieldDelegate,DataTransferDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate>{
    UILabel *titleLbl;
    UIButton *addBtn;
    UIButton *searchBtn;
    
    UITableView *delegationTableView;
    UIButton *filterListBackBtn;
    UIView *controlsView;
    
    NSString *selectedDirection;
    NSInteger delegationsCount;
    NSMutableArray *listOfDelegations;
    NSMutableArray *listOfDelegationsAfterEmpty;
    NSMutableArray *filteredDelegations;
    NSMutableArray *listOfServices;
    NSString *lastUserSearchVal;
    
    UIView *backgroundView;
    UIView *filterView;
    UILabel *filterRequestLbl;
    UIView *filterRequestValView;
    UITextField *filterRequestValTxt;
    UILabel *filterUserNameLbl;
    UIView *filterUserNameValView;
    UITextField *filterUserNameValTxt;
    UIView *filterStartDateView;
    UILabel *filterStartDateLbl;
    UIButton *filterStartDateChangeBtn1;
    UIButton *filterStartDateChangeBtn2;
    UILabel *filterStartDateDayLbl;
    UILabel *filterStartDateMonthLbl;
    UILabel *filterStartDateYearLbl;
    UIView *filterEndDateView;
    UILabel *filterEndDateLbl;
    UIButton *filterEndDateChangeBtn1;
    UIButton *filterEndDateChangeBtn2;
    UILabel *filterEndDateDayLbl;
    UILabel *filterEndDateMonthLbl;
    UILabel *filterEndDateYearLbl;
    UILabel *filterActivateLbl;
    UIButton *filterActivateBtn;
    UILabel  *filterDeActivateLbl;
    UIButton *filterDeActivateBtn;
    NSString *filterChangeSearchStatus;
    UIButton *filterEmptyBtn;
    
    UIButton *filterDoneBtn;
    UIButton *filterBackBtn;
    
    UIButton *filterEmptyBtnEnglish;
    UIButton *filterDoneBtnEnglish;
    UIButton *filterBackBtnEnglish;
    
    UIView *detailsView;
    UILabel *detailsUserNameLbl;
    UIView *detailsUserNameValView;
    UITextField *detailsUserNameValTxt;
    UIButton *detailsUserNameSearchBtn;
    UIButton *detailsUserNameDetailsBtn;
    UIView *detailsStartDateView;
    UILabel *detailsStartDateLbl;
    UIButton *detailsStartDateChangeBtn1;
    UIButton *detailsStartDateChangeBtn2;
    UILabel *detailsStartDateDayLbl;
    UILabel *detailsStartDateMonthLbl;
    UILabel *detailsStartDateYearLbl;
    UIView *detailsEndDateView;
    UILabel *detailsEndDateLbl;
    UIButton *detailsEndDateChangeBtn1;
    UIButton *detailsEndDateChangeBtn2;
    UILabel *detailsEndDateDayLbl;
    UILabel *detailsEndDateMonthLbl;
    UILabel *detailsEndDateYearLbl;
    UILabel *detailsServiceLbl;
    UIView *detailsServiceValView;
    UITextField *detailsServiceValTxt;
    UIButton *detailsServiceSearchBtn;
    UILabel *detailsRequestLbl;
    UIView *detailsRequestValView;
    UITextField *detailsRequestValTxt;
    UILabel *detailsStatusLbl;
    UIButton *detailsStatusBtn;
    UIButton *detailsDoneBtn;
    UIButton *detailsBackBtn;
    UIButton *detailsDoneEnglishBtn;
    UIButton *detailsBackEnglishBtn;
    NSInteger detailsAction;
    NSInteger selectedDelegation;
    
    
    
    UIImageView * noDataImg;
    
    NSString *targetDateView;
    HijriDateView *searchDateView;
    HijriDateView *detailsDateView;
    NSDate *startDate;
    NSDate *endDate;
    BOOL searching;
    
    
    DelegationObj *editObj;
    
    UIView *usersSearchView;
    UITableView *usersTblView;
    NSMutableArray *listOfUsers;
    
   
    UIButton *searchCancelbtn;
    UIButton *searchChoosebtn;
    UIButton *usersearchCancelbtn;
    UIButton *usersearchChoosebtn;
    UIButton * searchCancelUserbtn;
    UIButton *searchChooseUserbtn;
    
    UIButton *searchCancelbtnArabic;
    UIButton *searchChoosebtnArabic;
    UserObj *lastSelectedObj;
    
    UIView *selectedUserDetailsView;
    UILabel *selectedUserUserNameLbl;
    UILabel *selectedUserUserNameVal;
    UILabel *selectedUserNameLbl;
    UILabel *selectedUserNameVal;
    UILabel *selectedUserJobCodeLbl;
    UILabel *selectedUserJobCodeVal;
    UILabel *selectedUserJobTitleLbl;
    UILabel *selectedUserJobTitleVal;
    UIButton *selectedUserDetailsBackBtn;
    
    UIView *servicesSearchView;
    UIView *actionSearchView;
    UIView *actionSearchViewArabic;
    
    UIView *searchViewArabic;
    UIView *searchViewEnglish;
    
    UITableView *servicesTblView;
    UIButton *searchServicesCancelbtn;
    UIButton *searchServicesChoosebtn;
}
@property (weak, nonatomic) IBOutlet UIView *actionviewenglish;
@property (weak, nonatomic) IBOutlet UIView *actionviewarabic;

@property (weak, nonatomic) IBOutlet UIView *usersearchenglish;
@property (weak, nonatomic) IBOutlet UIView *usersearchArabic;

@property (weak, nonatomic) IBOutlet UIView *searchViewArabic;
@property (weak, nonatomic) IBOutlet UIView *searchViewEnglish;

@property(nonatomic,retain) IBOutlet UIButton *filterEmptyBtnEnglish;
@property(nonatomic,retain) IBOutlet UIButton *filterDoneBtnEnglish;
@property(nonatomic,retain) IBOutlet UIButton *filterBackBtnEnglish;


@property (weak, nonatomic) IBOutlet UIView *actionSearchView;

@property (weak, nonatomic) IBOutlet UIView *actionSearchViewArabic;

@property(nonatomic,retain) IBOutlet UILabel *titleLbl;
@property(nonatomic,retain) IBOutlet UIButton *addBtn;
@property(nonatomic,retain) IBOutlet UIButton *searchBtn;

@property(nonatomic,retain) IBOutlet UITableView *delegationTableView;
@property(nonatomic,retain) IBOutlet UIButton *filterListBackBtn;
@property(nonatomic,retain) IBOutlet UIView *controlsView;

@property(nonatomic,retain) NSString *selectedDirection;
@property (nonatomic) NSInteger delegationsCount;
@property(nonatomic,retain) NSMutableArray *listOfDelegations;
@property(nonatomic,retain) NSMutableArray *listOfDelegationsAfterEmpty;

@property(nonatomic,retain) NSMutableArray *filteredDelegations;
@property(nonatomic,retain) NSMutableArray *listOfServices;
@property(nonatomic,retain) NSString *lastUserSearchVal;

@property(nonatomic,retain) IBOutlet UIView *backgroundView;
@property(nonatomic,retain) IBOutlet UIView *filterView;
@property(nonatomic,retain) IBOutlet UILabel *filterRequestLbl;
@property(nonatomic,retain) IBOutlet UIView *filterRequestValView;
@property(nonatomic,retain) IBOutlet UITextField *filterRequestValTxt;
@property(nonatomic,retain) IBOutlet UILabel *filterUserNameLbl;
@property(nonatomic,retain) IBOutlet UIView *filterUserNameValView;
@property(nonatomic,retain) IBOutlet UITextField *filterUserNameValTxt;
@property(nonatomic,retain) IBOutlet UIView *filterStartDateView;
@property(nonatomic,retain) IBOutlet UILabel *filterStartDateLbl;
@property(nonatomic,retain) IBOutlet UIButton *filterStartDateChangeBtn1;
@property(nonatomic,retain) IBOutlet UIButton *filterStartDateChangeBtn2;
@property(nonatomic,retain) IBOutlet UILabel *filterStartDateDayLbl;
@property(nonatomic,retain) IBOutlet UILabel *filterStartDateMonthLbl;
@property(nonatomic,retain) IBOutlet UILabel *filterStartDateYearLbl;
@property(nonatomic,retain) IBOutlet UIView *filterEndDateView;
@property(nonatomic,retain) IBOutlet UILabel *filterEndDateLbl;
@property(nonatomic,retain) IBOutlet UIButton *filterEndDateChangeBtn1;
@property(nonatomic,retain) IBOutlet UIButton *filterEndDateChangeBtn2;
@property(nonatomic,retain) IBOutlet UILabel *filterEndDateDayLbl;
@property(nonatomic,retain) IBOutlet UILabel *filterEndDateMonthLbl;
@property(nonatomic,retain) IBOutlet UILabel *filterEndDateYearLbl;
@property(nonatomic,retain) IBOutlet UILabel *filterActivateLbl;
@property(nonatomic,retain) IBOutlet UIButton *filterActivateBtn;
@property(nonatomic,retain) IBOutlet UILabel *filterDeActivateLbl;
@property(nonatomic,retain) IBOutlet UIButton *filterDeActivateBtn;
@property(nonatomic,retain) NSString *filterChangeSearchStatus;
@property(nonatomic,retain) IBOutlet UIButton *filterEmptyBtn;
@property(nonatomic,retain) IBOutlet UIButton *filterDoneBtn;
@property(nonatomic,retain) IBOutlet UIButton *filterBackBtn;

@property(nonatomic,retain) IBOutlet UIView *detailsView;
@property(nonatomic,retain) IBOutlet UILabel *detailsUserNameLbl;
@property(nonatomic,retain) IBOutlet UIView *detailsUserNameValView;
@property(nonatomic,retain) IBOutlet UITextField *detailsUserNameValTxt;
@property(nonatomic,retain) IBOutlet UIButton *detailsUserNameSearchBtn;
@property(nonatomic,retain) IBOutlet UIButton *detailsUserNameDetailsBtn;
@property(nonatomic,retain) IBOutlet UIView *detailsStartDateView;
@property(nonatomic,retain) IBOutlet UILabel *detailsStartDateLbl;
@property(nonatomic,retain) IBOutlet UIButton *detailsStartDateChangeBtn1;
@property(nonatomic,retain) IBOutlet UIButton *detailsStartDateChangeBtn2;
@property(nonatomic,retain) IBOutlet UILabel *detailsStartDateDayLbl;
@property(nonatomic,retain) IBOutlet UILabel *detailsStartDateMonthLbl;
@property(nonatomic,retain) IBOutlet UILabel *detailsStartDateYearLbl;
@property(nonatomic,retain) IBOutlet UIView *detailsEndDateView;
@property(nonatomic,retain) IBOutlet UILabel *detailsEndDateLbl;
@property(nonatomic,retain) IBOutlet UIButton *detailsEndDateChangeBtn1;
@property(nonatomic,retain) IBOutlet UIButton *detailsEndDateChangeBtn2;
@property(nonatomic,retain) IBOutlet UILabel *detailsEndDateDayLbl;
@property(nonatomic,retain) IBOutlet UILabel *detailsEndDateMonthLbl;
@property(nonatomic,retain) IBOutlet UILabel *detailsEndDateYearLbl;
@property(nonatomic,retain) IBOutlet UILabel *detailsServiceLbl;
@property(nonatomic,retain) IBOutlet UIView *detailsServiceValView;
@property(nonatomic,retain) IBOutlet UITextField *detailsServiceValTxt;
@property(nonatomic,retain) IBOutlet UIButton *detailsServiceSearchBtn;
@property(nonatomic,retain) IBOutlet UILabel *detailsRequestLbl;
@property(nonatomic,retain) IBOutlet UIView *detailsRequestValView;
@property(nonatomic,retain) IBOutlet UITextField *detailsRequestValTxt;
@property(nonatomic,retain) IBOutlet UILabel *detailsStatusLbl;
@property(nonatomic,retain) IBOutlet UIButton *detailsStatusBtn;
@property(nonatomic,retain) IBOutlet UIButton *detailsDoneBtn;
@property(nonatomic,retain) IBOutlet UIButton *detailsBackBtn;

@property(nonatomic,retain) IBOutlet UIButton *detailsDoneEnglishBtn;
@property(nonatomic,retain) IBOutlet UIButton *detailsBackEnglishBtn;


@property(nonatomic,retain) IBOutlet UIImageView * noDataImg;

@property(nonatomic,retain) NSString *targetDateView;
@property(nonatomic,retain) IBOutlet HijriDateView *searchDateView;
@property(nonatomic,retain) IBOutlet HijriDateView *detailsDateView;
@property(nonatomic) BOOL searching;

@property(nonatomic,retain) DelegationObj *editObj;

@property(nonatomic,retain) IBOutlet UIView *usersSearchView;
@property(nonatomic,retain) IBOutlet UITableView *usersTblView;
@property(nonatomic,retain) NSMutableArray *listOfUsers;
@property(nonatomic,retain) IBOutlet UIButton *searchCancelbtn;
@property(nonatomic,retain) IBOutlet UIButton *searchChoosebtn;
@property(nonatomic,retain) IBOutlet UIButton *searchCancelUserbtn;
@property(nonatomic,retain) IBOutlet UIButton *searchChooseUserbtn;

@property(nonatomic,retain) IBOutlet UIButton *searchCancelbtnArabic;
@property(nonatomic,retain) IBOutlet UIButton *searchChoosebtnArabic;

@property(nonatomic,retain) UserObj *lastSelectedObj;

@property(nonatomic,retain) IBOutlet UIView *selectedUserDetailsView;
@property(nonatomic,retain) IBOutlet UILabel *selectedUserUserNameLbl;
@property(nonatomic,retain) IBOutlet UILabel *selectedUserUserNameVal;
@property(nonatomic,retain) IBOutlet UILabel *selectedUserNameLbl;
@property(nonatomic,retain) IBOutlet UILabel *selectedUserNameVal;
@property(nonatomic,retain) IBOutlet UILabel *selectedUserJobCodeLbl;
@property(nonatomic,retain) IBOutlet UILabel *selectedUserJobCodeVal;
@property(nonatomic,retain) IBOutlet UILabel *selectedUserJobTitleLbl;
@property(nonatomic,retain) IBOutlet UILabel *selectedUserJobTitleVal;
@property(nonatomic,retain) IBOutlet UIButton *selectedUserDetailsBackBtn;
@property(nonatomic,retain) IBOutlet UIButton *selectedUserDetailsBackEnglishBtn;


@property(nonatomic,retain) IBOutlet UIView *servicesSearchView;
@property(nonatomic,retain) IBOutlet UITableView *servicesTblView;
@property(nonatomic,retain) IBOutlet UIButton *searchServicesCancelbtn;
@property(nonatomic,retain) IBOutlet UIButton *searchServicesChoosebtn;

-(BOOL)validate;
-(IBAction)onPressSearch:(id)sender;
-(IBAction)onPressSearchActions:(id)sender;
-(IBAction)onPressAdd:(id)sender;
-(IBAction)onPressSearchUserActions:(id)sender;
-(IBAction)onselectdatePressed:(id)sender;
- (NSString*)concatenateString :(NSString*)title value:(NSString *)value;
@end
