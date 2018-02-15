//
//  RequestViewController.h
//  KSU_Students
//
//  Created by EJ-Mac book on 8/2/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "BaseViewController.h"
#import "DataTransfer.h"
#import "RequestObj.h"
#import "HijriDateView.h"



@interface RequestsViewController :  BaseViewController<UITextFieldDelegate,DataTransferDelegate,UITableViewDataSource,UITableViewDelegate>{
    UILabel *titleLbl;
    UIButton *searchBtn;
    
    UIButton *myRequestsBackgroundBtn;
    UIButton *myRequestsBtn;
    UIView *myRequestsView;
    UILabel *myRequestsLbl;
    UIButton *processedRequestsBackgroundBtn;
    UIButton *processedRequestsBtn;
    UIView *processedRequestsView;
    UILabel *processedRequestsLbl;
    UIButton *recievedRequestsBackgroundBtn;
    UIButton *recievedRequestsBtn;
    UIView *recievedRequestsView;
    UILabel *recievedRequestsLbl;
    UIButton *completedRequestsBackgroundBtn;
    UIButton *completedRequestsBtn;
    UIView *completedRequestsView;
    UILabel *completedRequestsLbl;
    
    UITableView *requestTableView;
    UIButton *filterListBackBtn;
    UIView *controlsView;
    
    UIView *actionviewarabic;
    UIView *actionviewEnglish;
    
    NSString *selectedDirection;
    RequestsType selectedType;
    NSString *selectedRequest;
    NSInteger myRequestsCount;
    NSInteger recievedCount;
    NSInteger completedCount;
    NSInteger processedCount;
    NSInteger searchCount;
    NSMutableArray *myRequestsArr;
    NSMutableArray *recievedRequestsArr;
    NSMutableArray *processedRequestsArr;
    NSMutableArray *completedRequestsArr;
    NSMutableArray *filteredRequests;
    NSMutableArray *listOfServices;
    BOOL searching;
    
    
    UIView *backgroundView;
    UIView *searchView;
    UILabel *serviceLbl;
    
    UIView *serviceValView;
    UITextField *serviceValTxt;
    UIButton *serviceSearchBtn;
    UILabel *senderLbl;
    UIView *senderValView;
    UITextField *senderValTxt;
    UIView *startDateView;
    UILabel *startDateLbl;
    UIButton *startDateChangeBtn1;
    UIButton *startDateChangeBtn2;
    UILabel *startDateDayLbl;
    UILabel *startDateMonthLbl;
    UILabel *startDateYearLbl;
    UIView *endDateView;
    UILabel *endDateLbl;
    UIButton *endDateChangeBtn1;
    UIButton *endDateChangeBtn2;
    UILabel *endDateDayLbl;
    UILabel *endDateMonthLbl;
    UILabel *endDateYearLbl;
    UILabel *requestLbl;
    UIView *requestValView;
    UITextField *requestValTxt;
    UIButton *emptyBtn;
    UIButton *doneBtn;
    UIButton *backBtn;
    UIButton *emptyBtnEnglish;
    UIButton *doneBtnEnglish;
    UIButton *backBtnEnglish;
    
    UIView *servicesSearchView;
    UITableView *servicesTblView;
    UIButton *searchServicesCancelbtn;
    UIButton *searchServicesChoosebtn;
    UIButton *searchServicesCancelbtnEng;
    UIButton *searchServicesChoosebtnEng;
    UIView *searchChooseArabic;
    UIView *searchChooseEnglish;
    UIImageView * noDataImg;
    
    NSString *targetDateView;
    HijriDateView *dateView;
    NSDate *startDate;
    NSDate *endDate;
    
    
}
@property (nonatomic,retain)IBOutlet UIView *searchChooseArabic;
@property (nonatomic,retain) IBOutlet UIView *searchChooseEnglish;
@property(nonatomic,retain) IBOutlet UIView *actionviewArabic;
@property(nonatomic,retain) IBOutlet UIView *actionviewEnglish;

@property(nonatomic,retain) IBOutlet UILabel *titleLbl;
@property(nonatomic,retain) IBOutlet UIButton *searchBtn;

@property(nonatomic,retain) IBOutlet UIButton *myRequestsBackgroundBtn;
@property(nonatomic,retain) IBOutlet UIButton *myRequestsBtn;
@property(nonatomic,retain) IBOutlet UIView *myRequestsView;
@property(nonatomic,retain) IBOutlet UILabel *myRequestsLbl;
@property(nonatomic,retain) IBOutlet UIButton *processedRequestsBackgroundBtn;
@property(nonatomic,retain) IBOutlet UIButton *processedRequestsBtn;
@property(nonatomic,retain) IBOutlet UIView *processedRequestsView;
@property(nonatomic,retain) IBOutlet UILabel *processedRequestsLbl;
@property(nonatomic,retain) IBOutlet UIButton *recievedRequestsBackgroundBtn;
@property(nonatomic,retain) IBOutlet UIButton *recievedRequestsBtn;
@property(nonatomic,retain) IBOutlet UIView *recievedRequestsView;
@property(nonatomic,retain) IBOutlet UILabel *recievedRequestsLbl;
@property(nonatomic,retain) IBOutlet UIButton *completedRequestsBackgroundBtn;
@property(nonatomic,retain) IBOutlet UIButton *completedRequestsBtn;
@property(nonatomic,retain) IBOutlet UIView *completedRequestsView;
@property(nonatomic,retain) IBOutlet UILabel *completedRequestsLbl;

@property(nonatomic,retain) IBOutlet UITableView *requestTableView;
@property(nonatomic,retain) IBOutlet UIButton *filterListBackBtn;
@property(nonatomic,retain) IBOutlet UIView *controlsView;

@property(nonatomic,retain) NSString *selectedDirection;
@property (nonatomic) RequestsType selectedType;
@property(nonatomic,retain) NSString *selectedRequest;
@property (nonatomic) NSInteger myRequestsCount;
@property (nonatomic) NSInteger searchCount;
@property (nonatomic) NSInteger recievedCount;
@property (nonatomic) NSInteger completedCount;
@property (nonatomic) NSInteger processedCount;
@property(nonatomic,retain) NSMutableArray *myRequestsArr;
@property(nonatomic,retain) NSMutableArray *recievedRequestsArr;
@property(nonatomic,retain) NSMutableArray *processedRequestsArr;
@property(nonatomic,retain) NSMutableArray *completedRequestsArr;
@property(nonatomic,retain) NSMutableArray *filteredRequests;
@property(nonatomic,retain) NSMutableArray *listOfServices;
@property(nonatomic) BOOL searching;

@property(nonatomic,retain) IBOutlet UIView *backgroundView;
@property(nonatomic,retain) IBOutlet UIView *searchView;
@property(nonatomic,retain) IBOutlet UILabel *serviceLbl;
@property(nonatomic,retain) IBOutlet UIView *serviceValView;
@property(nonatomic,retain) IBOutlet UITextField *serviceValTxt;
@property(nonatomic,retain) IBOutlet UIButton *serviceSearchBtn;
@property(nonatomic,retain) IBOutlet UILabel *senderLbl;
@property(nonatomic,retain) IBOutlet UIView *senderValView;
@property(nonatomic,retain) IBOutlet UITextField *senderValTxt;
@property(nonatomic,retain) IBOutlet UIView *startDateView;
@property(nonatomic,retain) IBOutlet UILabel *startDateLbl;
@property(nonatomic,retain) IBOutlet UIButton *startDateChangeBtn1;
@property(nonatomic,retain) IBOutlet UIButton *startDateChangeBtn2;
@property(nonatomic,retain) IBOutlet UILabel *startDateDayLbl;
@property(nonatomic,retain) IBOutlet UILabel *startDateMonthLbl;
@property(nonatomic,retain) IBOutlet UILabel *startDateYearLbl;
@property(nonatomic,retain) IBOutlet UIView *endDateView;
@property(nonatomic,retain) IBOutlet UILabel *endDateLbl;
@property(nonatomic,retain) IBOutlet UIButton *endDateChangeBtn1;
@property(nonatomic,retain) IBOutlet UIButton *endDateChangeBtn2;
@property(nonatomic,retain) IBOutlet UILabel *endDateDayLbl;
@property(nonatomic,retain) IBOutlet UILabel *endDateMonthLbl;
@property(nonatomic,retain) IBOutlet UILabel *endDateYearLbl;
@property(nonatomic,retain) IBOutlet UILabel *requestLbl;
@property(nonatomic,retain) IBOutlet UIView *requestValView;
@property(nonatomic,retain) IBOutlet UITextField *requestValTxt;
@property(nonatomic,retain) IBOutlet UIButton *emptyBtn;
@property(nonatomic,retain) IBOutlet UIButton *doneBtn;
@property(nonatomic,retain) IBOutlet UIButton *backBtn;
@property(nonatomic,retain) IBOutlet UIButton *emptyBtnEnglish;
@property(nonatomic,retain) IBOutlet UIButton *doneBtnEnglish;
@property(nonatomic,retain) IBOutlet UIButton *backBtnEnglish;

@property(nonatomic,retain) IBOutlet UIView *servicesSearchView;
@property(nonatomic,retain) IBOutlet UITableView *servicesTblView;
@property(nonatomic,retain) IBOutlet UIButton *searchServicesCancelbtn;
@property(nonatomic,retain) IBOutlet UIButton *searchServicesChoosebtn;

@property(nonatomic,retain) IBOutlet UIButton *searchServicesCancelbtnEng;
@property(nonatomic,retain) IBOutlet UIButton *searchServicesChoosebtnEng;

@property(nonatomic,retain) IBOutlet UIImageView * noDataImg;

@property(nonatomic,retain) NSString *targetDateView;
@property(nonatomic,retain) IBOutlet HijriDateView *dateView;
@property(nonatomic,retain) NSDate *startDate;
@property(nonatomic,retain) NSDate *endDate;


-(IBAction)onPressType:(id)sender;
-(IBAction)onPressSearch:(id)sender;
-(IBAction)onPressSearchActions:(id)sender;
-(IBAction)onselectdatePressed:(id)sender;
-(IBAction)onPressActions:(id)sender;
@end
