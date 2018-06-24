//
//  ScheduleViewController.m
//  KSU_Students
//
//  Created by EJ-Mac book on 8/2/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "DelegationViewController.h"
#import "AppDelegate.h"
#import "LocalizedMessages.h"
#import "StaticFuntions.h"
#import "DelegationTableViewCell.h"
#import "UserTableViewCell.h"
#import "ServiceTableViewCell.h"
#import "RequestManager.h"
#import "HijriDateView.h"


@interface DelegationViewController ()

@end

@implementation DelegationViewController

@synthesize titleLbl;
@synthesize addBtn;
@synthesize searchBtn;
@synthesize delegationTableView;
@synthesize filterListBackBtn;
@synthesize controlsView;
@synthesize selectedDirection,delegationsCount,listOfDelegations,listOfDelegationsAfterEmpty,filteredDelegations,listOfServices,lastUserSearchVal;
@synthesize filterChangeSearchStatus;
@synthesize backgroundView;

@synthesize filterView,filterRequestLbl,filterRequestValView,filterRequestValTxt,filterUserNameLbl,filterUserNameValView,filterUserNameValTxt,filterStartDateView,filterStartDateLbl,filterStartDateChangeBtn1,filterStartDateChangeBtn2,filterStartDateDayLbl,filterStartDateMonthLbl,filterStartDateYearLbl,filterEndDateView,filterEndDateLbl,filterEndDateChangeBtn1,filterEndDateChangeBtn2,filterEndDateDayLbl,filterEndDateMonthLbl,filterEndDateYearLbl,filterActivateLbl,filterActivateBtn,filterDeActivateLbl,filterDeActivateBtn,filterEmptyBtn,filterDoneBtn,filterBackBtn,filterEmptyBtnEnglish,filterDoneBtnEnglish,filterBackBtnEnglish;



@synthesize detailsView,detailsUserNameLbl,detailsUserNameValView,detailsUserNameValTxt,detailsUserNameSearchBtn,detailsUserNameDetailsBtn,detailsStartDateView,detailsStartDateLbl,detailsStartDateChangeBtn1,detailsStartDateChangeBtn2,detailsStartDateDayLbl,detailsStartDateMonthLbl,detailsStartDateYearLbl,detailsEndDateView,detailsEndDateLbl,detailsEndDateChangeBtn1,detailsEndDateChangeBtn2,detailsEndDateDayLbl,detailsEndDateMonthLbl,detailsEndDateYearLbl,detailsServiceLbl,detailsServiceValView,detailsServiceValTxt,detailsServiceSearchBtn,detailsRequestLbl,detailsRequestValView,detailsRequestValTxt,detailsStatusLbl,detailsStatusBtn,detailsDoneBtn,detailsBackBtn,detailsDoneEnglishBtn,detailsBackEnglishBtn;

@synthesize noDataImg;
@synthesize targetDateView,searchDateView,detailsDateView;
@synthesize editObj;

@synthesize usersSearchView,usersTblView,listOfUsers,searchCancelbtn,searchChoosebtn,searchChoosebtnArabic,searchCancelbtnArabic,searchCancelUserbtn,searchChooseUserbtn ;
@synthesize lastSelectedObj;

@synthesize selectedUserDetailsView,selectedUserUserNameLbl,selectedUserUserNameVal,selectedUserNameLbl,selectedUserNameVal,selectedUserJobCodeLbl,selectedUserJobCodeVal,selectedUserJobTitleLbl,selectedUserJobTitleVal,selectedUserDetailsBackBtn;

@synthesize servicesSearchView,servicesTblView,searchServicesCancelbtn,searchServicesChoosebtn;
@synthesize searching;

NSInteger userSelectedRow;
NSInteger userPreviousrow;

NSInteger serviceSelectedRowDelegation;
NSInteger servicePreviousRowDelegation;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self customizeNavigationBar:YES WithMenu:YES];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.currentLang==English){
        self.actionSearchViewArabic.hidden=true;
       self.searchViewArabic.hidden=true;
        self.usersearchArabic.hidden=true;
        self.actionviewarabic.hidden=true;
    }
    else {
        self.searchViewEnglish.hidden=true;
        self. actionSearchView.hidden=true;
        self.usersearchenglish.hidden=true;
        self.actionviewenglish.hidden=true;
    }
    
    /*if(IS_IPAD){
     int x= (self.view.frame.size.width- controlsView.frame.size.width)/2;
     controlsView.frame=CGRectMake(x, controlsView.frame.origin.y, controlsView.frame.size.width, controlsView.frame.size.height);
     }*/
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(longTap:)];
    lpgr.minimumPressDuration = 0.5; //seconds
    lpgr.delegate = self;
    [self.delegationTableView addGestureRecognizer:lpgr];
    
    
    delegationTableView.layoutMargins = UIEdgeInsetsZero;
    if ([delegationTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [delegationTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    self.usersTblView.allowsSelection = YES;
    self.usersTblView.allowsSelectionDuringEditing = YES;

    self.servicesTblView.allowsSelection = YES;
    self.servicesTblView.allowsSelectionDuringEditing = YES;
    
    [self initRefreshControl:self.delegationTableView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - base methods

-(void)initalizeViews{

    
    NSLog(@"ttttttttt %@",@"initalizeViews");
    filterListBackBtn.hidden = YES;
    noDataLbl.hidden=YES;
    noDataImg.hidden=YES;
    listOfDelegations = [[NSMutableArray alloc] init];
    listOfDelegationsAfterEmpty = [[NSMutableArray alloc] init];
    filteredDelegations = [[NSMutableArray alloc] init];
    listOfServices = [[NSMutableArray alloc] init];
    lastUserSearchVal=@"";
    listOfUsers = [[NSMutableArray alloc] init];
    lastSelectedObj = [[UserObj alloc] init];
    
    searchDateView.hidden=YES;
    detailsDateView.hidden=YES;
    
    [searchDateView toolbarAlignment ];
    [detailsDateView toolbarAlignment ];

    filterView.hidden = YES;
    
    startDate=[NSDate date];
    endDate=[NSDate date];
    targetDateView = @"";
    
    filterChangeSearchStatus = @"-1";
    
    userPreviousrow = -1;
    userSelectedRow = -1;
    
    servicePreviousRowDelegation = -1;
    serviceSelectedRowDelegation = -1;
    
    
    if([self isNetworkAvailable] ==YES)
    {
        NSLog(@"Network Connection available");
        [self connect];
    }
    
    else{
        [StaticFuntions showAlertWithTitle:NetWorkTitle Message:NetWorkBody];

    }
    

    
    
    [NSTimer scheduledTimerWithTimeInterval:0.02f target:self selector:@selector(initalizeDateViewTimer) userInfo:nil repeats:FALSE];
    
    [[filterRequestValView layer] setBorderColor:[[UIColor colorWithRed:(69/255.f) green:(69/255.f) blue:(69/255.f) alpha:0.5] CGColor]];
    [[filterRequestValView layer] setBorderWidth:0.5];
    [[filterRequestValView layer] setCornerRadius:2];
    
    
    [[filterUserNameValView layer] setBorderColor:[[UIColor colorWithRed:(69/255.f) green:(69/255.f) blue:(69/255.f) alpha:0.5] CGColor]];
    [[filterUserNameValView layer] setBorderWidth:0.5];
    [[filterUserNameValView layer] setCornerRadius:2];

    [[detailsServiceValView layer] setBorderColor:[[UIColor colorWithRed:(69/255.f) green:(69/255.f) blue:(69/255.f) alpha:0.5] CGColor]];
    [[detailsServiceValView layer] setBorderWidth:0.5];
    [[detailsServiceValView layer] setCornerRadius:2];
    
    
    [[detailsRequestValView layer] setBorderColor:[[UIColor colorWithRed:(69/255.f) green:(69/255.f) blue:(69/255.f) alpha:0.5] CGColor]];
    [[detailsRequestValView layer] setBorderWidth:0.5];
    [[detailsRequestValView layer] setCornerRadius:2];
    
    
    [[detailsUserNameValView layer] setBorderColor:[[UIColor colorWithRed:(69/255.f) green:(69/255.f) blue:(69/255.f) alpha:0.5] CGColor]];
    [[detailsUserNameValView layer] setBorderWidth:0.5];
    [[detailsUserNameValView layer] setCornerRadius:2];


    delegationTableView.allowsMultipleSelectionDuringEditing = NO;
    [super setEditing:YES animated:YES];
    
    
    filterStartDateDayLbl.adjustsFontSizeToFitWidth=YES;
    filterEndDateDayLbl.adjustsFontSizeToFitWidth=YES;
    detailsStartDateDayLbl.adjustsFontSizeToFitWidth=YES;
    detailsEndDateDayLbl.adjustsFontSizeToFitWidth=YES;
    
    filterStartDateMonthLbl.adjustsFontSizeToFitWidth=YES;
    filterEndDateMonthLbl.adjustsFontSizeToFitWidth=YES;
    detailsStartDateMonthLbl.adjustsFontSizeToFitWidth=YES;
    detailsEndDateMonthLbl.adjustsFontSizeToFitWidth=YES;
    
    filterStartDateYearLbl.adjustsFontSizeToFitWidth=YES;
    filterEndDateYearLbl.adjustsFontSizeToFitWidth=YES;
    detailsStartDateYearLbl.adjustsFontSizeToFitWidth=YES;
    detailsEndDateYearLbl.adjustsFontSizeToFitWidth=YES;
    
    
    filterDeActivateBtn.selected = YES;
    filterActivateBtn.selected = YES;
    
}

-(void)locatizeLables{
  
    searching = FALSE;
    
    titleLbl.text=DelegationTitleText;
    
    noDataLbl.text=DelegationNoDataFoundMsg;
    
    
    filterRequestLbl.text=delegationRequestIDText;
    filterUserNameLbl.text=UserUsernameText;
    filterStartDateLbl.text=delegationStartTimeText;
    filterEndDateLbl.text=delegationEndTimeText;
    filterActivateLbl.text=delegationActivateStatusText;
    filterDeActivateLbl.text=delegationDeactivateStatusText;
    
    detailsServiceLbl.text=delegationServiceNameText;
    detailsRequestLbl.text=delegationRequestIDText;
    detailsUserNameLbl.text=UserUsernameText;
    detailsStartDateLbl.text=delegationStartTimeText;
    detailsEndDateLbl.text=delegationEndTimeText;
    detailsStatusLbl.text=delegationActivateStatusText;
    
    
    filterStartDateDayLbl.text = @"--";
    filterStartDateMonthLbl.text = @"--------";
    filterStartDateYearLbl.text = @"----";
    
    filterEndDateDayLbl.text = @"--";
    filterEndDateMonthLbl.text = @"--------";
    filterEndDateYearLbl.text = @"----";
    
    detailsStartDateDayLbl.text = @"--";
    detailsStartDateMonthLbl.text = @"--------";
    detailsStartDateYearLbl.text = @"----";
    
    detailsEndDateDayLbl.text = @"--";
    detailsEndDateMonthLbl.text = @"--------";
    detailsEndDateYearLbl.text = @"----";
    
    selectedDirection = @"";
    
    [filterRequestValTxt setReturnKeyType:UIReturnKeyDone];
    [filterUserNameValTxt setReturnKeyType:UIReturnKeyDone];
    
    [filterActivateBtn setBackgroundImage:[UIImage imageNamed:@"Delegationcheckbox-selected.png"] forState:UIControlStateSelected];
    [filterActivateBtn setBackgroundImage:[UIImage imageNamed:@"Delegationcheckbox-empty.png"] forState:UIControlStateNormal];
    
    [filterDeActivateBtn setBackgroundImage:[UIImage imageNamed:@"Delegationcheckbox-selected.png"] forState:UIControlStateSelected];
    [filterDeActivateBtn setBackgroundImage:[UIImage imageNamed:@"Delegationcheckbox-empty.png"] forState:UIControlStateNormal];
    
    
    [detailsStatusBtn setBackgroundImage:[UIImage imageNamed:@"Delegationcheckbox-selected.png"] forState:UIControlStateSelected];
    [detailsStatusBtn setBackgroundImage:[UIImage imageNamed:@"Delegationcheckbox-empty.png"] forState:UIControlStateNormal];
    
    
    
    [detailsServiceValTxt setReturnKeyType:UIReturnKeyDone];
    [detailsRequestValTxt setReturnKeyType:UIReturnKeyDone];
    [detailsUserNameValTxt setReturnKeyType:UIReturnKeyDone];
    
    
    [filterBackBtn setTitle:BackButtonText forState:UIControlStateNormal];
    [filterListBackBtn setTitle:BackButtonText forState:UIControlStateNormal];
    [filterDoneBtn setTitle:SearchButtonText forState:UIControlStateNormal];
    [filterEmptyBtn setTitle:EmptyButtonText forState:UIControlStateNormal];
    
    
    [detailsBackBtn setTitle:BackButtonText forState:UIControlStateNormal];
    [detailsDoneBtn setTitle:AddButtonText forState:UIControlStateNormal];

    [detailsBackEnglishBtn setTitle:BackButtonText forState:UIControlStateNormal];
    [detailsDoneEnglishBtn setTitle:AddButtonText forState:UIControlStateNormal];
    
    [searchCancelbtn setTitle:BackButtonText forState:UIControlStateNormal];
    [searchChoosebtn setTitle:ChooseButtonText forState:UIControlStateNormal];    
    [searchCancelbtnArabic setTitle:BackButtonText forState:UIControlStateNormal];
    [searchChoosebtnArabic setTitle:ChooseButtonText forState:UIControlStateNormal];
    
    [searchServicesCancelbtn setTitle:BackButtonText forState:UIControlStateNormal];
    [searchServicesChoosebtn setTitle:ChooseButtonText forState:UIControlStateNormal];
    
    
    
    [selectedUserDetailsBackBtn setTitle:BackButtonText forState:UIControlStateNormal];
    
//    selectedUserUserNameLbl.text = UserUsernameText;
//    selectedUserNameLbl.text = UserNameText;
//    selectedUserJobCodeLbl.text = UserJobCodeText;
//    selectedUserJobTitleLbl.text = UserJobTitleText;
    
}

-(void)switchToLeftLayout{
    
    titleLbl.textAlignment=NSTextAlignmentLeft;
    
    filterRequestLbl.textAlignment=NSTextAlignmentLeft;
    filterRequestValTxt.textAlignment=NSTextAlignmentLeft;
    
    filterUserNameLbl.textAlignment=NSTextAlignmentLeft;
    filterUserNameValTxt.textAlignment=NSTextAlignmentLeft;
    
    filterStartDateLbl.textAlignment=NSTextAlignmentLeft;
    filterEndDateLbl.textAlignment=NSTextAlignmentLeft;
    
    filterActivateLbl.textAlignment=NSTextAlignmentLeft;
    filterDeActivateLbl.textAlignment=NSTextAlignmentLeft;
    
    
    CGRect frame = titleLbl.frame;
    frame.origin.x = 8;
    titleLbl.frame = frame;
    
    frame = addBtn.frame;
    frame.origin.x = titleLbl.frame.origin.x + titleLbl.frame.size.width + 8;
    addBtn.frame = frame;
    
    frame = searchBtn.frame;
    frame.origin.x = addBtn.frame.origin.x + addBtn.frame.size.width + 8;
    searchBtn.frame = frame;
    
    
    frame = filterRequestLbl.frame;
    frame.origin.x = 8;
    filterRequestLbl.frame = frame;
    
    frame = filterRequestValView.frame;
    frame.origin.x = filterRequestLbl.frame.origin.x + filterRequestLbl.frame.size.width + 2;
    filterRequestValView.frame = frame;
    
    
    frame = filterUserNameLbl.frame;
    frame.origin.x = 8;
    filterUserNameLbl.frame = frame;
    
    frame = filterUserNameValView.frame;
    frame.origin.x = filterUserNameLbl.frame.origin.x + filterUserNameLbl.frame.size.width + 2;
    filterUserNameValView.frame = frame;
    
    
    frame = filterStartDateLbl.frame;
    frame.origin.x = 8;
    filterStartDateLbl.frame = frame;
    
    frame = filterStartDateView.frame;
    frame.origin.x = filterStartDateLbl.frame.origin.x + filterStartDateLbl.frame.size.width;
    filterStartDateView.frame = frame;
    
    
    frame = filterEndDateLbl.frame;
    frame.origin.x = 8;
    filterEndDateLbl.frame = frame;
    
    frame = filterEndDateView.frame;
    frame.origin.x = filterEndDateLbl.frame.origin.x + filterEndDateLbl.frame.size.width;
    filterEndDateView.frame = frame;
    
    
    frame = filterActivateLbl.frame;
    frame.origin.x = 8;
    filterActivateLbl.frame = frame;
    
    frame = filterActivateBtn.frame;
    frame.origin.x = filterActivateLbl.frame.origin.x + filterActivateLbl.frame.size.width + 2;
    filterActivateBtn.frame = frame;
    
    
    frame = filterDeActivateLbl.frame;
    frame.origin.x = 8;
    filterDeActivateLbl.frame = frame;
    
    frame = filterDeActivateBtn.frame;
    frame.origin.x = filterDeActivateLbl.frame.origin.x + filterDeActivateLbl.frame.size.width + 2;
    filterDeActivateBtn.frame = frame;
}

-(void)switchToLeftLayoutAddView{
    detailsRequestLbl.textAlignment=NSTextAlignmentLeft;
    detailsRequestValTxt.textAlignment=NSTextAlignmentLeft;
    
    detailsServiceLbl.textAlignment=NSTextAlignmentLeft;
    detailsServiceValTxt.textAlignment=NSTextAlignmentLeft;
    
    detailsUserNameLbl.textAlignment=NSTextAlignmentLeft;
    detailsUserNameValTxt.textAlignment=NSTextAlignmentLeft;
    
    detailsStartDateLbl.textAlignment=NSTextAlignmentLeft;
    detailsEndDateLbl.textAlignment=NSTextAlignmentLeft;
    
    detailsStatusLbl.textAlignment=NSTextAlignmentLeft;
    CGRect frame = detailsServiceLbl.frame;
    frame.origin.x = 8;
    detailsServiceLbl.frame = frame;
    
    frame = detailsServiceValView.frame;
    frame.origin.x = detailsServiceLbl.frame.origin.x + detailsServiceLbl.frame.size.width + 2;
    detailsServiceValView.frame = frame;
    
    frame = detailsServiceSearchBtn.frame;
    frame.origin.x = detailsServiceValView.frame.origin.x + detailsServiceValView.frame.size.width + 2;
    detailsServiceSearchBtn.frame = frame;
    
    
    frame = detailsRequestLbl.frame;
    frame.origin.x = 8;
    detailsRequestLbl.frame = frame;
    
    frame = detailsRequestValView.frame;
    frame.origin.x = detailsRequestLbl.frame.origin.x + detailsRequestLbl.frame.size.width + 2;
    detailsRequestValView.frame = frame;
    
    
    frame = detailsUserNameLbl.frame;
    frame.origin.x = 8;
    detailsUserNameLbl.frame = frame;
    
    frame = detailsUserNameValView.frame;
    frame.origin.x = detailsUserNameLbl.frame.origin.x + detailsUserNameLbl.frame.size.width + 2;
    detailsUserNameValView.frame = frame;
    
    frame = detailsUserNameSearchBtn.frame;
    frame.origin.x = detailsUserNameValView.frame.origin.x + detailsUserNameValView.frame.size.width + 2;
    detailsUserNameSearchBtn.frame = frame;
    
    frame = detailsUserNameDetailsBtn.frame;
    frame.origin.x = detailsUserNameSearchBtn.frame.origin.x + detailsUserNameSearchBtn.frame.size.width + 2;
    detailsUserNameDetailsBtn.frame = frame;
    
    
    frame = detailsStartDateLbl.frame;
    frame.origin.x = 8;
    detailsStartDateLbl.frame = frame;
    
    frame = detailsStartDateView.frame;
    frame.origin.x = detailsStartDateLbl.frame.origin.x + detailsStartDateLbl.frame.size.width;
    detailsStartDateView.frame = frame;
    
    
    frame = detailsEndDateLbl.frame;
    frame.origin.x = 8;
    detailsEndDateLbl.frame = frame;
    
    frame = detailsEndDateView.frame;
    frame.origin.x = detailsEndDateLbl.frame.origin.x + detailsEndDateLbl.frame.size.width;
    detailsEndDateView.frame = frame;
    
    
    frame = detailsStatusLbl.frame;
    frame.origin.x = 8;
    detailsStatusLbl.frame = frame;
    
    frame = detailsStatusBtn.frame;
    frame.origin.x = detailsStatusLbl.frame.origin.x + detailsStatusLbl.frame.size.width + 2;
    detailsStatusBtn.frame = frame;
    
}
-(void)switchToRightLayout{
    
    
    filterBackBtn.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    filterBackBtn.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    filterBackBtn.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    
    filterDoneBtn.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    filterDoneBtn.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    filterDoneBtn.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    
    
    filterEmptyBtn.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    filterEmptyBtn.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    filterEmptyBtn.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    
    titleLbl.textAlignment=NSTextAlignmentRight;
    
    
    filterRequestLbl.textAlignment=NSTextAlignmentRight;
    filterRequestValTxt.textAlignment=NSTextAlignmentRight;
    
    filterUserNameLbl.textAlignment=NSTextAlignmentRight;
    filterUserNameValTxt.textAlignment=NSTextAlignmentRight;
    
    filterStartDateLbl.textAlignment=NSTextAlignmentRight;
    filterEndDateLbl.textAlignment=NSTextAlignmentRight;
    
    filterActivateLbl.textAlignment=NSTextAlignmentRight;
    filterDeActivateLbl.textAlignment=NSTextAlignmentRight;
    
    
    CGRect frame = addBtn.frame;
    frame.origin.x = 8;
    addBtn.frame = frame;
    
    frame = searchBtn.frame;
    frame.origin.x = addBtn.frame.origin.x + addBtn.frame.size.width + 8;
    searchBtn.frame = frame;
    
    frame = titleLbl.frame;
    frame.origin.x = searchBtn.frame.origin.x + searchBtn.frame.size.width + 8;
    titleLbl.frame = frame;
    
    frame = filterRequestValView.frame;
    frame.origin.x = 8;
    filterRequestValView.frame = frame;
    
    frame = filterRequestLbl.frame;
    frame.origin.x = filterRequestValView.frame.origin.x + filterRequestValView.frame.size.width + 2;
    filterRequestLbl.frame = frame;
    
    frame = filterUserNameValView.frame;
    frame.origin.x = 8;
    filterUserNameValView.frame = frame;
    
    frame = filterUserNameLbl.frame;
    frame.origin.x = filterUserNameValView.frame.origin.x + filterUserNameValView.frame.size.width + 2;
    filterUserNameLbl.frame = frame;
    
    
    frame = filterStartDateView.frame;
    frame.origin.x = 8;
    filterStartDateView.frame = frame;
    
    frame = filterStartDateLbl.frame;
    frame.origin.x = filterStartDateView.frame.origin.x + filterStartDateView.frame.size.width;
    filterStartDateLbl.frame = frame;
    
    frame = filterEndDateView.frame;
    frame.origin.x = 8;
    filterEndDateView.frame = frame;
    
    frame = filterEndDateLbl.frame;
    frame.origin.x = filterEndDateView.frame.origin.x + filterEndDateView.frame.size.width;
    filterEndDateLbl.frame = frame;
    
    frame = filterActivateLbl.frame;
    frame.origin.x = filterView.frame.size.width - filterActivateLbl.frame.size.width - 8;
    filterActivateLbl.frame = frame;
    
    frame = filterActivateBtn.frame;
    frame.origin.x = filterActivateLbl.frame.origin.x - filterActivateBtn.frame.size.width - 10;
    filterActivateBtn.frame = frame;
    
    frame = filterDeActivateLbl.frame;
    frame.origin.x = filterView.frame.size.width - filterDeActivateLbl.frame.size.width - 8;
    filterDeActivateLbl.frame = frame;
    
    frame = filterDeActivateBtn.frame;
    frame.origin.x = filterDeActivateLbl.frame.origin.x - filterDeActivateBtn.frame.size.width - 10;
    filterDeActivateBtn.frame = frame;
    
    
}
-(void)switchToRightLayoutAddView{
    
    detailsBackBtn.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    detailsBackBtn.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    detailsBackBtn.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    
    detailsDoneBtn.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    detailsDoneBtn.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    detailsDoneBtn.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    
    detailsRequestLbl.textAlignment=NSTextAlignmentRight;
    detailsRequestValTxt.textAlignment=NSTextAlignmentRight;
    
    detailsServiceLbl.textAlignment=NSTextAlignmentRight;
    detailsServiceValTxt.textAlignment=NSTextAlignmentRight;
    
    
    detailsUserNameLbl.textAlignment=NSTextAlignmentRight;
    detailsUserNameValTxt.textAlignment=NSTextAlignmentRight;
    
    detailsStartDateLbl.textAlignment=NSTextAlignmentRight;
    detailsEndDateLbl.textAlignment=NSTextAlignmentRight;
    
    detailsStatusLbl.textAlignment=NSTextAlignmentRight;
    
    
    
    
    CGRect frame = detailsRequestValView.frame;
    frame.origin.x = 8;
    detailsRequestValView.frame = frame;
    
    frame = detailsRequestLbl.frame;
    frame.origin.x = detailsRequestValView.frame.origin.x + detailsRequestValView.frame.size.width + 2;
    detailsRequestLbl.frame = frame;
    
    
    frame = detailsServiceSearchBtn.frame;
    frame.origin.x = 8;
    detailsServiceSearchBtn.frame = frame;
    
    frame = detailsServiceValView.frame;
    frame.origin.x = detailsServiceSearchBtn.frame.origin.x + 2 + detailsServiceSearchBtn.frame.size.width;
    detailsServiceValView.frame = frame;
    
    frame = detailsServiceLbl.frame;
    frame.origin.x = detailsServiceValView.frame.origin.x + 2 + detailsServiceValView.frame.size.width;
    detailsServiceLbl.frame = frame;
    
    
    frame = detailsUserNameDetailsBtn.frame;
    frame.origin.x = 8;
    detailsUserNameDetailsBtn.frame = frame;
    
    frame = detailsUserNameSearchBtn.frame;
    frame.origin.x = detailsUserNameDetailsBtn.frame.origin.x + detailsUserNameDetailsBtn.frame.size.width + 2;
    detailsUserNameSearchBtn.frame = frame;
    
    frame = detailsUserNameValView.frame;
    frame.origin.x = detailsUserNameSearchBtn.frame.origin.x + 2 + detailsUserNameSearchBtn.frame.size.width;
    detailsUserNameValView.frame = frame;
    
    frame = detailsUserNameLbl.frame;
    frame.origin.x = detailsUserNameValView.frame.origin.x + 2 + detailsUserNameValView.frame.size.width;
    detailsUserNameLbl.frame = frame;
    
    
    
    
    frame = detailsStartDateView.frame;
    frame.origin.x = 8;
    detailsStartDateView.frame = frame;
    
    frame = detailsStartDateLbl.frame;
    frame.origin.x = detailsStartDateView.frame.origin.x + detailsStartDateView.frame.size.width;
    detailsStartDateLbl.frame = frame;
    
    frame = detailsEndDateView.frame;
    frame.origin.x = 8;
    detailsEndDateView.frame = frame;
    
    frame = detailsEndDateLbl.frame;
    frame.origin.x = detailsEndDateView.frame.origin.x + detailsEndDateView.frame.size.width;
    detailsEndDateLbl.frame = frame;
    
    
    frame = detailsStatusLbl.frame;
    frame.origin.x = detailsView.frame.size.width - detailsStatusLbl.frame.size.width - 8;
    detailsStatusLbl.frame = frame;
    
    frame = detailsStatusBtn.frame;
    frame.origin.x = detailsStatusLbl.frame.origin.x - detailsStatusBtn.frame.size.width - 10;
    detailsStatusBtn.frame = frame;
    
}
-(void)switchToRightLayoutSearchView{
//    selectedUserDetailsBackBtn.transform = CGAffineTransformMakeScale(-1.0, 1.0);
//    selectedUserDetailsBackBtn.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
//    selectedUserDetailsBackBtn.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
//
//
//    searchServicesCancelbtn.transform = CGAffineTransformMakeScale(-1.0, 1.0);
//    searchServicesCancelbtn.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
//    searchServicesCancelbtn.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
//
//    searchServicesChoosebtn.transform = CGAffineTransformMakeScale(-1.0, 1.0);
//    searchServicesChoosebtn.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
//    searchServicesChoosebtn.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
//
//    searchCancelbtn.transform = CGAffineTransformMakeScale(-1.0, 1.0);
//    searchCancelbtn.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
//    searchCancelbtn.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
//
//    searchChoosebtn.transform = CGAffineTransformMakeScale(-1.0, 1.0);
//    searchChoosebtn.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
//    searchChoosebtn.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
//
}
#pragma mark - touch delegate
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([filterUserNameValTxt isFirstResponder] && [touch view] != filterUserNameValTxt) {
        [filterUserNameValTxt resignFirstResponder];
    }
    if ([filterRequestValTxt isFirstResponder] && [touch view] != filterRequestValTxt) {
        [filterRequestValTxt resignFirstResponder];
    }
    
    
    if ([detailsUserNameValTxt isFirstResponder] && [touch view] != detailsUserNameValTxt) {
        [detailsUserNameValTxt resignFirstResponder];
    }
    if ([detailsRequestValTxt isFirstResponder] && [touch view] != detailsRequestValTxt) {
        [detailsRequestValTxt resignFirstResponder];
    }
    if ([detailsServiceValTxt isFirstResponder] && [touch view] != detailsServiceValTxt) {
        [detailsServiceValTxt resignFirstResponder];
    }

    [super touchesBegan:touches withEvent:event];
}


#pragma mark - alertview delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.currentLang==English){
    
    if (buttonIndex == 1) {
        
        DelegationObj *obj = [[DelegationObj alloc] init];
        obj = [filteredDelegations objectAtIndex:selectedDelegation];
        NSMutableArray *arr = [[NSMutableArray alloc] initWithObjects:[NSString stringWithFormat:@"%li",(long)obj.delegationID], nil];
        [[RequestManager sharedInstance] deleteDelegation:self withDelegationsArr:arr];
        [self showActivityViewer];
        }
    }
    else {
        if (buttonIndex == 0) {
            
            DelegationObj *obj = [[DelegationObj alloc] init];
            obj = [filteredDelegations objectAtIndex:selectedDelegation];
            NSMutableArray *arr = [[NSMutableArray alloc] initWithObjects:[NSString stringWithFormat:@"%li",(long)obj.delegationID], nil];
            [[RequestManager sharedInstance] deleteDelegation:self withDelegationsArr:arr];
            [self showActivityViewer];
        }
    }

}


#pragma mark - methods

-(void)initalizeDateViewTimer
{
    [searchDateView initIslamicDateWithMonths:YES withDay:YES withDelegate:self withMaxDate:FALSE withMinDate:FALSE isForceHijri:NO];
    [detailsDateView initIslamicDateWithMonths:YES withDay:YES withDelegate:self withMaxDate:FALSE withMinDate:YES isForceHijri:NO];
    //[searchDateView initIslamicDateWithMonths:YES withDay:YES withDelegate:nil withMaxDate:FALSE withMinDate:YES isForceHijri:NO];
    
}
-(void)initRefreshControl:(UITableView*)tableView{
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl setTintColor:[UIColor whiteColor]];
    UIColor *color = [UIColor colorWithRed:236.0/255.0 green:236.0/255.0 blue:236.0/255.0 alpha:1];
    [refreshControl setBackgroundColor:color];
    refreshControl.layer.zPosition = tableView.backgroundView.layer.zPosition + 1;
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [tableView addSubview:refreshControl];
}

-(NSDateFormatter *)initilizeDateFormatter:(NSString *)formate
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    if(appDelegate.currentLang==English)
        //english output
        df.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    else
        df.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierIslamicUmmAlQura];
    
    df.dateStyle = NSDateFormatterLongStyle;
    df.dateFormat = formate;
    if(appDelegate.currentLang==English){
        //english output
        df.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    }else if(appDelegate.currentLang==Arabic){
        df.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ar"];
    }
    return df;
}
- (void)longTap:(UILongPressGestureRecognizer *)gesture
{
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        //Get location of the swipe
        CGPoint location = [gesture locationInView:self.delegationTableView];
        
        //Get the corresponding index path within the table view
        NSIndexPath *indexPath = [self.delegationTableView indexPathForRowAtPoint:location];
        
        selectedDelegation = indexPath.row;
        
        
        //Check if index path is valid
        if(indexPath)
        {
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            if(appDelegate.currentLang==English){
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:ApplicationTitleText message:deleteDelegationMsgText delegate:self cancelButtonTitle:CancelButtonText otherButtonTitles:OKayButtonText, nil];
                [alert show];
                
            }
            else {
                
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:ApplicationTitleText message:deleteDelegationMsgText delegate:self cancelButtonTitle:OKayButtonText otherButtonTitles: CancelButtonText, nil];
                [alert show];
            }
//            selectedDelegation = indexPath.row;
//            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:ApplicationTitleText message:deleteDelegationMsgText delegate:self cancelButtonTitle:CancelButtonText otherButtonTitles:OKayButtonText, nil];
//            [alert show];
            
        }
    }
}

-(void)deleteDelegation
{
    DelegationObj *obj=nil;
    obj=[filteredDelegations objectAtIndex:selectedDelegation];
    
    [listOfDelegations removeObject:obj];
    [listOfDelegationsAfterEmpty removeObject:obj];
//
//    [listOfDelegations removeObjectAtIndex:selectedDelegation];
//    [listOfDelegationsAfterEmpty removeObjectAtIndex:selectedDelegation];

    [filteredDelegations removeObjectAtIndex:selectedDelegation];
    [delegationTableView reloadData];
}


-(BOOL)validate{
    
    if ([StaticFuntions isStringEmpty:detailsUserNameValTxt.text]) {
        [StaticFuntions showAlertWithTitle:@"" Message:delegationUserNameMandatoryMsg];
        return NO;
    }
    else if ([detailsStartDateDayLbl.text isEqualToString:@"--"]) {
        [StaticFuntions showAlertWithTitle:@"" Message:delegationStartDateMandatoryMsg];
        return NO;
    }
    else if ([detailsEndDateDayLbl.text isEqualToString:@"--"]) {
        [StaticFuntions showAlertWithTitle:@"" Message:delegationEndDateMandatoryMsg];
        return NO;
    }
    else if ([StaticFuntions isStringEmpty:detailsServiceValTxt.text]) {
        [StaticFuntions showAlertWithTitle:@"" Message:delegationServiceNameMandatoryMsg];
        return NO;
    }
    
    return YES;
}



-(NSString *)concatinateDateStringForWebService:(NSString *)day month:(NSString *)month year:(NSString *)year
{
    NSString *dateStr = @"";
    dateStr = [NSString stringWithFormat:@"%@-%@-%@",month,day,year];
    
    return dateStr;
}

-(NSString *)concatinateDateString:(NSString *)day month:(NSString *)month year:(NSString *)year
{
    NSString *dateStr = @"";
    dateStr = [NSString stringWithFormat:@"%@-%@-%@",year,month,day];
    return dateStr;
}

-(void)hideKeyboard{
    [filterUserNameValTxt resignFirstResponder];
    [filterRequestValTxt resignFirstResponder];
    [detailsUserNameValTxt resignFirstResponder];
    [detailsRequestValTxt resignFirstResponder];
    [detailsServiceValTxt resignFirstResponder];

}
-(void)visable_hideDateControl:(BOOL)hidden{
    
    if (detailsView.hidden == FALSE) {
        
        detailsDateView.hidden=hidden;
    }else{
        
        searchDateView.hidden=hidden;
        filterView.hidden = !hidden;
        
    }
    if (filterView.hidden == YES) {
        backgroundView.hidden=hidden;
    }

}

-(void)connect{
    
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    listOfServices = [StaticFuntions getSavedServicesData];
    
    if ([listOfServices count] > 0) {
        NSMutableArray* arr = [[NSMutableArray alloc] initWithArray:listOfServices];
        [listOfServices removeAllObjects];
        for (int i=0; i<[arr count]; i++) {
            NSMutableDictionary *objDic = [arr objectAtIndex:i];
            ServicesObj *obj = [[ServicesObj alloc] init];
            obj.serviceCode = [objDic objectForKeyedSubscript:serviceCodeMW];
            obj.serviceNameAr = [objDic objectForKeyedSubscript:serviceNameMW];
            obj.serviceNameEn = [objDic objectForKeyedSubscript:serviceNameEnMW];
            [listOfServices addObject:obj];
        }
    }
    
    if ([listOfServices count] > 0) {
        [[RequestManager sharedInstance] getServicesList:self withUsername:appDelegate.EmployeeObj.userName withForceGet:FALSE];
    }
    else{
        [[RequestManager sharedInstance] getServicesList:self withUsername:appDelegate.EmployeeObj.userName withForceGet:YES];
    }
    
    
    [self showActivityViewer];
}





#pragma mark - connection

- (void)processCompleted:(id)data error:(CustomError *)error withService:(NSNumber *)service{
    [self hideActivityViewer];
    if(data!=nil){
        
        if([service intValue]==(int)GetServicesList_WS){
            
            NSMutableArray* arr =(NSMutableArray*)data;
            if ([arr count] > 0) {
                listOfServices = [[NSMutableArray alloc] init];
                for(int i=0;i<[arr count];i++){
                    ServicesObj* obj=[arr objectAtIndex:i];
                    [listOfServices addObject:obj];
                }
                [StaticFuntions createServicesFile:listOfServices];
            }
            
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [[RequestManager sharedInstance] getDelegationsList:self withUsername:appDelegate.EmployeeObj.userName withDelegationID:0 withDirection:@""];
            [self showActivityViewer];
            
        }else if ([service intValue]==(int)GetDelegationsList_WS)
        {
            delegationsCount = [[data objectForKeyedSubscript:delegationsCountMW] integerValue];
            NSMutableArray* arr = [data objectForKeyedSubscript:listMW];
            
            for(int i=0;i<[arr count];i++){
                DelegationObj* obj=[arr objectAtIndex:i];
                
                for (int j=0; j<[listOfServices count]; j++) {
                    ServicesObj *serviceObj = [listOfServices objectAtIndex:j];
                    if ([obj.serviceCode isEqualToString:[NSString stringWithFormat:@"%@",serviceObj.serviceCode]]) {
                        obj.serviceNameAr = serviceObj.serviceNameAr;
                        obj.serviceNameEn = serviceObj.serviceNameEn;
                        break;
                    }
                }
                if ([selectedDirection isEqualToString:@""] || [selectedDirection isEqualToString:@"down"])
                {
                    [listOfDelegations addObject:obj];
                [listOfDelegationsAfterEmpty addObject:obj];
                }

                else if ([selectedDirection isEqualToString:@"up"])
                {
                    [listOfDelegations insertObject:obj atIndex:i];
                    [listOfDelegationsAfterEmpty insertObject:obj atIndex:i];

                }
                    
            }
            
            if ([listOfDelegations count] > 0) {
                if(!filteredDelegations)
                    filteredDelegations=[[NSMutableArray alloc] init];
                [self onPressSearchActions:filterDoneBtn];
            }
            [delegationTableView reloadData];
        }else if ([service intValue]==(int)AddDelegationsList_WS)
        {
            [StaticFuntions showAlertWithTitle:AddDelegationTitleText Message:AddDelegationConfirmationMsg];
            
            NSInteger delegationID = [data integerValue];
            
            editObj.startTime = [self concatinateDateString:[StaticFuntions getDayForDate:startDate forceEnLocale:YES] month:[StaticFuntions getMonthForDate:startDate forceHijri:FALSE] year:[StaticFuntions getYearForDate:startDate forceHijri:FALSE forceEnLocale:YES]];
            
            editObj.startTimeNo = [self concatinateDateString:[StaticFuntions getDayForDate:startDate forceEnLocale:YES] month:[StaticFuntions getMonthNumForDate:startDate] year:[StaticFuntions getYearForDate:startDate forceHijri:FALSE forceEnLocale:YES]];
            
            editObj.endTime = [self concatinateDateString:[StaticFuntions getDayForDate:endDate forceEnLocale:YES] month:[StaticFuntions getMonthForDate:endDate forceHijri:FALSE] year:[StaticFuntions getYearForDate:endDate forceHijri:FALSE forceEnLocale:YES]];
            
            editObj.endTimeNo = [self concatinateDateString:[StaticFuntions getDayForDate:endDate forceEnLocale:YES] month:[StaticFuntions getMonthNumForDate:endDate] year:[StaticFuntions getYearForDate:endDate forceHijri:FALSE forceEnLocale:YES]];
            editObj.delegationID = delegationID;
            
            [listOfDelegationsAfterEmpty insertObject:editObj atIndex:0];
            [listOfDelegations insertObject:editObj atIndex:0];
            
           [self searchEmptyAction];
            [self onPressSearchActions:filterDoneBtn];
            [delegationTableView reloadData];
            
            
            detailsView.hidden = YES;
            titleLbl.text=DelegationTitleText;
            addBtn.hidden = FALSE;
            searchBtn.hidden = FALSE;
            
        }else if ([service intValue]==(int)GetUsersList_WS)
        {
            NSMutableArray* arr =(NSMutableArray*)data;
            if ([arr count] > 0) {
                for(int i=0;i<[arr count];i++){
                    UserObj* obj=[arr objectAtIndex:i];
                    [listOfUsers addObject:obj];
                }
                [self previewListOfUsers];
            }
            else{
                [StaticFuntions showAlertWithTitle:UsersTitleText Message:UsersNotFountMsg];
            }

            
        }else if ([service intValue]==(int)EditDelegationsList_WS)
        {
            [StaticFuntions showAlertWithTitle:EditDelegationTitleText Message:EditDelegationConfirmationMsg];
            
            editObj.startTime = [self concatinateDateString:[StaticFuntions getDayForDate:startDate forceEnLocale:YES] month:[StaticFuntions getMonthForDate:startDate forceHijri:FALSE] year:[StaticFuntions getYearForDate:startDate forceHijri:FALSE forceEnLocale:YES]];
            editObj.endTime = [self concatinateDateString:[StaticFuntions getDayForDate:endDate forceEnLocale:YES] month:[StaticFuntions getMonthForDate:endDate forceHijri:FALSE] year:[StaticFuntions getYearForDate:endDate forceHijri:FALSE forceEnLocale:YES]];
            
            editObj.startTimeNo = [self concatinateDateString:[StaticFuntions getDayForDate:startDate forceEnLocale:YES] month:[StaticFuntions getMonthNumForDate:startDate] year:[StaticFuntions getYearForDate:startDate forceHijri:FALSE forceEnLocale:YES]];
            
            editObj.endTimeNo = [self concatinateDateString:[StaticFuntions getDayForDate:endDate forceEnLocale:YES] month:[StaticFuntions getMonthNumForDate:endDate] year:[StaticFuntions getYearForDate:endDate forceHijri:FALSE forceEnLocale:YES]];
            
            
            [filteredDelegations replaceObjectAtIndex:selectedDelegation withObject:editObj];
            [listOfDelegationsAfterEmpty replaceObjectAtIndex:selectedDelegation withObject:editObj];
            [listOfDelegations replaceObjectAtIndex:selectedDelegation withObject:editObj];

            [delegationTableView reloadData];
            [detailsDoneBtn setTitle:AddButtonText forState:UIControlStateNormal];

            detailsView.hidden = YES;
            titleLbl.text=DelegationTitleText;
            addBtn.hidden = FALSE;
            searchBtn.hidden = FALSE;
            
        }else if ([service intValue]==(int)DeleteDelegationsList_WS)
        {
            [StaticFuntions showAlertWithTitle:DelegationTitleText Message:DeleteDelegationConfirmationMsg];
            [self deleteDelegation];
            
        }
        
    }else{
        
            [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:error.errorMessage];
        
        
    }
}

-(void)previewListOfUsers
{

    [usersTblView reloadData];
    

    userSelectedRow = -1;
    lastSelectedObj = [[UserObj alloc] init];
    detailsUserNameDetailsBtn.enabled = FALSE;
    UserObj *obj;
    for (int i = 0 ; i < [listOfUsers count]; i++) {
        obj = [listOfUsers objectAtIndex:i];
        if ([detailsUserNameValTxt.text isEqualToString:obj.userName]
            || [detailsUserNameValTxt.text isEqualToString:obj.name] ||
            [detailsUserNameValTxt.text isEqualToString:obj.JobCode]) {
            userSelectedRow = i;
            NSLog(@"previewListOfUsers %ld",userSelectedRow);
            lastSelectedObj = [listOfUsers objectAtIndex:userSelectedRow];
            detailsUserNameDetailsBtn.enabled = YES;
            break;
        }
    }
    if (userPreviousrow != -1) {
        NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:userPreviousrow inSection:0];
        [usersTblView deselectRowAtIndexPath:selectedIndexPath animated:NO];
    }
    
    if (userSelectedRow != -1) {
        NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:userSelectedRow inSection:0];
        userPreviousrow = userSelectedRow;
        [usersTblView selectRowAtIndexPath:selectedIndexPath animated:YES  scrollPosition:UITableViewScrollPositionBottom];
    }
    
    usersSearchView.hidden = FALSE;
    backgroundView.hidden = FALSE;
}

-(void)previewListOfServices
{
    [servicesTblView reloadData];
    
    serviceSelectedRowDelegation = -1;
    
    ServicesObj *obj;
    for (int i = 0 ; i < [listOfServices count]; i++) {
        obj = [listOfServices objectAtIndex:i];
        if ([detailsServiceValTxt.text isEqualToString:obj.serviceCode] || ([detailsServiceValTxt.text caseInsensitiveCompare:obj.serviceNameAr] == NSOrderedSame) || ([detailsServiceValTxt.text caseInsensitiveCompare:obj.serviceNameEn] == NSOrderedSame)) {
            serviceSelectedRowDelegation = i;
            break;
        }
    }
    if (servicePreviousRowDelegation != -1) {
        NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:servicePreviousRowDelegation inSection:0];
        [servicesTblView deselectRowAtIndexPath:selectedIndexPath animated:NO];
    }
    
    if (serviceSelectedRowDelegation != -1) {
        NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:serviceSelectedRowDelegation inSection:0];
        servicePreviousRowDelegation = serviceSelectedRowDelegation;
        [servicesTblView selectRowAtIndexPath:selectedIndexPath animated:YES  scrollPosition:UITableViewScrollPositionBottom];
    }
    servicesSearchView.hidden = FALSE;
    backgroundView.hidden = FALSE;
}


#pragma mark - textfield delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == filterRequestValTxt || textField == filterUserNameValTxt)
        searching = YES;
    
    if (textField == detailsServiceValTxt) {
        CGRect frame = controlsView.frame;
        frame.origin.y -= 45;
        controlsView.frame = frame;
    }else if (textField == detailsRequestValTxt) {
        CGRect frame = controlsView.frame;
        frame.origin.y -= 90;
        controlsView.frame = frame;
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == detailsUserNameValTxt)
    {
        UserObj *obj;
        lastSelectedObj = [[UserObj alloc] init];
        detailsUserNameDetailsBtn.enabled = FALSE;
        for (int j=0; j<[listOfUsers count]; j++) {
            obj = [listOfUsers objectAtIndex:j];
            if ([detailsUserNameValTxt.text isEqualToString:obj.userName]) {
                lastSelectedObj = obj;
                detailsUserNameDetailsBtn.enabled = YES;
                break;
            }
        }
    }
    else
    {
        if (textField == detailsServiceValTxt)
        {
            ServicesObj *obj;
            for (int j=0; j<[listOfServices count]; j++) {
                obj = [listOfServices objectAtIndex:j];
                if ([detailsServiceValTxt.text isEqualToString:obj.serviceCode] || ([detailsServiceValTxt.text caseInsensitiveCompare:obj.serviceNameAr] == NSOrderedSame) || ([detailsServiceValTxt.text caseInsensitiveCompare:obj.serviceNameEn] == NSOrderedSame)) {
                    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                    if(appDelegate.currentLang==Arabic)
                        detailsServiceValTxt.text = obj.serviceNameAr;
                    else
                        detailsServiceValTxt.text = obj.serviceNameEn;
                    break;
                }
            }
        }
    }
    
    if (textField == detailsServiceValTxt) {
        CGRect frame = controlsView.frame;
        frame.origin.y += 45;
        controlsView.frame = frame;
    }else if (textField == detailsRequestValTxt) {
        CGRect frame = controlsView.frame;
        frame.origin.y += 90;
        controlsView.frame = frame;
    }
    
}

#pragma mark - table delegate

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return DeleteButtonText;
}

//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
  //  return UITableViewCellEditingStyleDelete;
//}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here for when you hit delete
        selectedDelegation = indexPath.row;
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        if(appDelegate.currentLang==English){
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:ApplicationTitleText message:deleteDelegationMsgText delegate:self cancelButtonTitle:CancelButtonText otherButtonTitles:OKayButtonText, nil];
            [alert show];
            

        }
        else {

            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:ApplicationTitleText message:deleteDelegationMsgText delegate:self cancelButtonTitle:OKayButtonText otherButtonTitles: CancelButtonText, nil];
            [alert show];
        }
        
        
    }
    
}


-(UITableViewCell*) tableView:(UITableView *)tblView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tblView == delegationTableView) {
        static NSString *CellIdentifier=@"DelegationTableViewCell";
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        if(appDelegate.currentLang==English)
            CellIdentifier=@"DelegationTableViewCell_en";
        else
            CellIdentifier=@"DelegationTableViewCell";
        
        DelegationTableViewCell *cell = [self.delegationTableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[DelegationTableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier:CellIdentifier];
        }
        DelegationObj *obj=nil;
        
        //  new a
        obj=[filteredDelegations objectAtIndex:(int)indexPath.row];
        
        
        [cell initWithDelegationObj:obj withRowId:(int)indexPath.row];
        cell.layoutMargins = UIEdgeInsetsZero;
        cell.preservesSuperviewLayoutMargins = NO;
        return cell;
    }
    else if (tblView == usersTblView) {
        static NSString *CellIdentifier=@"UserTableViewCell";
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        if(appDelegate.currentLang==English)
            CellIdentifier=@"UserTableViewCell_en";
        else
            CellIdentifier=@"UserTableViewCell";
        
        UserTableViewCell *cell = [self.usersTblView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        
        if (cell == nil) {
            cell = [[UserTableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        
        UserObj *obj;
        obj=[listOfUsers objectAtIndex:indexPath.row];
        
        [cell initWithUserObj:obj withRowId:(int)indexPath.row];
        
        UIView *bgColorView = [[UIView alloc] init];
        bgColorView.backgroundColor = [UIColor colorWithRed:(206/255.f) green:(206/255.f) blue:(206/255.f) alpha:1.0];
        bgColorView.layer.masksToBounds = YES;
        [cell setSelectedBackgroundView:bgColorView];
        
        return cell;
    }
    else if (tblView == servicesTblView) {
        static NSString *CellIdentifier=@"ServiceTableViewCell";
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        if(appDelegate.currentLang==English)
            CellIdentifier=@"ServiceTableViewCell_en";
        else
            CellIdentifier=@"ServiceTableViewCell";
        
        ServiceTableViewCell *cell = [self.servicesTblView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        
        if (cell == nil) {
            cell = [[ServiceTableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        
        ServicesObj *obj;
        obj=[listOfServices objectAtIndex:indexPath.row];
        
        [cell initWithServicesObj:obj withRowId:(int)indexPath.row];
        
        UIView *bgColorView = [[UIView alloc] init];
        bgColorView.backgroundColor = [UIColor colorWithRed:(206/255.f) green:(206/255.f) blue:(206/255.f) alpha:1.0];
        bgColorView.layer.masksToBounds = YES;
        [cell setSelectedBackgroundView:bgColorView];
        return cell;
    }
    return nil;
    
}

-(NSInteger)tableView:(UITableView *)tblView numberOfRowsInSection:(NSInteger)section{

    if (tblView == delegationTableView) {
        if([filteredDelegations count]==0){
            noDataLbl.hidden=NO;
            noDataImg.hidden=NO;
            return 0;
        }
        noDataLbl.hidden=YES;
        noDataImg.hidden=YES;
        return [filteredDelegations count];
    }
    else if (tblView == usersTblView) {
        return [listOfUsers count];
    }
    else if (tblView == servicesTblView) {
        return [listOfServices count];
    }
    return 0;

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSIndexPath *)tableView:(UITableView *)tblView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath;
}

- (void)tableView:(UITableView *)tblView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self hideKeyboard];
    

    
    if (tblView == delegationTableView) {
        
      
        

        selectedDelegation = indexPath.row;
        detailsView.hidden = FALSE;
        titleLbl.text=EditDelegationTitleText;
        
        [detailsDoneBtn setTitle:EditDelegationButtonText  forState:UIControlStateNormal];
        
        CGRect btnFrame = detailsDoneBtn.frame;
        btnFrame.size.width = 120; // lets the button width is 100 or set according to the need.
        [detailsDoneBtn setFrame:btnFrame];
        
        [detailsDoneEnglishBtn setTitle:EditDelegationButtonText  forState:UIControlStateNormal];
         btnFrame = detailsDoneEnglishBtn.frame;
        btnFrame.size.width = 120; // lets the button width is 100 or set according to the need.
        [detailsDoneEnglishBtn setFrame:btnFrame];
        
        addBtn.hidden = YES;
        searchBtn.hidden = YES;
        
       // [detailsDoneBtn setTitle:EditButtonText forState:UIControlStateNormal];
        
        
        DelegationObj *obj = [listOfDelegations objectAtIndex:indexPath.row];
        
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        if(appDelegate.currentLang==English){
            [self switchToLeftLayoutAddView];
       self.actionviewarabic.hidden=true;
        }
        else{
            [self switchToRightLayoutAddView];
            self.actionviewenglish.hidden=true;

        }
        
        
        if(appDelegate.currentLang==Arabic)
            detailsServiceValTxt.text = obj.serviceNameAr;
        else
            detailsServiceValTxt.text = obj.serviceNameEn;
        if (![obj.requestNo isKindOfClass:[NSNull class]] ){
        detailsRequestValTxt.text = obj.requestNo;
        }
        detailsUserNameValTxt.text = obj.user.userName;
        
        detailsUserNameValTxt.enabled = FALSE;
        detailsServiceValTxt.enabled = FALSE;
        detailsRequestValTxt.enabled = FALSE;
        
        detailsAction = edit;
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        df = [self initilizeDateFormatter:@"yyyy-MM-dd"];
        
        startDate = [df dateFromString:obj.startTimeNo];
        endDate = [df dateFromString:[NSString stringWithFormat:@"%@",obj.endTimeNo]];
        
        
        
        detailsStartDateDayLbl.text = [StaticFuntions getDayForDate:startDate forceEnLocale:FALSE];
        detailsStartDateMonthLbl.text = [StaticFuntions getMonthForDate:startDate forceHijri:FALSE];
        detailsStartDateYearLbl.text = [StaticFuntions getYearForDate:startDate forceHijri:FALSE forceEnLocale:FALSE];
        
        endDate = [df dateFromString:obj.endTimeNo];
        detailsEndDateDayLbl.text = [StaticFuntions getDayForDate:endDate forceEnLocale:FALSE];
        detailsEndDateMonthLbl.text = [StaticFuntions getMonthForDate:endDate forceHijri:FALSE];
        detailsEndDateYearLbl.text = [StaticFuntions getYearForDate:endDate forceHijri:FALSE forceEnLocale:FALSE];
        
        
        
        detailsStatusBtn.selected = obj.status;
        [delegationTableView deselectRowAtIndexPath:indexPath animated:YES];
        
        detailsUserNameDetailsBtn.enabled = FALSE;
        detailsUserNameSearchBtn.enabled = FALSE;
        detailsServiceSearchBtn.enabled = FALSE;
    }
    else if (tblView == usersTblView) {
        if (userPreviousrow != -1 || userPreviousrow != -2) {
            NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:userPreviousrow inSection:0];
            if (indexPath.row != userPreviousrow) {
                userPreviousrow = indexPath.row;
                selectedIndexPath = [NSIndexPath indexPathForRow:userPreviousrow inSection:0];
            }
            else{
                [usersTblView deselectRowAtIndexPath:selectedIndexPath animated:NO];
                userPreviousrow = -2;
            }
        }
        else if (userPreviousrow == -2){
            [usersTblView deselectRowAtIndexPath:indexPath animated:NO];
        }
        if (userPreviousrow != -2 && userPreviousrow != -1) {
            userSelectedRow = indexPath.row;
            lastSelectedObj = [listOfUsers objectAtIndex:userSelectedRow];
            detailsUserNameDetailsBtn.enabled = YES;
        }
        else
        {
            userSelectedRow = -1;
            lastSelectedObj = [[UserObj alloc] init];
            detailsUserNameDetailsBtn.enabled = FALSE;
        }
    }
    else if (tblView == servicesTblView) {
        if (servicePreviousRowDelegation != -1 || servicePreviousRowDelegation != -2) {
            NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:servicePreviousRowDelegation inSection:0];
            if (indexPath.row != servicePreviousRowDelegation) {
                servicePreviousRowDelegation = indexPath.row;
                selectedIndexPath = [NSIndexPath indexPathForRow:servicePreviousRowDelegation inSection:0];
            }
            else{
                [servicesTblView deselectRowAtIndexPath:selectedIndexPath animated:NO];
                servicePreviousRowDelegation = -2;
            }
        }
        else if (servicePreviousRowDelegation == -2){
            [servicesTblView deselectRowAtIndexPath:indexPath animated:NO];
        }
        if (servicePreviousRowDelegation != -2 && servicePreviousRowDelegation != -1)
            serviceSelectedRowDelegation = indexPath.row;
        else
            serviceSelectedRowDelegation = -1;
    }
}


#pragma mark - scroll delegate

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    NSInteger currentypos = targetContentOffset->y;
    
    
    if (searching == FALSE) {
        if ((scrollView.contentSize.height - scrollView.frame.size.height) > 0) {
            if (currentypos >= (scrollView.contentSize.height - (delegationTableView.frame.size.height)))
            {
                BOOL scrolled = FALSE;
                DelegationObj *obj;
                if (delegationsCount > [listOfDelegations count]) {
                    noDataLbl.hidden=YES;
                    scrolled = YES;
                    obj = [listOfDelegations lastObject];
                }
                if (scrolled) {
                    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                    
                    selectedDirection = @"down";
                    [[RequestManager sharedInstance] getDelegationsList:self withUsername:appDelegate.EmployeeObj.userName withDelegationID:obj.delegationID withDirection:selectedDirection];
                }
                
            }
        }
        else{
            if(listOfDelegations.count == 0)
            noDataLbl.hidden=NO;

        }
    }
    
    
}

#pragma mark - date delegate

-(void)onSelectDate:(NSDate*)selectedDate{
    
    if(selectedDate==nil)
    {
        [self visable_hideDateControl:YES];
        return;
    }
    BOOL done = FALSE;
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    
    df = [self initilizeDateFormatter:@"yyyy-MM-dd"];
    NSString *dateStr;
    //have to be changed
    if ([targetDateView isEqualToString:@"SearchStartDate"] || [targetDateView isEqualToString:@"SearchEndDate"]) {
        if ([targetDateView isEqualToString:@"SearchStartDate"]) {
            startDate=selectedDate;
            
            if (![filterEndDateDayLbl.text isEqualToString:@"--"]) {
                dateStr = [self concatinateDateString:filterEndDateDayLbl.text month:filterEndDateMonthLbl.text year:filterEndDateYearLbl.text];
                
                endDate = [df dateFromString:dateStr];
            }
            else
            {
                done = YES;
            }
        }
        else if ([targetDateView isEqualToString:@"SearchEndDate"]) {
            endDate=selectedDate;
            
            if (![filterStartDateDayLbl.text isEqualToString:@"--"]) {
                dateStr = [self concatinateDateString:filterStartDateDayLbl.text month:filterStartDateMonthLbl.text year:filterStartDateYearLbl.text];
                
                startDate = [df dateFromString:dateStr];
            }
            else
            {
                done = YES;
            }
        }
        
        
        if (!done) {
            NSTimeInterval secondsBetween = [endDate timeIntervalSinceDate:startDate];
            int numberOfDays = secondsBetween / 86400;
            if (numberOfDays >= 0) {
                
                done = YES;
            }
        }
        
        
        if (done) {
            if ([targetDateView isEqualToString:@"SearchStartDate"]) {
                filterStartDateYearLbl.text=[StaticFuntions getYearForDate:selectedDate forceHijri:FALSE forceEnLocale:FALSE];
                filterStartDateMonthLbl.text=[StaticFuntions getMonthForDate:selectedDate forceHijri:FALSE];
                filterStartDateDayLbl.text=[StaticFuntions getDayForDate:selectedDate forceEnLocale:FALSE];
            }
            else if ([targetDateView isEqualToString:@"SearchEndDate"]) {
                filterEndDateYearLbl.text=[StaticFuntions getYearForDate:selectedDate forceHijri:FALSE forceEnLocale:FALSE];
                filterEndDateMonthLbl.text=[StaticFuntions getMonthForDate:selectedDate forceHijri:FALSE];
                filterEndDateDayLbl.text=[StaticFuntions getDayForDate:selectedDate forceEnLocale:FALSE];
            }
            searching = YES;
        }
    }
    else if ([targetDateView isEqualToString:@"AddStartDate"] || [targetDateView isEqualToString:@"AddEndDate"]) {
        if ([targetDateView isEqualToString:@"AddStartDate"]) {
            startDate=selectedDate;
            
            if (![detailsEndDateDayLbl.text isEqualToString:@"--"]) {
                dateStr = [self concatinateDateString:detailsEndDateDayLbl.text month:detailsEndDateMonthLbl.text year:detailsEndDateYearLbl.text];
                
                endDate = [df dateFromString:dateStr];
            }
            else
            {
                done = YES;
            }
        }
        else if ([targetDateView isEqualToString:@"AddEndDate"]) {
            endDate=selectedDate;
            
            if (![detailsStartDateDayLbl.text isEqualToString:@"--"]) {
                dateStr = [self concatinateDateString:detailsStartDateDayLbl.text month:detailsStartDateMonthLbl.text year:detailsStartDateYearLbl.text];
                
                startDate = [df dateFromString:dateStr];
            }
            else
            {
                done = YES;
            }
        }
        
        
        if (!done) {
            NSTimeInterval secondsBetween = [endDate timeIntervalSinceDate:startDate];
            int numberOfDays = secondsBetween / 86400;
            if (numberOfDays >= 0) {
                
                done = YES;
            }
        }
        
        
        if (done) {
            if ([targetDateView isEqualToString:@"AddStartDate"]) {
                detailsStartDateYearLbl.text=[StaticFuntions getYearForDate:selectedDate forceHijri:FALSE forceEnLocale:FALSE];
                detailsStartDateMonthLbl.text=[StaticFuntions getMonthForDate:selectedDate forceHijri:FALSE];
                detailsStartDateDayLbl.text=[StaticFuntions getDayForDate:selectedDate forceEnLocale:FALSE];
            }
            else if ([targetDateView isEqualToString:@"AddEndDate"]) {
                detailsEndDateYearLbl.text=[StaticFuntions getYearForDate:selectedDate forceHijri:FALSE forceEnLocale:FALSE];
                detailsEndDateMonthLbl.text=[StaticFuntions getMonthForDate:selectedDate forceHijri:FALSE];
                detailsEndDateDayLbl.text=[StaticFuntions getDayForDate:selectedDate forceEnLocale:FALSE];
            }
        }
    }
    
    
    if (done) {
        [self visable_hideDateControl:YES];
    }
    else
    {
        [StaticFuntions showAlertWithTitle:@"" Message:validateDateError];
    }

    
}

#pragma mark - events

-(IBAction)onPressSearch:(id)sender
{
    
    if (sender == searchBtn) {
        backgroundView.hidden = FALSE;
        filterView.hidden = FALSE;
        
        addBtn.hidden = YES;
        searchBtn.hidden = YES;
        
    }

    [self hideKeyboard];
    
}

-(IBAction)onPressSearchActions:(id)sender
{
    if (sender == filterActivateBtn) {
        if (filterActivateBtn.selected == YES) {
            filterActivateBtn.selected = FALSE;
            filterChangeSearchStatus = @"0";
        }
        else {
            filterActivateBtn.selected = YES;
            filterChangeSearchStatus = @"1";
        }
        if (filterActivateBtn.selected !=filterDeActivateBtn.selected) {
            searching = YES;
            
        }
        
    }
    else if (sender == filterDeActivateBtn) {
        if (filterDeActivateBtn.selected == YES) {
            filterDeActivateBtn.selected = FALSE;
            filterChangeSearchStatus = @"0";
        }
        else {
            filterDeActivateBtn.selected = YES;
            filterChangeSearchStatus = @"1";
        }
        if (filterActivateBtn.selected !=filterDeActivateBtn.selected) {
            searching = YES;
            
        }
    }
    else if (sender == filterBackBtn)
    {
        
         [self searchBackAction];
        
    }
    else if (sender == filterBackBtnEnglish)
    {
        [self searchBackAction];
        
    }
    else if (sender == filterEmptyBtn)
    {
       [self searchEmptyAction];
    }
    else if (sender == filterEmptyBtnEnglish)
    {
        [self searchEmptyAction];
    }
    
    else if (sender == filterDoneBtnEnglish)
    {
        
        
        if([self isNetworkAvailable] ==YES)
        {
            NSLog(@"Network Connection available");
            [self searchDoneAction];
        }
        
        else{
            [StaticFuntions showAlertWithTitle:NetWorkTitle Message:NetWorkBody];
            
        }
        
    }
    else if (sender == filterDoneBtn)
    {
        if([self isNetworkAvailable] ==YES)
        {
            NSLog(@"Network Connection available");
            [self searchDoneAction];
        }
        
        else{
            [StaticFuntions showAlertWithTitle:NetWorkTitle Message:NetWorkBody];
            
        }
    }
    else if (sender == filterListBackBtn)
    {
        searching = FALSE;
        filterRequestValTxt.text = @"";
        filterUserNameValTxt.text = @"";
        
        filterStartDateDayLbl.text = @"--";
        filterStartDateMonthLbl.text = @"--------";
        filterStartDateYearLbl.text = @"----";
        
        filterEndDateDayLbl.text = @"--";
        filterEndDateMonthLbl.text = @"--------";
        filterEndDateYearLbl.text = @"----";
        filterActivateBtn.selected = YES;
        filterDeActivateBtn.selected = YES;
        
        if ([listOfDelegations count] > 0) {
            filteredDelegations = [[NSMutableArray alloc] initWithArray:listOfDelegations];
            [delegationTableView reloadData];
        }
        filterListBackBtn.hidden = YES;
        CGRect frame = delegationTableView.frame;
        frame.size.height += 60;
        delegationTableView.frame = frame;
        filterChangeSearchStatus = @"-1";
    }

    
    [self hideKeyboard];
    
}

-(IBAction)onPressAdd:(id)sender
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (sender == addBtn) {
        [detailsDoneBtn setTitle:AddButtonText forState:UIControlStateNormal];
        [detailsDoneEnglishBtn setTitle:AddButtonText  forState:UIControlStateNormal];
        if(appDelegate.currentLang==English)
            [self switchToLeftLayoutAddView];
        else
            [self switchToRightLayoutAddView];

        detailsUserNameSearchBtn.enabled = YES;
        detailsServiceSearchBtn.enabled = YES;
        detailsUserNameDetailsBtn.enabled = FALSE;
        detailsView.hidden = FALSE;
        titleLbl.text=AddDelegationTitleText;
        addBtn.hidden = YES;
        searchBtn.hidden = YES;
        
        detailsUserNameValTxt.enabled = YES;
        detailsServiceValTxt.enabled = YES;
        detailsRequestValTxt.enabled = YES;
        
        
        detailsServiceValTxt.text = @"";
        detailsRequestValTxt.text = @"";
        detailsUserNameValTxt.text = @"";
        
        detailsStartDateDayLbl.text = @"--";
        detailsStartDateMonthLbl.text = @"--------";
        detailsStartDateYearLbl.text = @"----";
        
        detailsEndDateDayLbl.text = @"--";
        detailsEndDateMonthLbl.text = @"--------";
        detailsEndDateYearLbl.text = @"----";
        
        detailsStatusBtn.selected = FALSE;
        detailsAction = add;
    }
    else if (sender == detailsBackBtn)
    {
        detailsView.hidden = YES;
        titleLbl.text=DelegationTitleText;
        addBtn.hidden = FALSE;
        searchBtn.hidden = FALSE;
        
    }
    else if (sender == detailsBackEnglishBtn)
    {
        detailsView.hidden = YES;
        titleLbl.text=DelegationTitleText;
        addBtn.hidden = FALSE;
        searchBtn.hidden = FALSE;
    }
    else if (sender == detailsStatusBtn)
    {
        if (detailsStatusBtn.selected) {
            detailsStatusBtn.selected = FALSE;
        }
        else
        {
            detailsStatusBtn.selected = YES;
        }
    }
    else if (sender == detailsDoneBtn)
    {
       
        [self doneDetails ];
    }
    else if (sender == detailsDoneEnglishBtn)
    {
        
        [self doneDetails ];
    }
    [self hideKeyboard];
}

-(void)doneDetails{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    if([self validate])
    {
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        
        df = [self initilizeDateFormatter:@"yyyy-MM-dd"];
        NSString *dateStr;
        
        dateStr = [self concatinateDateString:detailsStartDateDayLbl.text month:detailsStartDateMonthLbl.text year:detailsStartDateYearLbl.text];
        startDate = [df dateFromString:dateStr];
        
        dateStr = [self concatinateDateString:detailsEndDateDayLbl.text month:detailsEndDateMonthLbl.text year:detailsEndDateYearLbl.text];
        endDate = [df dateFromString:dateStr];
        
        if (detailsAction == edit) {
            
            DelegationObj *tempObj = [listOfDelegations objectAtIndex:selectedDelegation];
            editObj = [[DelegationObj alloc] init];
            
            
            [editObj initWithDelegationObj:tempObj.delegationID withUser:tempObj.user withStartTime:tempObj.startTime withEndTime:tempObj.endTime withServiceCode:tempObj.serviceCode withServiceNameAr:tempObj.serviceNameAr withServiceNameEn:tempObj.serviceNameEn withStatus:tempObj.status withRequestNo:tempObj.requestNo];
            
            if([StaticFuntions isStringEmpty:detailsRequestValTxt.text]){
                editObj.requestNo = @"";
            }
            
            editObj.startTime = [self concatinateDateStringForWebService:[StaticFuntions getGregorianDayNumForWebService:startDate] month:[StaticFuntions getGregorianMonthNumForWebService:startDate] year:[StaticFuntions getGregorianYearNumForWebService:startDate]];
            editObj.endTime = [self concatinateDateStringForWebService:[StaticFuntions getGregorianDayNumForWebService:endDate] month:[StaticFuntions getGregorianMonthNumForWebService:endDate] year:[StaticFuntions getGregorianYearNumForWebService:endDate]];
            editObj.status = detailsStatusBtn.selected;
            
            if([self isNetworkAvailable] ==YES)
            {
                NSLog(@"Network Connection available");
                
                [[RequestManager sharedInstance] editDelegation:self withDelegationObj:editObj];
                [self showActivityViewer];
                
            }
            
            else{
                [StaticFuntions showAlertWithTitle:NetWorkTitle Message:NetWorkBody];
                
            }
            
            
            
        }
        else
        {

            
            editObj = [[DelegationObj alloc] init];
            editObj.user = [[UserObj alloc] init];
            
            if([StaticFuntions isStringEmpty:detailsRequestValTxt.text])
                editObj.requestNo = @"";
            else
                editObj.requestNo = detailsRequestValTxt.text;
            
            editObj.user.userName = detailsUserNameValTxt.text;
            editObj.startTime = [self concatinateDateStringForWebService:[StaticFuntions getGregorianDayNumForWebService:startDate] month:[StaticFuntions getGregorianMonthNumForWebService:startDate] year:[StaticFuntions getGregorianYearNumForWebService:startDate]];
            editObj.endTime = [self concatinateDateStringForWebService:[StaticFuntions getGregorianDayNumForWebService:endDate] month:[StaticFuntions getGregorianMonthNumForWebService:endDate] year:[StaticFuntions getGregorianYearNumForWebService:endDate]];
            editObj.status = detailsStatusBtn.selected;
            
            
            BOOL found = FALSE;
            
            for (int i=0; i<[listOfServices count]; i++) {
                ServicesObj *obj = [[ServicesObj alloc] init];
                
                obj = [listOfServices objectAtIndex:i];
                if(appDelegate.currentLang==English)
                {
                    if ([detailsServiceValTxt.text caseInsensitiveCompare:obj.serviceNameEn] == NSOrderedSame) {
                        found = YES;
                        editObj.serviceCode = obj.serviceCode;
                        editObj.serviceNameAr = obj.serviceNameAr;
                        editObj.serviceNameEn = obj.serviceNameEn;
                        break;
                    }
                }
                else if(appDelegate.currentLang==Arabic)
                {
                    if ([detailsServiceValTxt.text caseInsensitiveCompare:obj.serviceNameAr] == NSOrderedSame) {
                        found = YES;
                        editObj.serviceCode = obj.serviceCode;
                        editObj.serviceNameAr = obj.serviceNameAr;
                        editObj.serviceNameEn = obj.serviceNameEn;
                        break;
                    }
                }
            }
            if (found) {
                
                if([self isNetworkAvailable] ==YES)
                {
                    NSLog(@"Network Connection available");
                    [[RequestManager sharedInstance] addDelegation:self withDelegationObj:editObj];
                    [self showActivityViewer];                }
                
                else{
                    [StaticFuntions showAlertWithTitle:NetWorkTitle Message:NetWorkBody];
                    
                }
                
                
              
            }
            else
            {
                [StaticFuntions showAlertWithTitle:ServicesTitleText Message:ServicesNotFountMsg];
            }
            
            
        }
    }
    
    
}

-(IBAction)onPressSearchUserActions:(id)sender{
    [self hideKeyboard];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    if (sender == detailsUserNameSearchBtn) {
        if([self isNetworkAvailable] ==YES)
        {
            
       
        if(appDelegate.currentLang==Arabic)
            [self switchToRightLayoutSearchView];
        
        
        if ([StaticFuntions isStringEmpty:detailsUserNameValTxt.text]) {
            [StaticFuntions showAlertWithTitle:@"" Message:delegationUserNameMandatoryMsg];
        }
        else if ([detailsUserNameValTxt.text length] < 3){
            [StaticFuntions showAlertWithTitle:@"" Message:delegationUserNameMinCharsMsg];
        }
        else
        {
            // show details
          //  selectedUserDetailsView.hidden=  false;
            
            if (![lastUserSearchVal isEqualToString:detailsUserNameValTxt.text]) {
                
                BOOL found = FALSE;
                if ([listOfUsers count] > 0) {
                    UserObj *obj;
                    for (int i=0; i<[listOfUsers count]; i++) {
                        obj = [listOfUsers objectAtIndex:i];
                        if ([obj.userName isEqualToString:detailsUserNameValTxt.text]) {
                            found = YES;
                            [self previewListOfUsers];
                            break;
                        }
                    }
                }
                if (!found) {
                    listOfUsers = [[NSMutableArray alloc] init];
                    lastUserSearchVal = detailsUserNameValTxt.text;
                    [[RequestManager sharedInstance] GetUsersList:self withFilterStr:lastUserSearchVal];
                    [self showActivityViewer];
                }

            }
            else
            {
                if ([listOfUsers count] > 0) {
                    [self previewListOfUsers];
                }
                else
                {
                    [StaticFuntions showAlertWithTitle:UsersTitleText Message:UsersNotFountMsg];
                }
                
            }
            
        }
            
        }
        
        else{
            [StaticFuntions showAlertWithTitle:NetWorkTitle Message:NetWorkBody];
            
        }
    }
    else if (sender == searchCancelbtn){
        usersSearchView.hidden = YES;
        backgroundView.hidden = YES;
    }
    else if (sender == searchCancelUserbtn ){
        usersSearchView.hidden = YES;
        backgroundView.hidden = YES;
    }
    else if (sender == searchChoosebtn)
    {
        [self pressChoose ];
    }
    else if (sender == searchChooseUserbtn)
    {
       [self pressChoose ];
    }
    
    else if (sender == detailsUserNameDetailsBtn){
        if ([StaticFuntions isStringEmpty:detailsUserNameValTxt.text]) {
            [StaticFuntions showAlertWithTitle:@"" Message:delegationUserNameMandatoryMsg];
        }
        else if (lastSelectedObj.userName == nil) {
            [StaticFuntions showAlertWithTitle:@"" Message:loadUserDataErrorMsg];
        }
        else
        {
            backgroundView.hidden = FALSE;
            selectedUserDetailsView.hidden = false;
            searchDateView.hidden=  true ;
            searchViewArabic.hidden= true;
            searchViewArabic.hidden= true;
            servicesSearchView.hidden=true;
            usersSearchView.hidden= true;
            
            if(appDelegate.currentLang==Arabic){
                selectedUserUserNameVal.text = [self concatenateString : UserUsernameText value :lastSelectedObj.userName];
                selectedUserNameVal.text = [self concatenateString : UserNameText value :lastSelectedObj.name];
                selectedUserJobCodeVal.text = [self concatenateString : UserJobCodeText value :lastSelectedObj.JobCode];
                selectedUserJobTitleVal.text = [self concatenateString : UserJobTitleText value :lastSelectedObj.JobTitle] ;
 
            }else{
                selectedUserUserNameVal.textAlignment =  NSTextAlignmentLeft;
                selectedUserNameVal.textAlignment =  NSTextAlignmentLeft;
                selectedUserJobCodeVal.textAlignment =  NSTextAlignmentLeft;
                selectedUserJobTitleVal.textAlignment =  NSTextAlignmentLeft;
                selectedUserUserNameVal.text = [self concatenateString : UserUsernameText value :lastSelectedObj.userName];
                selectedUserNameVal.text = [self concatenateString : UserNameText value :lastSelectedObj.name];
                selectedUserJobCodeVal.text = [self concatenateString : UserJobCodeText value :lastSelectedObj.JobCode];
                selectedUserJobTitleVal.text = [self concatenateString : UserJobTitleText value :lastSelectedObj.JobTitle] ;
                
            }
           
            
        }
    }
    else if (sender == selectedUserDetailsBackBtn){
        backgroundView.hidden = YES;
        selectedUserDetailsView.hidden = YES;
    }
}


- (NSString*)concatenateString :(NSString*)title value:(NSString *)value
{
    NSString *allvalue;
    allvalue  =  [NSString stringWithFormat:@"%@%@%@",title, @" : ",value];
    
    return  allvalue;
}

-(IBAction)onPressSearchServicesActions:(id)sender{
    [self hideKeyboard];
    
    if (sender == detailsServiceSearchBtn) {
        
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        if(appDelegate.currentLang==Arabic)
            [self switchToRightLayoutSearchView];

        [self previewListOfServices];
    }
    else if (sender == searchServicesCancelbtn){
        servicesSearchView.hidden = YES;
        backgroundView.hidden = YES;
        
    }
    else if (sender == searchCancelbtnArabic){
        servicesSearchView.hidden = YES;
        backgroundView.hidden = YES;
    }
    else if (sender == searchServicesChoosebtn)
    {
        [ self chooseUserPress ];
    }
    else if (sender == searchChoosebtnArabic)
    {
        [ self chooseUserPress ];
    }
}

-(void) chooseUserPress{
    if (serviceSelectedRowDelegation == -1)
        [StaticFuntions showAlertWithTitle:@"" Message:delegationServiceNameMandatoryMsg];
    else
    {
        self.backgroundView.hidden = YES;
        self.servicesSearchView.hidden = YES;
        ServicesObj *obj;
        obj = [listOfServices objectAtIndex:serviceSelectedRowDelegation];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        if(appDelegate.currentLang==English)
            detailsServiceValTxt.text = obj.serviceNameEn;
        else if(appDelegate.currentLang==Arabic)
            detailsServiceValTxt.text = obj.serviceNameAr;
    }
}

-(IBAction)onselectdatePressed:(id)sender{
    
    
    
    NSString *stringDate;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df = [self initilizeDateFormatter:@"yyyy-MM-dd"];
    
    BOOL firstTime = YES;
    
    if (sender == filterStartDateChangeBtn1 || sender == filterStartDateChangeBtn2) {
        targetDateView = @"SearchStartDate";
        if (![filterStartDateYearLbl.text isEqualToString:@"----"]) {
            stringDate = [self concatinateDateString:filterStartDateDayLbl.text month:filterStartDateMonthLbl.text year:filterStartDateYearLbl.text];
            firstTime = FALSE;
        }
        
    }
    else if (sender == filterEndDateChangeBtn1 || sender == filterEndDateChangeBtn2) {
        targetDateView = @"SearchEndDate";
        if (![filterEndDateYearLbl.text isEqualToString:@"----"]) {
            stringDate = [self concatinateDateString:filterEndDateDayLbl.text month:filterEndDateMonthLbl.text year:filterEndDateYearLbl.text];
            firstTime = FALSE;
        }
    }
    else if (sender == detailsStartDateChangeBtn1 || sender == detailsStartDateChangeBtn2) {
        targetDateView = @"AddStartDate";
        if (![detailsStartDateYearLbl.text isEqualToString:@"----"]) {
            stringDate = [self concatinateDateString:detailsStartDateDayLbl.text month:detailsStartDateMonthLbl.text year:detailsStartDateYearLbl.text];
            
            firstTime = FALSE;
        }
    }
    else if (sender == detailsEndDateChangeBtn1 || sender == detailsEndDateChangeBtn2) {
        targetDateView = @"AddEndDate";
        if (![detailsEndDateYearLbl.text isEqualToString:@"----"]) {
            stringDate = [self concatinateDateString:detailsEndDateDayLbl.text month:detailsEndDateMonthLbl.text year:detailsEndDateYearLbl.text];
            firstTime = FALSE;
        }
    }
    
    
    // Convert string to date object
    
    
    if (!firstTime) {
        startDate = [df dateFromString:stringDate];
        if (filterView.hidden == FALSE)
            [searchDateView.picker setDate:startDate];
        else
            [detailsDateView.picker setDate:startDate];
        
    }
    else
    {
        startDate = [NSDate date];//[df dateFromString:stringDate];
        if (filterView.hidden == FALSE)
            [searchDateView.picker setDate:startDate];
        else
            [detailsDateView.picker setDate:startDate];
    }
    
    [self visable_hideDateControl:NO];
    [self hideKeyboard];
}

#pragma mark - refresh

- (void)refresh:(UIRefreshControl *)refreshControl_ {
    if (searching == FALSE) {
        noDataLbl.hidden=YES;
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        DelegationObj *obj;
        if ([filteredDelegations count] > 0) {
            obj = [filteredDelegations objectAtIndex:0];
            selectedDirection = @"up";
            [[RequestManager sharedInstance] getDelegationsList:self withUsername:appDelegate.EmployeeObj.userName withDelegationID:obj.delegationID withDirection:selectedDirection];
            [self showActivityViewer];
        }
    }
    

    [refreshControl endRefreshing];
}
-(void)searchDoneAction{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df = [self initilizeDateFormatter:@"yyyy-MM-dd"];
    NSString *dateStr;
    
    [filteredDelegations removeAllObjects];
    
    NSMutableArray *removedObjects = [[NSMutableArray alloc] init];
    filteredDelegations = [[NSMutableArray alloc] initWithArray:listOfDelegationsAfterEmpty];
    DelegationObj *obj;
    if(![StaticFuntions isStringEmpty:filterRequestValTxt.text]){
        
        for (int i =0 ; i< [filteredDelegations count]; i++) {
            obj = [filteredDelegations objectAtIndex:i];
            if (![obj.requestNo isEqualToString:filterRequestValTxt.text]) {
                [removedObjects addObject:[filteredDelegations objectAtIndex:i]];
            }
            
            
        }
        [filteredDelegations removeObjectsInArray:removedObjects];
    }
    
    if ([filteredDelegations count] > 0) {
        if(![StaticFuntions isStringEmpty:filterUserNameValTxt.text]){
            
            for (int i =0 ; i< [filteredDelegations count]; i++) {
                obj = [filteredDelegations objectAtIndex:i];
                if ([obj.user.userName rangeOfString:filterUserNameValTxt.text].location == NSNotFound) {
                    [removedObjects addObject:[filteredDelegations objectAtIndex:i]];
                }
            }
            [filteredDelegations removeObjectsInArray:removedObjects];
        }
    }
    
    if ([filteredDelegations count] > 0) {
        if(![filterStartDateDayLbl.text isEqualToString:@"--"] && [filterEndDateDayLbl.text isEqualToString:@"--"]){
            removedObjects = [[NSMutableArray alloc] init];
            dateStr = [self concatinateDateString:filterStartDateDayLbl.text month:filterStartDateMonthLbl.text year:filterStartDateYearLbl.text];
            
            startDate = [df dateFromString:dateStr];
            
            NSTimeInterval secondsBetween;
            int numberOfDays;
            
            for (int i =0 ; i< [filteredDelegations count]; i++) {
                obj = [filteredDelegations objectAtIndex:i];
                NSDate *objDate = [df dateFromString:obj.startTimeNo];
                secondsBetween = [objDate timeIntervalSinceDate:startDate];
                numberOfDays = secondsBetween / 86400;
                if (numberOfDays < 0)
                    [removedObjects addObject:[filteredDelegations objectAtIndex:i]];
            }
            [filteredDelegations removeObjectsInArray:removedObjects];
            
        }
    }
    if ([filteredDelegations count] > 0) {
        if(![filterEndDateDayLbl.text isEqualToString:@"--"] && [filterStartDateDayLbl.text isEqualToString:@"--"]){
            removedObjects = [[NSMutableArray alloc] init];
            dateStr = [self concatinateDateString:filterEndDateDayLbl.text month:filterEndDateMonthLbl.text year:filterEndDateYearLbl.text];
            
            endDate = [df dateFromString:dateStr];
            
            NSTimeInterval secondsBetween;
            int numberOfDays;
            
            for (int i =0 ; i< [filteredDelegations count]; i++) {
                obj = [filteredDelegations objectAtIndex:i];
                NSDate *objDate = [df dateFromString:obj.endTimeNo];
                secondsBetween = [objDate timeIntervalSinceDate:endDate];
                numberOfDays = secondsBetween / 86400;
                if (numberOfDays > 0)
                    [removedObjects addObject:[filteredDelegations objectAtIndex:i]];
            }
            [filteredDelegations removeObjectsInArray:removedObjects];
            
        }
    }
    
    if ([filteredDelegations count] > 0) {
        if(![filterStartDateDayLbl.text isEqualToString:@"--"] && ![filterEndDateDayLbl.text isEqualToString:@"--"]){
            removedObjects = [[NSMutableArray alloc] init];
            dateStr = [self concatinateDateString:filterStartDateDayLbl.text month:filterStartDateMonthLbl.text year:filterStartDateYearLbl.text];
            startDate = [df dateFromString:dateStr];
            
            dateStr = [self concatinateDateString:filterEndDateDayLbl.text month:filterEndDateMonthLbl.text year:filterEndDateYearLbl.text];
            endDate = [df dateFromString:dateStr];
            
            NSTimeInterval secondsBetween;
            int numberOfDays;
            NSDate *objStartDate;
            NSDate *objEndDate;
            for (int i =0 ; i< [filteredDelegations count]; i++) {
                obj = [filteredDelegations objectAtIndex:i];
                objStartDate = [df dateFromString:obj.startTimeNo];
                objEndDate = [df dateFromString:obj.endTimeNo];
                secondsBetween = [objStartDate timeIntervalSinceDate:startDate];
                numberOfDays = secondsBetween / 86400;
                if (numberOfDays < 0)
                    [removedObjects addObject:[filteredDelegations objectAtIndex:i]];
                else{
                    secondsBetween = [objEndDate timeIntervalSinceDate:endDate];
                    numberOfDays = secondsBetween / 86400;
                    if (numberOfDays > 0)
                        [removedObjects addObject:[filteredDelegations objectAtIndex:i]];
                }
            }
            [filteredDelegations removeObjectsInArray:removedObjects];
            
        }
    }
    
//    if ([filteredDelegations count] > 0) {
//
//        removedObjects = [[NSMutableArray alloc] init];
//        //remove active objects
//        if (!filterActivateBtn.selected) {
//            for (int i =0 ; i< [filteredDelegations count]; i++) {
//                obj = [filteredDelegations objectAtIndex:i];
//                if (obj.status == YES) {
//                    [removedObjects addObject:[filteredDelegations objectAtIndex:i]];
//                }
//            }
//        }
//        //remove deactivated objects
//        if (!filterDeActivateBtn.selected) {
//            for (int i =0 ; i< [filteredDelegations count]; i++) {
//                obj = [filteredDelegations objectAtIndex:i];
//                if (obj.status == FALSE) {
//                    [removedObjects addObject:[filteredDelegations objectAtIndex:i]];
//                }
//            }
//        }
//        [filteredDelegations removeObjectsInArray:removedObjects];
//    }
    
    
    
    if ([filteredDelegations count] > 0) {
        
        removedObjects = [[NSMutableArray alloc] init];
        //remove active objects
        if (!filterActivateBtn.selected) {
            for (int i =0 ; i< [filteredDelegations count]; i++) {
                obj = [filteredDelegations objectAtIndex:i];
                if (obj.status == YES) {
                    [removedObjects addObject:[filteredDelegations objectAtIndex:i]];
                }
            }
        }
        //remove deactivated objects
        if (!filterDeActivateBtn.selected) {
            for (int i =0 ; i< [filteredDelegations count]; i++) {
                obj = [filteredDelegations objectAtIndex:i];
                if (obj.status == FALSE) {
                    [removedObjects addObject:[filteredDelegations objectAtIndex:i]];
                }
            }
        }
        [filteredDelegations removeObjectsInArray:removedObjects];
    }
    
    if ([filteredDelegations count] > 0) {
        backgroundView.hidden = YES;
        filterView.hidden = YES;
        addBtn.hidden = FALSE;
        searchBtn.hidden = FALSE;
        [delegationTableView reloadData];
        if (searching) {
            //first time search
            if (filterListBackBtn.hidden) {
                CGRect frame = delegationTableView.frame;
                frame.size.height -= 60;
                delegationTableView.frame = frame;
                filterListBackBtn.hidden = FALSE;
            }
        }
    }
    else
    {
        [StaticFuntions showAlertWithTitle:@"" Message:NoDelegationsError];
    }
}
-(void) searchEmptyAction{
    searching = FALSE;
    filterRequestValTxt.text = @"";
    filterUserNameValTxt.text = @"";
    
    filterStartDateDayLbl.text = @"--";
    filterStartDateMonthLbl.text = @"--------";
    filterStartDateYearLbl.text = @"----";
    
    filterEndDateDayLbl.text = @"--";
    filterEndDateMonthLbl.text = @"--------";
    filterEndDateYearLbl.text = @"----";
    filterChangeSearchStatus = @"-1";
  //  filteredDelegations=  listOfDelegationsAfterEmpty;
    filterDeActivateBtn.selected = YES;
    filterActivateBtn.selected = YES;
    

}
-(void) searchBackAction{
    backgroundView.hidden = YES;
    filterView.hidden = YES;
    
    addBtn.hidden = FALSE;
    searchBtn.hidden = FALSE;
    
    [self searchEmptyAction];
    
//    filteredDelegations = [[NSMutableArray alloc] initWithArray:listOfDelegationsAfterEmpty];
//        [delegationTableView reloadData];

    
  //  if ([filterEndDateDayLbl.text isEqualToString:@"--"]) {
        filteredDelegations = [[NSMutableArray alloc] initWithArray:listOfDelegations];
        [delegationTableView reloadData];
   // }
    
   
}


-(void) pressChoose{
    if (userSelectedRow == -1)
        [StaticFuntions showAlertWithTitle:@"" Message:UserSearchErrorText];
    else
    {
        self.backgroundView.hidden = YES;
        self.usersSearchView.hidden = YES;
        
        UserObj *obj;
        obj = [listOfUsers objectAtIndex:userSelectedRow];
        detailsUserNameValTxt.text = obj.userName;
        
    }
}
@end
