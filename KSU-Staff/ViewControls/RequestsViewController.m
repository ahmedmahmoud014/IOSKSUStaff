//
//  RequestsViewController.m
//  KSU_Students
//
//  Created by EJ-Mac book on 8/2/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "RequestsViewController.h"
#import "RequestActionsViewController.h"
#import "RequestDetailsViewController.h"
#import "AppDelegate.h"
#import "LocalizedMessages.h"
#import "StaticFuntions.h"
#import "RequestsTableViewCell.h"
#import "ServiceTableViewCell.h"
#import "RequestManager.h"
#import "RequestFilterObj.h"

@interface RequestsViewController ()

@end
@implementation RequestsViewController

@synthesize titleLbl;
@synthesize searchBtn;
@synthesize  myRequestsBackgroundBtn,myRequestsBtn,myRequestsView,myRequestsLbl,processedRequestsBackgroundBtn,processedRequestsBtn,processedRequestsView,processedRequestsLbl,recievedRequestsBackgroundBtn,recievedRequestsBtn,recievedRequestsView,recievedRequestsLbl,completedRequestsBackgroundBtn,completedRequestsBtn,completedRequestsView,completedRequestsLbl;

@synthesize requestTableView;
@synthesize filterListBackBtn;
@synthesize controlsView;
@synthesize selectedDirection,selectedRequest,selectedType,myRequestsCount,recievedCount,completedCount,processedCount,searchCount,myRequestsArr,recievedRequestsArr,processedRequestsArr,completedRequestsArr,filteredRequests,listOfServices,searching;

@synthesize backgroundView;
@synthesize searchView,serviceLbl,serviceValView,serviceValTxt,serviceSearchBtn,senderLbl,senderValView,senderValTxt,startDateView,startDateLbl,startDateChangeBtn1,startDateChangeBtn2,startDateDayLbl,startDateMonthLbl,startDateYearLbl,endDateView,endDateLbl,endDateChangeBtn1,endDateChangeBtn2,endDateDayLbl,endDateMonthLbl,endDateYearLbl,requestLbl,requestValView,requestValTxt,emptyBtn,doneBtn,backBtn,actionviewEnglish,backBtnEnglish,doneBtnEnglish,emptyBtnEnglish,actionviewArabic;

@synthesize noDataImg;
@synthesize targetDateView,dateView;
@synthesize startDate, endDate;
@synthesize servicesSearchView,servicesTblView,searchServicesCancelbtn,searchServicesChoosebtn,searchServicesCancelbtnEng,searchServicesChoosebtnEng,searchChooseArabic,searchChooseEnglish;

NSInteger serviceSelectedRowRequests;
NSInteger servicePreviousRowRequests;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customizeNavigationBar:YES WithMenu:YES];
    /*if(IS_IPAD){
     int x= (self.view.frame.size.width- controlsView.frame.size.width)/2;
     controlsView.frame=CGRectMake(x, controlsView.frame.origin.y, controlsView.frame.size.width, controlsView.frame.size.height);
     }*/
    requestTableView.layoutMargins = UIEdgeInsetsZero;
    if ([requestTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [requestTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    self.servicesTblView.allowsSelection = YES;
    self.servicesTblView.allowsSelectionDuringEditing = YES;

    [dateView toolbarAlignment];

    [self initRefreshControl:requestTableView];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.currentLang==English){
        actionviewArabic.hidden=true;
        searchChooseArabic.hidden=true;
    }else {
        actionviewEnglish.hidden=true;
        searchChooseEnglish.hidden=true;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == requestValTxt) {
        CGRect frame = searchView.frame;
        frame.origin.y -= 45;
        searchView.frame = frame;
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == serviceValTxt)
    {
        ServicesObj *obj;
        for (int j=0; j<[listOfServices count]; j++) {
            obj = [listOfServices objectAtIndex:j];
            if ([serviceValTxt.text isEqualToString:obj.serviceCode] || ([obj.serviceNameAr rangeOfString:serviceValTxt.text options:NSCaseInsensitiveSearch].location != NSNotFound) || ([obj.serviceNameEn rangeOfString:serviceValTxt.text options:NSCaseInsensitiveSearch].location != NSNotFound)) {
                AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                if(appDelegate.currentLang==Arabic)
                    serviceValTxt.text = obj.serviceNameAr;
                else
                    serviceValTxt.text = obj.serviceNameEn;
                break;
            }
        }
    }
    
    if (textField == requestValTxt) {
        CGRect frame = searchView.frame;
        frame.origin.y += 45;
        searchView.frame = frame;
    }
    
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
    
    filterListBackBtn.hidden = YES;
    
    
    [NSTimer scheduledTimerWithTimeInterval:0.000002f target:self selector:@selector(initalizeViewsTimer) userInfo:nil repeats:FALSE];
    
    myRequestsArr = [[NSMutableArray alloc] init];
    recievedRequestsArr = [[NSMutableArray alloc] init];
    processedRequestsArr = [[NSMutableArray alloc] init];
    completedRequestsArr = [[NSMutableArray alloc] init];
    listOfServices = [[NSMutableArray alloc] init];
    
    
    [myRequestsBackgroundBtn setBackgroundImage:[UIImage imageNamed:@"usernameBar.png"] forState:UIControlStateSelected];
    [myRequestsBackgroundBtn setBackgroundImage:[UIImage imageNamed:@"login.png"] forState:UIControlStateNormal];
    
    [processedRequestsBackgroundBtn setBackgroundImage:[UIImage imageNamed:@"usernameBar.png"] forState:UIControlStateSelected];
    [processedRequestsBackgroundBtn setBackgroundImage:[UIImage imageNamed:@"login.png"] forState:UIControlStateNormal];
    
    [recievedRequestsBackgroundBtn setBackgroundImage:[UIImage imageNamed:@"usernameBar.png"] forState:UIControlStateSelected];
    [recievedRequestsBackgroundBtn setBackgroundImage:[UIImage imageNamed:@"login.png"] forState:UIControlStateNormal];
    
    [completedRequestsBackgroundBtn setBackgroundImage:[UIImage imageNamed:@"usernameBar.png"] forState:UIControlStateSelected];
    [completedRequestsBackgroundBtn setBackgroundImage:[UIImage imageNamed:@"login.png"] forState:UIControlStateNormal];
    myRequestsBtn.selected = YES;
    myRequestsBackgroundBtn.selected = YES;
    recievedRequestsBtn.selected = FALSE;
    recievedRequestsBackgroundBtn.selected = FALSE;
    completedRequestsBtn.selected = FALSE;
    completedRequestsBackgroundBtn.selected = FALSE;
    processedRequestsBtn.selected = FALSE;
    processedRequestsBackgroundBtn.selected = FALSE;
    
    noDataLbl.hidden=YES;
    noDataImg.hidden=YES;
    
    dateView.hidden=YES;
    searchView.hidden = YES;
    //
    

    if([self isNetworkAvailable] ==YES)
    {
        NSLog(@"Network Connection available");
        [self loadServices];
    }
    
    else{
        [StaticFuntions showAlertWithTitle:NetWorkTitle Message:NetWorkBody];
        
    }

}

-(void)locatizeLables{
   
    titleLbl.text=MyRequestsButtonText;
    
    noDataLbl.text=RequestNoDataFoundMsg;
    serviceLbl.text=RequestServiceNameText;
    senderLbl.text=RequestSenderNameText;
    startDateLbl.text=RequestStartTimeText;
    endDateLbl.text=RequestEndTimeText;
    requestLbl.text=RequestIDText;

    
    startDateDayLbl.text = @"--";
    startDateMonthLbl.text = @"--------";
    startDateYearLbl.text = @"----";
    
    endDateDayLbl.text = @"--";
    endDateMonthLbl.text = @"--------";
    endDateYearLbl.text = @"----";
    
    selectedDirection = @"";
    selectedRequest = @"";
    
    
    [filterListBackBtn setTitle:BackButtonText forState:UIControlStateNormal];
    [backBtn setTitle:BackButtonText forState:UIControlStateNormal];
    [doneBtn setTitle:SearchButtonText forState:UIControlStateNormal];
    [emptyBtn setTitle:EmptyButtonText forState:UIControlStateNormal];
    [backBtnEnglish setTitle:BackButtonText forState:UIControlStateNormal];
    [doneBtnEnglish setTitle:SearchButtonText forState:UIControlStateNormal];
    [emptyBtnEnglish setTitle:EmptyButtonText forState:UIControlStateNormal];
    UIColor *color = [UIColor colorWithRed:130.0/255.0 green:139.0/255.0 blue:147.0/255.0 alpha:1];
    //serviceValTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:ChPwOldPwText attributes:@{NSForegroundColorAttributeName:color}];
    senderValTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:UserFieldsText attributes:@{NSForegroundColorAttributeName:color}];
    
    [myRequestsBtn setTitle:MyRequestsButtonText forState:UIControlStateNormal];
    [processedRequestsBtn setTitle:ProcessedRequestsButtonText forState:UIControlStateNormal];
    [recievedRequestsBtn setTitle:RecievedRequestsButtonText forState:UIControlStateNormal];
    [completedRequestsBtn setTitle:CompletedRequestsButtonText forState:UIControlStateNormal];
    
    myRequestsBtn.titleLabel.numberOfLines = 2;
    myRequestsBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    myRequestsBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    processedRequestsBtn.titleLabel.numberOfLines = 2;
    processedRequestsBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    processedRequestsBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    recievedRequestsBtn.titleLabel.numberOfLines = 2;
    recievedRequestsBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    recievedRequestsBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    completedRequestsBtn.titleLabel.numberOfLines = 2;
    completedRequestsBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    completedRequestsBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    startDate=[NSDate date];
    endDate=[NSDate date];
    targetDateView = @"";
    
    [searchServicesCancelbtn setTitle:BackButtonText forState:UIControlStateNormal];
    [searchServicesChoosebtn setTitle:ChooseButtonText forState:UIControlStateNormal];
    [searchServicesCancelbtnEng setTitle:BackButtonText forState:UIControlStateNormal];
    [searchServicesChoosebtnEng setTitle:ChooseButtonText forState:UIControlStateNormal];
    
}

-(void)switchToLeftLayout{
    
    titleLbl.textAlignment=NSTextAlignmentLeft;
    
    CGRect frame = titleLbl.frame;
    frame.origin.x = 8;
    titleLbl.frame = frame;
    
    frame = searchBtn.frame;
    frame.origin.x = titleLbl.frame.origin.x + titleLbl.frame.size.width + 8;
    searchBtn.frame = frame;
    
    
    frame = myRequestsBtn.frame;
    frame.origin.x = 0;
    myRequestsBtn.frame = frame;
    
    frame = myRequestsBackgroundBtn.frame;
    frame.origin.x = 0;
    myRequestsBackgroundBtn.frame = frame;
    
    frame = myRequestsView.frame;
    frame.origin.x = myRequestsBtn.frame.origin.x + (myRequestsBtn.frame.size.width / 3);
    myRequestsView.frame = frame;
    frame = recievedRequestsBtn.frame;
    frame.origin.x = myRequestsBtn.frame.origin.x + myRequestsBtn.frame.size.width + 1;
    recievedRequestsBtn.frame = frame;
    
    frame = recievedRequestsBackgroundBtn.frame;
    frame.origin.x = myRequestsBtn.frame.origin.x + myRequestsBtn.frame.size.width + 1;
    recievedRequestsBackgroundBtn.frame = frame;
    frame = recievedRequestsView.frame;
    frame.origin.x = recievedRequestsBtn.frame.origin.x + (recievedRequestsBtn.frame.size.width / 3);
    recievedRequestsView.frame = frame;
    
    frame = completedRequestsBtn.frame;
    frame.origin.x = recievedRequestsBtn.frame.origin.x + recievedRequestsBtn.frame.size.width + 1;
    completedRequestsBtn.frame = frame;
    
    frame = completedRequestsBackgroundBtn.frame;
    frame.origin.x = recievedRequestsBtn.frame.origin.x + recievedRequestsBtn.frame.size.width + 1;
    completedRequestsBackgroundBtn.frame = frame;
    frame = completedRequestsView.frame;
    frame.origin.x = completedRequestsBtn.frame.origin.x + (completedRequestsBtn.frame.size.width/3);
    completedRequestsView.frame = frame;
    frame = processedRequestsBtn.frame;
    frame.origin.x = completedRequestsBtn.frame.origin.x + completedRequestsBtn.frame.size.width + 1;
    processedRequestsBtn.frame = frame;
    
    frame = processedRequestsBackgroundBtn.frame;
    frame.origin.x = completedRequestsBtn.frame.origin.x + completedRequestsBtn.frame.size.width + 1;
    processedRequestsBackgroundBtn.frame = frame;
    
    frame = processedRequestsView.frame;
    frame.origin.x = processedRequestsBtn.frame.origin.x + (processedRequestsBtn.frame.size.width/3);
    processedRequestsView.frame = frame;
    
    
}

-(void)switchToLeftLayoutSearchView{
    requestLbl.textAlignment=NSTextAlignmentLeft;
    requestValTxt.textAlignment=NSTextAlignmentLeft;
    
    serviceLbl.textAlignment=NSTextAlignmentLeft;
    serviceValTxt.textAlignment=NSTextAlignmentLeft;
    
    senderLbl.textAlignment=NSTextAlignmentLeft;
    senderValTxt.textAlignment=NSTextAlignmentLeft;
    
    startDateLbl.textAlignment=NSTextAlignmentLeft;
    endDateLbl.textAlignment=NSTextAlignmentLeft;
    
    CGRect frame = requestLbl.frame;
    frame.origin.x = 8;
    requestLbl.frame = frame;
    
    frame = requestValView.frame;
    frame.origin.x = requestLbl.frame.origin.x + requestLbl.frame.size.width + 2;
    requestValView.frame = frame;
    
    frame = senderLbl.frame;
    frame.origin.x = 8;
    senderLbl.frame = frame;
    
    frame = senderValView.frame;
    frame.origin.x = senderLbl.frame.origin.x + senderLbl.frame.size.width + 2;
    senderValView.frame = frame;
    
    frame = serviceLbl.frame;
    frame.origin.x = 8;
    serviceLbl.frame = frame;
    
    frame = serviceValView.frame;
    frame.origin.x = serviceLbl.frame.origin.x + serviceLbl.frame.size.width + 2;
    serviceValView.frame = frame;
    
    frame = serviceSearchBtn.frame;
    frame.origin.x = serviceValView.frame.origin.x + serviceValView.frame.size.width + 2;
    serviceSearchBtn.frame = frame;
    
    
    
    
    
    frame = startDateLbl.frame;
    frame.origin.x = 8;
    startDateLbl.frame = frame;
    
    frame = startDateView.frame;
    frame.origin.x = startDateLbl.frame.origin.x + startDateLbl.frame.size.width;
    startDateView.frame = frame;
    frame = endDateLbl.frame;
    frame.origin.x = 8;
    endDateLbl.frame = frame;
    
    frame = endDateView.frame;
    frame.origin.x = endDateLbl.frame.origin.x + endDateLbl.frame.size.width;
    endDateView.frame = frame;
    
    
}

-(void)switchToRightLayout{
    
    titleLbl.textAlignment=NSTextAlignmentRight;
    
    CGRect frame = searchBtn.frame;
    frame.origin.x = 8;
    searchBtn.frame = frame;
    
    frame = titleLbl.frame;
    frame.origin.x = searchBtn.frame.origin.x + searchBtn.frame.size.width + 8;
    titleLbl.frame = frame;
    
    frame = processedRequestsBtn.frame;
    frame.origin.x = 0;
    processedRequestsBtn.frame = frame;
    
    frame = processedRequestsBackgroundBtn.frame;
    frame.origin.x = 0;
    processedRequestsBackgroundBtn.frame = frame;
    frame = processedRequestsView.frame;
    frame.origin.x = processedRequestsBtn.frame.origin.x + (processedRequestsBtn.frame.size.width / 3);
    processedRequestsView.frame = frame;
    
    frame = completedRequestsBtn.frame;
    frame.origin.x = processedRequestsBtn.frame.origin.x + processedRequestsBtn.frame.size.width + 1;
    completedRequestsBtn.frame = frame;
    
    frame = completedRequestsBackgroundBtn.frame;
    frame.origin.x = processedRequestsBtn.frame.origin.x + processedRequestsBtn.frame.size.width + 1;
    completedRequestsBackgroundBtn.frame = frame;
    frame = completedRequestsView.frame;
    frame.origin.x = completedRequestsBtn.frame.origin.x + (completedRequestsBtn.frame.size.width / 3);
    completedRequestsView.frame = frame;
    
    frame = recievedRequestsBtn.frame;
    frame.origin.x = completedRequestsBtn.frame.origin.x + completedRequestsBtn.frame.size.width + 1;
    recievedRequestsBtn.frame = frame;
    
    frame = recievedRequestsBackgroundBtn.frame;
    frame.origin.x = completedRequestsBtn.frame.origin.x + completedRequestsBtn.frame.size.width + 1;
    recievedRequestsBackgroundBtn.frame = frame;
    frame = recievedRequestsView.frame;
    frame.origin.x = recievedRequestsBtn.frame.origin.x + (recievedRequestsBtn.frame.size.width / 3);
    recievedRequestsView.frame = frame;
    
    frame = myRequestsBtn.frame;
    frame.origin.x = recievedRequestsBtn.frame.origin.x + recievedRequestsBtn.frame.size.width + 1;
    myRequestsBtn.frame = frame;
    
    frame = myRequestsBackgroundBtn.frame;
    frame.origin.x = recievedRequestsBtn.frame.origin.x + recievedRequestsBtn.frame.size.width + 1;
    myRequestsBackgroundBtn.frame = frame;
    frame = myRequestsView.frame;
    frame.origin.x = myRequestsBtn.frame.origin.x + (myRequestsBtn.frame.size.width / 3);
    myRequestsView.frame = frame;
    
}

-(void)switchToRightLayoutSearchView{
    backBtn.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    backBtn.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    backBtn.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    
    doneBtn.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    doneBtn.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    doneBtn.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    
    emptyBtn.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    emptyBtn.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    emptyBtn.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    
    requestLbl.textAlignment=NSTextAlignmentRight;
    requestValTxt.textAlignment=NSTextAlignmentRight;
    
    
    serviceLbl.textAlignment=NSTextAlignmentRight;
    serviceValTxt.textAlignment=NSTextAlignmentRight;
    
    senderLbl.textAlignment=NSTextAlignmentRight;
    senderValTxt.textAlignment=NSTextAlignmentRight;
    
    startDateLbl.textAlignment=NSTextAlignmentRight;
    endDateLbl.textAlignment=NSTextAlignmentRight;
    
    
    CGRect frame = requestValView.frame;
    frame.origin.x = 8;
    requestValView.frame = frame;
    
    frame = requestLbl.frame;
    frame.origin.x = requestValView.frame.origin.x + requestValView.frame.size.width + 2;
    requestLbl.frame = frame;
    
    frame = senderValView.frame;
    frame.origin.x = 8;
    senderValView.frame = frame;
    
    frame = senderLbl.frame;
    frame.origin.x = senderValView.frame.origin.x + senderValView.frame.size.width + 2;
    senderLbl.frame = frame;
    
    
    frame = serviceSearchBtn.frame;
    frame.origin.x = 8;
    serviceSearchBtn.frame = frame;
    
    frame = serviceValView.frame;
    frame.origin.x = serviceSearchBtn.frame.origin.x + 2 + serviceSearchBtn.frame.size.width;
    serviceValView.frame = frame;
    
    frame = serviceLbl.frame;
    frame.origin.x = serviceValView.frame.origin.x + serviceValView.frame.size.width + 2;
    serviceLbl.frame = frame;
    frame = startDateView.frame;
    frame.origin.x = 8;
    startDateView.frame = frame;
    
    frame = startDateLbl.frame;
    frame.origin.x = startDateView.frame.origin.x + startDateView.frame.size.width;
    startDateLbl.frame = frame;
    
    frame = endDateView.frame;
    frame.origin.x = 8;
    endDateView.frame = frame;
    
    frame = endDateLbl.frame;
    frame.origin.x = endDateView.frame.origin.x + endDateView.frame.size.width;
    endDateLbl.frame = frame;
    
    searchServicesCancelbtn.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    searchServicesCancelbtn.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    searchServicesCancelbtn.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    searchServicesChoosebtn.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    searchServicesChoosebtn.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    searchServicesChoosebtn.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
}

#pragma mark - touch delegate
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([senderValTxt isFirstResponder] && [touch view] != senderValTxt) {
        [senderValTxt resignFirstResponder];
    }
    if ([serviceValTxt isFirstResponder] && [touch view] != serviceValTxt) {
        [serviceValTxt resignFirstResponder];
    }
    if ([requestValTxt isFirstResponder] && [touch view] != requestValTxt) {
        [requestValTxt resignFirstResponder];
    }
    
    [super touchesBegan:touches withEvent:event];
}




#pragma mark - methods
-(void)initalizeViewsTimer
{
    [dateView initIslamicDateWithMonths:YES withDay:YES withDelegate:self withMaxDate:FALSE withMinDate:FALSE isForceHijri:NO];
    servicePreviousRowRequests = -1;
    serviceSelectedRowRequests = -1;
    
    
    
    filteredRequests = [[NSMutableArray alloc] init];
    searching = FALSE;
    [requestValTxt setReturnKeyType:UIReturnKeyDone];
    [senderValTxt setReturnKeyType:UIReturnKeyDone];
    [serviceValTxt setReturnKeyType:UIReturnKeyDone];
    
    
    
    
    [myRequestsView setBackgroundColor:[UIColor whiteColor]];
    [[myRequestsView layer] setBorderColor:[[UIColor colorWithRed:(230/255.f) green:(76/255.f) blue:(46/255.f) alpha:1.0] CGColor]];
    [[myRequestsView layer] setCornerRadius:10.0];
    [myRequestsLbl setTextColor:[UIColor colorWithRed:(32/255.f) green:(145/255.f) blue:(206/255.f) alpha:1.0]];
    
    [recievedRequestsView setBackgroundColor:[UIColor whiteColor]];
    [[recievedRequestsView layer] setBorderColor:[[UIColor colorWithRed:(230/255.f) green:(76/255.f) blue:(46/255.f) alpha:1.0] CGColor]];
    [[recievedRequestsView layer] setCornerRadius:10.0];
    [recievedRequestsLbl setTextColor:[UIColor colorWithRed:(32/255.f) green:(145/255.f) blue:(206/255.f) alpha:1.0]];
    
    [completedRequestsView setBackgroundColor:[UIColor whiteColor]];
    [[completedRequestsView layer] setBorderColor:[[UIColor colorWithRed:(230/255.f) green:(76/255.f) blue:(46/255.f) alpha:1.0] CGColor]];
    [[completedRequestsView layer] setCornerRadius:10.0];
    [completedRequestsLbl setTextColor:[UIColor colorWithRed:(32/255.f) green:(145/255.f) blue:(206/255.f) alpha:1.0]];
    
    [processedRequestsView setBackgroundColor:[UIColor whiteColor]];
    [[processedRequestsView layer] setBorderColor:[[UIColor colorWithRed:(230/255.f) green:(76/255.f) blue:(46/255.f) alpha:1.0] CGColor]];
    [[processedRequestsView layer] setCornerRadius:10.0];
    [processedRequestsLbl setTextColor:[UIColor colorWithRed:(32/255.f) green:(145/255.f) blue:(206/255.f) alpha:1.0]];
    [[serviceValView layer] setBorderColor:[[UIColor colorWithRed:(69/255.f) green:(69/255.f) blue:(69/255.f) alpha:0.5] CGColor]];
    [[serviceValView layer] setBorderWidth:0.5];
    [[serviceValView layer] setCornerRadius:2];
    
    [[senderValView layer] setBorderColor:[[UIColor colorWithRed:(69/255.f) green:(69/255.f) blue:(69/255.f) alpha:0.5] CGColor]];
    [[senderValView layer] setBorderWidth:0.5];
    [[senderValView layer] setCornerRadius:2];
    
    [[requestValView layer] setBorderColor:[[UIColor colorWithRed:(69/255.f) green:(69/255.f) blue:(69/255.f) alpha:0.5] CGColor]];
    [[requestValView layer] setBorderWidth:0.5];
    [[requestValView layer] setCornerRadius:2];
    
    myRequestsLbl.adjustsFontSizeToFitWidth = YES;
    recievedRequestsLbl.adjustsFontSizeToFitWidth = YES;
    completedRequestsLbl.adjustsFontSizeToFitWidth = YES;
    processedRequestsLbl.adjustsFontSizeToFitWidth = YES;
}

-(RequestFilterObj *)checkFilterData
{
    BOOL found = FALSE;
    RequestFilterObj *rObj = [[RequestFilterObj alloc] init];
    if([StaticFuntions isStringEmpty:serviceValTxt.text]){
        rObj.serviceCode = @"";
        found = YES;
    }
    else
    {
        for (int i = 0; i < [listOfServices count]; i++) {
            ServicesObj *sObj = [listOfServices objectAtIndex:i];
            if (([sObj.serviceNameAr rangeOfString:serviceValTxt.text options:NSCaseInsensitiveSearch].location != NSNotFound) || ([sObj.serviceCode isEqualToString:serviceValTxt.text]) || ([sObj.serviceNameEn rangeOfString:serviceValTxt.text options:NSCaseInsensitiveSearch].location != NSNotFound)) {
                rObj.serviceCode = sObj.serviceCode;
                found = YES;
                break;
            }
        }
    }
    if (!found) {
        [StaticFuntions showAlertWithTitle:ServicesTitleText Message:ServicesNotFountMsg];
        return nil;
    }
    else
    {
        if([StaticFuntions isStringEmpty:senderValTxt.text]){
            rObj.requesterFilter = @"";
        }
        else
        {
            rObj.requesterFilter = senderValTxt.text;
        }
        
        if([startDateDayLbl.text isEqualToString:@"--"]){
            rObj.fromDate = @"";
        }
        else
        {
            rObj.fromDate = [self concatinateDateStringForWebService:[StaticFuntions getGregorianDayNumForWebService:startDate] month:[StaticFuntions getGregorianMonthNumForWebService:startDate] year:[StaticFuntions getGregorianYearNumForWebService:startDate]];
        }
        
        if([endDateDayLbl.text isEqualToString:@"--"]){
            rObj.toDate = @"";
        }
        else
        {
            rObj.toDate = [self concatinateDateStringForWebService:[StaticFuntions getGregorianDayNumForWebService:endDate] month:[StaticFuntions getGregorianMonthNumForWebService:endDate] year:[StaticFuntions getGregorianYearNumForWebService:endDate]];
        }
        
        if([StaticFuntions isStringEmpty:requestValTxt.text]){
            rObj.requestCode = @"";
        }
        else
        {
            rObj.requestCode = requestValTxt.text;
        }
        return rObj;
    }
    
    
}

-(void)previewListOfServices
{
    [servicesTblView reloadData];
    
    serviceSelectedRowRequests = -1;
    
    ServicesObj *obj;
    for (int i = 0 ; i < [listOfServices count]; i++) {
        obj = [listOfServices objectAtIndex:i];
        if ([serviceValTxt.text isEqualToString:obj.serviceCode] || ([obj.serviceNameAr rangeOfString:serviceValTxt.text options:NSCaseInsensitiveSearch].location != NSNotFound) || ([obj.serviceNameEn rangeOfString:serviceValTxt.text options:NSCaseInsensitiveSearch].location != NSNotFound)) {
            serviceSelectedRowRequests = i;
            break;
        }
    }
    if (servicePreviousRowRequests != -1) {
        NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:servicePreviousRowRequests inSection:0];
        [servicesTblView deselectRowAtIndexPath:selectedIndexPath animated:NO];
    }
    
    if (serviceSelectedRowRequests != -1) {
        NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:serviceSelectedRowRequests inSection:0];
        servicePreviousRowRequests = serviceSelectedRowRequests;
        [servicesTblView selectRowAtIndexPath:selectedIndexPath animated:YES  scrollPosition:UITableViewScrollPositionBottom];
    }
    servicesSearchView.hidden = FALSE;
    backgroundView.hidden = FALSE;
}



-(void)initRefreshControl:(UITableView*)tableView{
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl setTintColor:[UIColor whiteColor]];
    UIColor *color = [UIColor colorWithRed:236.0/255.0 green:236.0/255.0 blue:236.0/255.0 alpha:1];
    [refreshControl setBackgroundColor:color];
    refreshControl.layer.zPosition = requestTableView.backgroundView.layer.zPosition + 1;
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [requestTableView addSubview:refreshControl];
    
}

-(NSDateFormatter *)initilizeDateFormatter
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    if(appDelegate.currentLang==English)
        //english output
        df.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    else
        df.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierIslamicUmmAlQura];
    
    df.dateStyle = NSDateFormatterLongStyle;
    df.dateFormat = @"dd/MMMM/yyyy";
    if(appDelegate.currentLang==English){
        //english output
        df.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    }else if(appDelegate.currentLang==Arabic){
        df.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ar"];
    }
    return df;
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
    dateStr = [NSString stringWithFormat:@"%@/%@/%@",day,month,year];
    
    return dateStr;
}

-(void)hideKeyboard{
    [senderValTxt resignFirstResponder];
    [serviceValTxt resignFirstResponder];
    [requestValTxt resignFirstResponder];
}
/////////calling 84 + 105 = 189
-(void)visable_hideDateControl:(BOOL)hidden{
    dateView.hidden=hidden;
    searchView.hidden = !hidden;
    if (searchView.hidden == YES) {
        backgroundView.hidden=hidden;
    }

}

-(void)loadServices
{
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

-(void)connect:(NSString*)withRequestCode withDirection:(NSString *)withDirection withCategory:(NSString *)withCategory withFilteredServiceCode:(NSString*)withFilteredServiceCode withFilteredRequesterFilter:(NSString*)withFilteredRequesterFilter withFilteredFromDate:(NSString*)withFilteredFromDate withFilteredToDate:(NSString*)withFilteredToDate withFilteredRequestCode:(NSString*)withFilteredRequestCode{

    [refreshControl endRefreshing];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if([self isNetworkAvailable] ==YES)
    {
        NSLog(@"Network Connection available");
 [[RequestManager sharedInstance] getRequestsList:self withUsername:appDelegate.EmployeeObj.userName withRequestCode:withRequestCode withDirection:withDirection withCategory:withCategory withFilteredServiceCode:withFilteredServiceCode withFilteredRequesterFilter:withFilteredRequesterFilter withFilteredFromDate:withFilteredFromDate withFilteredToDate:withFilteredToDate withFilteredRequestCode:withFilteredRequestCode];    }
    
    else{
        [StaticFuntions showAlertWithTitle:NetWorkTitle Message:NetWorkBody];
        
    }
    
   
    
    
    if (![withDirection isEqualToString:@"down"]) {
        [self showActivityViewer];
    }
    
    /*
    NSMutableArray* arr = [[NSMutableArray alloc] init];
    
    RequestObj *rObj=[[RequestObj alloc] init];
    rObj = [self fillstaticdata:@"0" requestDateStr:@"12/08/1437" requestNoStr:@"1" statusStr:@"مرفوض من لجنه الاستعانة" serviceNameStr:@"نظام الاستعانة" serviceIDStr:@"7" userNumberStr:@"245" userNameStr:@"ياسر صالح إبراهيم المهنا" nameStr:@"ياسر صالح إبراهيم المهنا" jobTitle:@"أستاذ" jobCode:@"235434" requestTypeVal:My];
    [arr addObject:rObj];
    
    rObj=[[RequestObj alloc] init];
    rObj = [self fillstaticdata:@"0" requestDateStr:@"12/08/1437" requestNoStr:@"2" statusStr:@"تم إعتماد الطلب من عميد عمادة تطوير المهارات" serviceNameStr:@"حضور المؤتمرات" serviceIDStr:@"1" userNumberStr:@"245" userNameStr:@"يونس يوسف سلطان مولان" nameStr:@"يونس يوسف سلطان مولان" jobTitle:@"فني امتياز سعودي" jobCode:@"235434" requestTypeVal:My];
    [arr addObject:rObj];
    
    rObj=[[RequestObj alloc] init];
    rObj = [self fillstaticdata:@"0" requestDateStr:@"12/08/1437" requestNoStr:@"3" statusStr:@"مرفوض من لجنه الاستعانة" serviceNameStr:@"نظام الاستعانة" serviceIDStr:@"7" userNumberStr:@"245" userNameStr:@"ياسر صالح إبراهيم المهنا" nameStr:@"ياسر صالح إبراهيم المهنا" jobTitle:@"أستاذ" jobCode:@"235434" requestTypeVal:My];
    [arr addObject:rObj];
    
    rObj=[[RequestObj alloc] init];
    rObj = [self fillstaticdata:@"0" requestDateStr:@"12/08/1437" requestNoStr:@"4" statusStr:@"تم إعتماد الطلب من عميد عمادة تطوير المهارات" serviceNameStr:@"حضور المؤتمرات" serviceIDStr:@"1" userNumberStr:@"245" userNameStr:@"يونس يوسف سلطان مولان" nameStr:@"يونس يوسف سلطان مولان" jobTitle:@"فني امتياز سعودي" jobCode:@"235434" requestTypeVal:My];
    [arr addObject:rObj];
    
    rObj=[[RequestObj alloc] init];
    rObj = [self fillstaticdata:@"0" requestDateStr:@"12/08/1437" requestNoStr:@"5" statusStr:@"مرفوض من لجنه الاستعانة" serviceNameStr:@"نظام الاستعانة" serviceIDStr:@"7" userNumberStr:@"245" userNameStr:@"ياسر صالح إبراهيم المهنا" nameStr:@"ياسر صالح إبراهيم المهنا" jobTitle:@"أستاذ" jobCode:@"235434" requestTypeVal:Recieved];
    [arr addObject:rObj];
    
    rObj=[[RequestObj alloc] init];
    rObj = [self fillstaticdata:@"0" requestDateStr:@"12/08/1437" requestNoStr:@"6" statusStr:@"تم إعتماد الطلب من عميد عمادة تطوير المهارات" serviceNameStr:@"حضور المؤتمرات" serviceIDStr:@"1" userNumberStr:@"245" userNameStr:@"يونس يوسف سلطان مولان" nameStr:@"يونس يوسف سلطان مولان" jobTitle:@"فني امتياز سعودي" jobCode:@"235434" requestTypeVal:Recieved];
    [arr addObject:rObj];
    
    rObj=[[RequestObj alloc] init];
    rObj = [self fillstaticdata:@"0" requestDateStr:@"12/08/1437" requestNoStr:@"7" statusStr:@"مرفوض من لجنه الاستعانة" serviceNameStr:@"نظام الاستعانة" serviceIDStr:@"7" userNumberStr:@"245" userNameStr:@"ياسر صالح إبراهيم المهنا" nameStr:@"ياسر صالح إبراهيم المهنا" jobTitle:@"أستاذ" jobCode:@"235434" requestTypeVal:Recieved];
    [arr addObject:rObj];
    
    rObj=[[RequestObj alloc] init];
    rObj = [self fillstaticdata:@"0" requestDateStr:@"12/08/1437" requestNoStr:@"8" statusStr:@"تم إعتماد الطلب من عميد عمادة تطوير المهارات" serviceNameStr:@"حضور المؤتمرات" serviceIDStr:@"1" userNumberStr:@"245" userNameStr:@"يونس يوسف سلطان مولان" nameStr:@"يونس يوسف سلطان مولان" jobTitle:@"فني امتياز سعودي" jobCode:@"235434" requestTypeVal:Recieved];
    [arr addObject:rObj];
    
    rObj=[[RequestObj alloc] init];
    rObj = [self fillstaticdata:@"0" requestDateStr:@"12/08/1437" requestNoStr:@"9" statusStr:@"مرفوض من لجنه الاستعانة" serviceNameStr:@"نظام الاستعانة" serviceIDStr:@"7" userNumberStr:@"245" userNameStr:@"ياسر صالح إبراهيم المهنا" nameStr:@"ياسر صالح إبراهيم المهنا" jobTitle:@"أستاذ" jobCode:@"235434" requestTypeVal:Recieved];
    [arr addObject:rObj];
    
    rObj=[[RequestObj alloc] init];
    rObj = [self fillstaticdata:@"0" requestDateStr:@"12/08/1437" requestNoStr:@"10" statusStr:@"تم إعتماد الطلب من عميد عمادة تطوير المهارات" serviceNameStr:@"حضور المؤتمرات" serviceIDStr:@"1" userNumberStr:@"245" userNameStr:@"يونس يوسف سلطان مولان" nameStr:@"يونس يوسف سلطان مولان" jobTitle:@"فني امتياز سعودي" jobCode:@"235434" requestTypeVal:Recieved];
    [arr addObject:rObj];
    
    rObj=[[RequestObj alloc] init];
    rObj = [self fillstaticdata:@"0" requestDateStr:@"12/08/1437" requestNoStr:@"11" statusStr:@"مرفوض من لجنه الاستعانة" serviceNameStr:@"نظام الاستعانة" serviceIDStr:@"7" userNumberStr:@"245" userNameStr:@"ياسر صالح إبراهيم المهنا" nameStr:@"ياسر صالح إبراهيم المهنا" jobTitle:@"أستاذ" jobCode:@"235434" requestTypeVal:Completed];
    [arr addObject:rObj];
    
    rObj=[[RequestObj alloc] init];
    rObj = [self fillstaticdata:@"0" requestDateStr:@"12/08/1437" requestNoStr:@"12" statusStr:@"تم إعتماد الطلب من عميد عمادة تطوير المهارات" serviceNameStr:@"حضور المؤتمرات" serviceIDStr:@"1" userNumberStr:@"245" userNameStr:@"يونس يوسف سلطان مولان" nameStr:@"يونس يوسف سلطان مولان" jobTitle:@"فني امتياز سعودي" jobCode:@"235434" requestTypeVal:Completed];
    [arr addObject:rObj];
    
    rObj=[[RequestObj alloc] init];
    rObj = [self fillstaticdata:@"0" requestDateStr:@"12/08/1437" requestNoStr:@"13" statusStr:@"مرفوض من لجنه الاستعانة" serviceNameStr:@"نظام الاستعانة" serviceIDStr:@"7" userNumberStr:@"245" userNameStr:@"ياسر صالح إبراهيم المهنا" nameStr:@"ياسر صالح إبراهيم المهنا" jobTitle:@"أستاذ" jobCode:@"235434" requestTypeVal:Completed];
    [arr addObject:rObj];
    
    rObj=[[RequestObj alloc] init];
    rObj = [self fillstaticdata:@"0" requestDateStr:@"12/08/1437" requestNoStr:@"14" statusStr:@"تم إعتماد الطلب من عميد عمادة تطوير المهارات" serviceNameStr:@"حضور المؤتمرات" serviceIDStr:@"1" userNumberStr:@"245" userNameStr:@"يونس يوسف سلطان مولان" nameStr:@"يونس يوسف سلطان مولان" jobTitle:@"فني امتياز سعودي" jobCode:@"235434" requestTypeVal:Completed];
    [arr addObject:rObj];
    
    rObj=[[RequestObj alloc] init];
    rObj = [self fillstaticdata:@"0" requestDateStr:@"12/08/1437" requestNoStr:@"15" statusStr:@"مرفوض من لجنه الاستعانة" serviceNameStr:@"نظام الاستعانة" serviceIDStr:@"7" userNumberStr:@"245" userNameStr:@"ياسر صالح إبراهيم المهنا" nameStr:@"ياسر صالح إبراهيم المهنا" jobTitle:@"أستاذ" jobCode:@"235434" requestTypeVal:Completed];
    [arr addObject:rObj];
    
    rObj=[[RequestObj alloc] init];
    rObj = [self fillstaticdata:@"0" requestDateStr:@"12/08/1437" requestNoStr:@"16" statusStr:@"تم إعتماد الطلب من عميد عمادة تطوير المهارات" serviceNameStr:@"حضور المؤتمرات" serviceIDStr:@"1" userNumberStr:@"245" userNameStr:@"يونس يوسف سلطان مولان" nameStr:@"يونس يوسف سلطان مولان" jobTitle:@"فني امتياز سعودي" jobCode:@"235434" requestTypeVal:Completed];
    [arr addObject:rObj];
    
    rObj=[[RequestObj alloc] init];
    rObj = [self fillstaticdata:@"0" requestDateStr:@"12/08/1437" requestNoStr:@"17" statusStr:@"مرفوض من لجنه الاستعانة" serviceNameStr:@"نظام الاستعانة" serviceIDStr:@"7" userNumberStr:@"245" userNameStr:@"ياسر صالح إبراهيم المهنا" nameStr:@"ياسر صالح إبراهيم المهنا" jobTitle:@"أستاذ" jobCode:@"235434" requestTypeVal:Completed];
    [arr addObject:rObj];
    
    rObj=[[RequestObj alloc] init];
    rObj = [self fillstaticdata:@"0" requestDateStr:@"12/08/1437" requestNoStr:@"18" statusStr:@"تم إعتماد الطلب من عميد عمادة تطوير المهارات" serviceNameStr:@"حضور المؤتمرات" serviceIDStr:@"1" userNumberStr:@"245" userNameStr:@"يونس يوسف سلطان مولان" nameStr:@"يونس يوسف سلطان مولان" jobTitle:@"فني امتياز سعودي" jobCode:@"235434" requestTypeVal:Completed];
    [arr addObject:rObj];
    
    rObj=[[RequestObj alloc] init];
    rObj = [self fillstaticdata:@"0" requestDateStr:@"12/08/1437" requestNoStr:@"19" statusStr:@"مرفوض من لجنه الاستعانة" serviceNameStr:@"نظام الاستعانة" serviceIDStr:@"7" userNumberStr:@"245" userNameStr:@"ياسر صالح إبراهيم المهنا" nameStr:@"ياسر صالح إبراهيم المهنا" jobTitle:@"أستاذ" jobCode:@"235434" requestTypeVal:Completed];
    [arr addObject:rObj];
    
    rObj=[[RequestObj alloc] init];
    rObj = [self fillstaticdata:@"0" requestDateStr:@"12/08/1437" requestNoStr:@"20" statusStr:@"تم إعتماد الطلب من عميد عمادة تطوير المهارات" serviceNameStr:@"حضور المؤتمرات" serviceIDStr:@"1" userNumberStr:@"245" userNameStr:@"يونس يوسف سلطان مولان" nameStr:@"يونس يوسف سلطان مولان" jobTitle:@"فني امتياز سعودي" jobCode:@"235434" requestTypeVal:Completed];
    [arr addObject:rObj];
    
    rObj=[[RequestObj alloc] init];
    rObj = [self fillstaticdata:@"0" requestDateStr:@"12/08/1437" requestNoStr:@"21" statusStr:@"مرفوض من لجنه الاستعانة" serviceNameStr:@"نظام الاستعانة" serviceIDStr:@"7" userNumberStr:@"245" userNameStr:@"ياسر صالح إبراهيم المهنا" nameStr:@"ياسر صالح إبراهيم المهنا" jobTitle:@"أستاذ" jobCode:@"235434" requestTypeVal:Completed];
    [arr addObject:rObj];
    
    rObj=[[RequestObj alloc] init];
    rObj = [self fillstaticdata:@"0" requestDateStr:@"12/08/1437" requestNoStr:@"22" statusStr:@"تم إعتماد الطلب من عميد عمادة تطوير المهارات" serviceNameStr:@"حضور المؤتمرات" serviceIDStr:@"1" userNumberStr:@"245" userNameStr:@"يونس يوسف سلطان مولان" nameStr:@"يونس يوسف سلطان مولان" jobTitle:@"فني امتياز سعودي" jobCode:@"235434" requestTypeVal:Completed];
    [arr addObject:rObj];
    for(int i=0;i<[arr count];i++){
        RequestObj* obj=[arr objectAtIndex:i];
        
            if (!searching) {
                
                if (i < 5)
                    [myRequestsArr addObject:obj];
                else if (i < 10 && i > 5 )
                    [recievedRequestsArr addObject:obj];
                else if (i < 15 && i > 10 )
                    [completedRequestsArr addObject:obj];
                else if (i < 20 && i > 15 )
                    [processedRequestsArr addObject:obj];
            }
            else{
                [filteredRequests addObject:obj];
            }
    }
    myRequestsCount = [myRequestsArr count];
    recievedCount = [recievedRequestsArr count];
    completedCount = [completedRequestsArr count];
    processedCount = [processedRequestsArr count];
    if (myRequestsCount > 0) {
        myRequestsView.hidden = FALSE;
        myRequestsLbl.text = [NSString stringWithFormat:@"%lu",(unsigned long)myRequestsCount];
    }else
        myRequestsView.hidden = YES;
    if (recievedCount > 0) {
        recievedRequestsView.hidden = FALSE;
        recievedRequestsLbl.text = [NSString stringWithFormat:@"%lu",(unsigned long)recievedCount];
    }else
        recievedRequestsView.hidden = YES;
    if (completedCount > 0) {
        completedRequestsView.hidden = FALSE;
        completedRequestsLbl.text = [NSString stringWithFormat:@"%lu",(unsigned long)completedCount];
    }else
        completedRequestsView.hidden = YES;
    if (processedCount > 0) {
        processedRequestsView.hidden = FALSE;
        processedRequestsLbl.text = [NSString stringWithFormat:@"%lu",(unsigned long)processedCount];
    }else
        processedRequestsView.hidden = YES;
    [tableView reloadData];*/
    
}


/*
-(RequestObj *)fillstaticdata:(NSString *)RequestIDStr requestDateStr:(NSString *)requestDateStr requestNoStr:(NSString *)requestNoStr statusStr:(NSString *)statusStr serviceNameStr:(NSString *)serviceNameStr serviceIDStr:(NSString *)serviceIDStr userNumberStr:(NSString *)userNumberStr userNameStr:(NSString *)userNameStr nameStr:(NSString *)nameStr jobTitle:(NSString *)jobTitle jobCode:(NSString *)jobCode requestTypeVal:(RequestsType)requestTypeVal
{
    
    RequestObj *rObj=[[RequestObj alloc] init];
    
    rObj.requestCode = requestNoStr;
    rObj.requestDate = requestDateStr;
    rObj.requestStatus = statusStr;
    rObj.requesterName = userNameStr;
    rObj.serviceCode = serviceIDStr;
    rObj.serviceName = serviceNameStr;
    
    return rObj;
}
*/





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
            
            [self connect:@"" withDirection:@"" withCategory:@"mine" withFilteredServiceCode:@"" withFilteredRequesterFilter:@"" withFilteredFromDate:@"" withFilteredToDate:@"" withFilteredRequestCode:@""];
            
        }else if ([service intValue]==(int)GetRequestsList_WS){
            completedCount = [[data objectForKeyedSubscript:completedCount_MW] integerValue];
            processedCount = [[data objectForKeyedSubscript:processedCount_MW] integerValue];
            recievedCount = [[data objectForKeyedSubscript:inboxCount_MW] integerValue];
            myRequestsCount = [[data objectForKeyedSubscript:mineCount_MW] integerValue];
            searchCount = [[data objectForKeyedSubscript:searchCount_MW] integerValue];
            
            NSMutableArray* arr = [data objectForKeyedSubscript:listMW];
            
            
            for(int i=0;i<[arr count];i++){
                RequestObj* obj=[arr objectAtIndex:i];
                
                if ([selectedDirection isEqualToString:@""] || [selectedDirection isEqualToString:@"down"]) {
                    if (!searching) {
                        if (selectedType == My)
                            [myRequestsArr addObject:obj];
                        else if (selectedType == Recieved)
                            [recievedRequestsArr addObject:obj];
                        else if (selectedType == Completed)
                            [completedRequestsArr addObject:obj];
                        else if (selectedType == Processed)
                            [processedRequestsArr addObject:obj];
                    }
                    else{
                        [filteredRequests addObject:obj];
                    }
                    
                }
                else if ([selectedDirection isEqualToString:@"up"]) {
                    if (!searching) {
                        if (selectedType == My)
                            [myRequestsArr insertObject:obj atIndex:i];
                        else if (selectedType == Recieved)
                            [recievedRequestsArr insertObject:obj atIndex:i];
                        else if (selectedType == Completed)
                            [completedRequestsArr insertObject:obj atIndex:i];
                        else if (selectedType == Processed)
                            [processedRequestsArr insertObject:obj atIndex:i];
                    }
                    else{
                        [filteredRequests insertObject:obj atIndex:i];
                    }
                    
                }
            }
            backgroundView.hidden = YES;
            searchView.hidden = YES;
            searchBtn.hidden = FALSE;
        }
        
        
        
    }else{
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:error.errorMessage];
    }
    
    if (myRequestsCount > 0) {
        myRequestsView.hidden = FALSE;
        myRequestsLbl.text = [NSString stringWithFormat:@"%lu",(unsigned long)myRequestsCount];
    }else
        myRequestsView.hidden = YES;
    if (recievedCount > 0) {
        recievedRequestsView.hidden = FALSE;
        recievedRequestsLbl.text = [NSString stringWithFormat:@"%lu",(unsigned long)recievedCount];
    }else
        recievedRequestsView.hidden = YES;
    if (completedCount > 0) {
        completedRequestsView.hidden = FALSE;
        completedRequestsLbl.text = [NSString stringWithFormat:@"%lu",(unsigned long)completedCount];
    }else
        completedRequestsView.hidden = YES;
    if (processedCount > 0) {
        processedRequestsView.hidden = FALSE;
        processedRequestsLbl.text = [NSString stringWithFormat:@"%lu",(unsigned long)processedCount];
    }else
        processedRequestsView.hidden = YES;
    [requestTableView reloadData];
}

#pragma mark - table delegate

-(UITableViewCell*) tableView:(UITableView *)tblView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (tblView == requestTableView) {
        static NSString *CellIdentifier=@"RequestsTableViewCell";
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        if(appDelegate.currentLang==English)
            CellIdentifier=@"RequestsTableViewCell_en";
        else
            CellIdentifier=@"RequestsTableViewCell";
        
        RequestsTableViewCell *cell = [requestTableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[RequestsTableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier:CellIdentifier];
        }
        RequestObj *obj=nil;
        
        if (searching) {
            obj=[filteredRequests objectAtIndex:(int)indexPath.row];
        }
        else{
            if (selectedType == My)
                obj=[myRequestsArr objectAtIndex:(int)indexPath.row];
            else if (selectedType == Recieved)
                obj=[recievedRequestsArr objectAtIndex:(int)indexPath.row];
            else if (selectedType == Completed)
                obj=[completedRequestsArr objectAtIndex:(int)indexPath.row];
            else if (selectedType == Processed)
                obj=[processedRequestsArr objectAtIndex:(int)indexPath.row];
        }
        [cell initWithRequestObj:obj withRowId:(int)indexPath.row];
        [cell.actionsBtn addTarget:self action:@selector(onPressActions:) forControlEvents:UIControlEventTouchUpInside];
        cell.layoutMargins = UIEdgeInsetsZero;
        cell.actionsBtn.tag = indexPath.row;
        cell.preservesSuperviewLayoutMargins = NO;
        return cell;
        
    }else if (tblView == servicesTblView) {
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

    
    if (tblView == requestTableView) {
        if (searching) {
            if([filteredRequests count]==0){
                noDataLbl.hidden=NO;
                noDataImg.hidden=NO;
                return 0;
            }
            noDataLbl.hidden=YES;
            noDataImg.hidden=YES;
            return [filteredRequests count];
        }
        else{
            if (selectedType == My){
                if([myRequestsArr count]==0){
                    noDataLbl.hidden=NO;
                    noDataImg.hidden=NO;
                    return 0;
                }
                noDataLbl.hidden=YES;
                noDataImg.hidden=YES;
                return [myRequestsArr count];
            }else if (selectedType == Recieved){
                if([recievedRequestsArr count]==0){
                    noDataLbl.hidden=NO;
                    noDataImg.hidden=NO;
                    return 0;
                }
                noDataLbl.hidden=YES;
                noDataImg.hidden=YES;
                return [recievedRequestsArr count];
            }else if (selectedType == Completed){
                if([completedRequestsArr count]==0){
                    noDataLbl.hidden=NO;
                    noDataImg.hidden=NO;
                    return 0;
                }
                noDataLbl.hidden=YES;
                noDataImg.hidden=YES;
                return [completedRequestsArr count];
            }else if (selectedType == Processed){
                if([processedRequestsArr count]==0){
                    noDataLbl.hidden=NO;
                    noDataImg.hidden=NO;
                    return 0;
                }
                noDataLbl.hidden=YES;
                noDataImg.hidden=YES;
                return [processedRequestsArr count];
            }
            else
                return 0;
        }
    }else if (tblView == servicesTblView) {
        return [listOfServices count];
    }
    return 0;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tView == requestTableView) {
        RequestObj *obj = [[RequestObj alloc] init];
        if (searching)
            obj=[filteredRequests objectAtIndex:(int)indexPath.row];
        else{
            if (selectedType == My)
                obj=[myRequestsArr objectAtIndex:(int)indexPath.row];
            else if (selectedType == Recieved)
                obj=[recievedRequestsArr objectAtIndex:(int)indexPath.row];
            else if (selectedType == Completed)
                obj=[completedRequestsArr objectAtIndex:(int)indexPath.row];
            else if (selectedType == Processed)
                obj=[processedRequestsArr objectAtIndex:(int)indexPath.row];
        }
        NSLog(@"NSString *tempPhone = %@",obj.requestCode);

        selectedRequest = obj.requestCode;
        RequestDetailsViewController * viewController = [self.storyboard instantiateViewControllerWithIdentifier:SeagueRequestDetailsScreen];
        viewController.selectedRequest = selectedRequest;
        [self.navigationController pushViewController:viewController animated:NO];
        
        [requestTableView deselectRowAtIndexPath:indexPath animated:YES];
        
    }else if (tView == servicesTblView) {
        if (servicePreviousRowRequests != -1 || servicePreviousRowRequests != -2) {
            NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:servicePreviousRowRequests inSection:0];
            if (indexPath.row != servicePreviousRowRequests) {
                servicePreviousRowRequests = indexPath.row;
                selectedIndexPath = [NSIndexPath indexPathForRow:servicePreviousRowRequests inSection:0];
            }
            else{
                [servicesTblView deselectRowAtIndexPath:selectedIndexPath animated:NO];
                servicePreviousRowRequests = -2;
            }
        }
        else if (servicePreviousRowRequests == -2){
            [servicesTblView deselectRowAtIndexPath:indexPath animated:NO];
        }
        if (servicePreviousRowRequests != -2 && servicePreviousRowRequests != -1)
            serviceSelectedRowRequests = indexPath.row;
        else
            serviceSelectedRowRequests = -1;
    }

}

#pragma mark - scroll delegate

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    NSInteger currentypos = targetContentOffset->y;
    if ((scrollView.contentSize.height - scrollView.frame.size.height) > 0) {
        if (currentypos >= (scrollView.contentSize.height - (requestTableView.frame.size.height)))
        {
            BOOL scrolled = FALSE;
            noDataLbl.hidden=YES;
            
            NSString *selectedCategory;
            RequestObj *obj;
            if (searching) {
                if (searchCount > [filteredRequests count]) {
                    scrolled = YES;
                    obj = [filteredRequests lastObject];
                    
                    if (selectedType == My)
                        selectedCategory = @"mine";
                    else if (selectedType == Recieved)
                        selectedCategory = @"inbox";
                    else if (selectedType == Completed)
                        selectedCategory = @"completed";
                    else if (selectedType == Processed)
                        selectedCategory = @"processed";
                }
            }
            else{
                if (selectedType == My) {
                    if (myRequestsCount > [myRequestsArr count]) {
                        scrolled = YES;
                        obj = [myRequestsArr lastObject];
                        selectedCategory = @"mine";
                    }
                }else if (selectedType == Recieved) {
                    if (recievedCount > [recievedRequestsArr count]) {
                        scrolled = YES;
                        obj = [recievedRequestsArr lastObject];
                        selectedCategory = @"inbox";
                    }
                }else if (selectedType == Completed) {
                    if (completedCount > [completedRequestsArr count]) {
                        scrolled = YES;
                        obj = [completedRequestsArr lastObject];
                        selectedCategory = @"completed";
                    }
                }else if (selectedType == Processed) {
                    if (processedCount > [processedRequestsArr count]) {
                        scrolled = YES;
                        obj = [processedRequestsArr lastObject];
                        selectedCategory = @"processed";
                    }
                }
            }
            
            if (scrolled) {
                selectedDirection = @"down";
                if (obj.requestCode != nil) {
                    selectedRequest = obj.requestCode;
                    RequestFilterObj *obj = [[RequestFilterObj alloc] init];
                     obj = [self checkFilterData];
                    if (obj != nil) {
                        [self connect:selectedRequest withDirection:selectedDirection withCategory:selectedCategory withFilteredServiceCode:obj.serviceCode withFilteredRequesterFilter:obj.requesterFilter withFilteredFromDate:obj.fromDate withFilteredToDate:obj.toDate withFilteredRequestCode:obj.requestCode];
                    }

                }
                
            }
            
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
    df = [self initilizeDateFormatter];
    NSString *dateStr;
    
    if ([targetDateView isEqualToString:@"SearchStartDate"] || [targetDateView isEqualToString:@"SearchEndDate"]) {
        if ([targetDateView isEqualToString:@"SearchStartDate"]) {
            startDate=selectedDate;
            
            if (![endDateDayLbl.text isEqualToString:@"--"]) {
                dateStr = [self concatinateDateString:endDateDayLbl.text month:endDateMonthLbl.text year:endDateYearLbl.text];
                
                endDate = [df dateFromString:dateStr];
            }
            else
            {
                done = YES;
            }
        }
        
        else if ([targetDateView isEqualToString:@"SearchEndDate"]) {
            endDate=selectedDate;
            
            if (![startDateDayLbl.text isEqualToString:@"--"]) {
                dateStr = [self concatinateDateString:startDateDayLbl.text month:startDateMonthLbl.text year:startDateYearLbl.text];
                
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
                startDateYearLbl.text=[StaticFuntions getYearForDate:selectedDate forceHijri:FALSE forceEnLocale:FALSE];
                startDateMonthLbl.text=[StaticFuntions getMonthForDate:selectedDate forceHijri:FALSE];
                startDateDayLbl.text=[StaticFuntions getDayForDate:selectedDate forceEnLocale:FALSE];
            }
            else if ([targetDateView isEqualToString:@"SearchEndDate"]) {
                endDateYearLbl.text=[StaticFuntions getYearForDate:selectedDate forceHijri:FALSE forceEnLocale:FALSE];
                endDateMonthLbl.text=[StaticFuntions getMonthForDate:selectedDate forceHijri:FALSE];
                endDateDayLbl.text=[StaticFuntions getDayForDate:selectedDate forceEnLocale:FALSE];
            }
        }
    }
    
    if (done) {
        [self visable_hideDateControl:YES];
    }
    else
    {
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:validateDateError];
    }

    
}

#pragma mark - events

-(IBAction)onPressActions:(UIButton *)sender
{
    RequestObj *obj = [[RequestObj alloc] init];
    if (searching)
        obj=[filteredRequests objectAtIndex:(int)sender.tag];
    else{
        if (selectedType == My) {
            obj = [myRequestsArr objectAtIndex:sender.tag];
        }else if (selectedType == Recieved) {
            obj = [recievedRequestsArr objectAtIndex:sender.tag];
        }else if (selectedType == Completed) {
            obj = [completedRequestsArr objectAtIndex:sender.tag];
        }else if (selectedType == Processed) {
            obj = [processedRequestsArr objectAtIndex:sender.tag];
        }
    }
    
    selectedRequest = obj.requestCode;
    RequestActionsViewController * viewController = [self.storyboard instantiateViewControllerWithIdentifier:SeagueRequestActionsScreen];
    viewController.selectedRequest = selectedRequest;
    [self.navigationController pushViewController:viewController animated:NO];
}


-(IBAction)onPressType:(id)sender
{
    searching = FALSE;
    requestTableView.contentOffset = CGPointMake(0.0, 0.0);
    selectedDirection = @"";
    [self onPressSearchActions:emptyBtn];
    if (sender == myRequestsBtn || sender == myRequestsBackgroundBtn) {
        titleLbl.text = MyRequestsButtonText;
        selectedType = My;
        myRequestsBtn.selected = YES;
        myRequestsBackgroundBtn.selected = YES;
        recievedRequestsBtn.selected = FALSE;
        recievedRequestsBackgroundBtn.selected = FALSE;
        completedRequestsBtn.selected = FALSE;
        completedRequestsBackgroundBtn.selected = FALSE;
        processedRequestsBtn.selected = FALSE;
        processedRequestsBackgroundBtn.selected = FALSE;
        
        if (myRequestsCount > 0 && [myRequestsArr count] == 0)
            [self connect:@"" withDirection:selectedDirection withCategory:@"mine" withFilteredServiceCode:@"" withFilteredRequesterFilter:@"" withFilteredFromDate:@"" withFilteredToDate:@"" withFilteredRequestCode:@""];
    }else if (sender == recievedRequestsBtn || sender == recievedRequestsBackgroundBtn) {
        titleLbl.text = RecievedRequestsButtonText;
        selectedType = Recieved;
        myRequestsBtn.selected = FALSE;
        myRequestsBackgroundBtn.selected = FALSE;
        recievedRequestsBtn.selected = YES;
        recievedRequestsBackgroundBtn.selected = YES;
        completedRequestsBtn.selected = FALSE;
        completedRequestsBackgroundBtn.selected = FALSE;
        processedRequestsBtn.selected = FALSE;
        processedRequestsBackgroundBtn.selected = FALSE;
        
        if (recievedCount > 0 && [recievedRequestsArr count] == 0)
            [self connect:@"" withDirection:selectedDirection withCategory:@"inbox" withFilteredServiceCode:@"" withFilteredRequesterFilter:@"" withFilteredFromDate:@"" withFilteredToDate:@"" withFilteredRequestCode:@""];
        
    }else if (sender == completedRequestsBtn || sender == completedRequestsBackgroundBtn) {
        titleLbl.text = CompletedRequestsButtonText;
        selectedType = Completed;
        myRequestsBtn.selected = FALSE;
        myRequestsBackgroundBtn.selected = FALSE;
        recievedRequestsBtn.selected = FALSE;
        recievedRequestsBackgroundBtn.selected = FALSE;
        completedRequestsBtn.selected = YES;
        completedRequestsBackgroundBtn.selected = YES;
        processedRequestsBtn.selected = FALSE;
        processedRequestsBackgroundBtn.selected = FALSE;
        if (completedCount > 0 && [completedRequestsArr count] == 0)
            [self connect:@"" withDirection:selectedDirection withCategory:@"completed" withFilteredServiceCode:@"" withFilteredRequesterFilter:@"" withFilteredFromDate:@"" withFilteredToDate:@"" withFilteredRequestCode:@""];
    }else if (sender == processedRequestsBtn || sender == processedRequestsBackgroundBtn) {
        titleLbl.text = ProcessedRequestsButtonText;
        selectedType = Processed;
        myRequestsBtn.selected = FALSE;
        myRequestsBackgroundBtn.selected = FALSE;
        recievedRequestsBtn.selected = FALSE;
        recievedRequestsBackgroundBtn.selected = FALSE;
        completedRequestsBtn.selected = FALSE;
        completedRequestsBackgroundBtn.selected = FALSE;
        processedRequestsBtn.selected = YES;
        processedRequestsBackgroundBtn.selected = YES;
        if (processedCount > 0 && [processedRequestsArr count] == 0)
            [self connect:@"" withDirection:selectedDirection withCategory:@"processed" withFilteredServiceCode:@"" withFilteredRequesterFilter:@"" withFilteredFromDate:@"" withFilteredToDate:@"" withFilteredRequestCode:@""];
    }
    
    [requestTableView reloadData];
}


-(IBAction)onPressSearch:(id)sender
{
    if (sender == searchBtn) {
        backgroundView.hidden = FALSE;
        searchView.hidden = FALSE;
        searchBtn.hidden = YES;
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        if(appDelegate.currentLang==English)
            [self switchToLeftLayoutSearchView];
        else
            [self switchToRightLayoutSearchView];
        
    }
    [self hideKeyboard];
    
}
-(void)  emptyAction{
    searching = FALSE;
    requestValTxt.text = @"";
    senderValTxt.text = @"";
    serviceValTxt.text = @"";
    
    startDateDayLbl.text = @"--";
    startDateMonthLbl.text = @"--------";
    startDateYearLbl.text = @"----";
    
    endDateDayLbl.text = @"--";
    endDateMonthLbl.text = @"--------";
    endDateYearLbl.text = @"----";
    
}
-(void)actionDon{
    backgroundView.hidden = YES;
    searchView.hidden = YES;
    searchBtn.hidden = FALSE;
    
    if (![StaticFuntions isStringEmpty:serviceValTxt.text] || ![StaticFuntions isStringEmpty:senderValTxt.text] || ![StaticFuntions isStringEmpty:requestValTxt.text] || ![startDateDayLbl.text isEqualToString:@"--"] || ![endDateDayLbl.text isEqualToString:@"--"]) {
        searching = YES;
    }
    
    if (searching) {
        RequestFilterObj *obj = [[RequestFilterObj alloc] init];
        obj = [self checkFilterData];
        if (obj != nil) {
            NSString *selectedCategory;
            if (selectedType == My){
                selectedCategory = @"mine";
            }else if (selectedType == Recieved){
                selectedCategory = @"inbox";
            }else if (selectedType == Completed){
                selectedCategory = @"completed";
            }else if (selectedType == Processed){
                selectedCategory = @"processed";
            }
            selectedDirection = @"";
            selectedRequest = @"";
            filteredRequests = [[NSMutableArray alloc] init];
            [self connect:selectedRequest withDirection:selectedDirection withCategory:selectedCategory withFilteredServiceCode:obj.serviceCode withFilteredRequesterFilter:obj.requesterFilter withFilteredFromDate:obj.fromDate withFilteredToDate:obj.toDate withFilteredRequestCode:obj.requestCode];
            requestTableView.contentOffset = CGPointMake(0.0, 0.0);
            
            if (filterListBackBtn.hidden) {
                CGRect frame = requestTableView.frame;
                frame.size.height -= 60;
                requestTableView.frame = frame;
                filterListBackBtn.hidden = FALSE;
            }
        }
    }
    else
    {
        searching = FALSE;
        [requestTableView reloadData];
        if (filterListBackBtn.hidden == FALSE) {
            filterListBackBtn.hidden = YES;
            CGRect frame = requestTableView.frame;
            frame.size.height += 60;
            requestTableView.frame = frame;
        }
    }
    
    
}

-(IBAction)onPressSearchActions:(id)sender
{
    if (sender == backBtn)
    {
        backgroundView.hidden = YES;
        searchView.hidden = YES;
        
        searchBtn.hidden = FALSE;
        [self emptyAction];
    }
   else  if (sender == backBtnEnglish)
    {
        backgroundView.hidden = YES;
        searchView.hidden = YES;
        
        searchBtn.hidden = FALSE;
        [self emptyAction];
    }
    else if (sender == emptyBtn)
    {
        [self emptyAction];
    }
    else if (sender == emptyBtnEnglish)
    {
        [self emptyAction];
    }
    else if (sender == doneBtn)
    {
        
        if([self isNetworkAvailable] ==YES)
        {
            NSLog(@"Network Connection available");
            [self actionDon];
        }
        
        else{
            [StaticFuntions showAlertWithTitle:NetWorkTitle Message:NetWorkBody];
            
        }
        
        
    }
    else if (sender == doneBtnEnglish)
    {
        
        if([self isNetworkAvailable] ==YES)
        {
            NSLog(@"Network Connection available");
            [self actionDon];
        }
        
        else{
            [StaticFuntions showAlertWithTitle:NetWorkTitle Message:NetWorkBody];
            
        }
    }
    else if (sender == filterListBackBtn)
    {
        
        requestValTxt.text = @"";
        senderValTxt.text = @"";
        serviceValTxt.text = @"";
        
        startDateDayLbl.text = @"--";
        startDateMonthLbl.text = @"--------";
        startDateYearLbl.text = @"----";
        
        endDateDayLbl.text = @"--";
        endDateMonthLbl.text = @"--------";
        endDateYearLbl.text = @"----";
        
        searching = FALSE;
        [requestTableView reloadData];
        
        filterListBackBtn.hidden = YES;
        CGRect frame = requestTableView.frame;
        frame.size.height += 60;
        requestTableView.frame = frame;
    }
    
    [self hideKeyboard];
    
}


-(IBAction)onPressSearchServicesActions:(id)sender{
    [self hideKeyboard];
    
    if (sender == serviceSearchBtn) {
        [self previewListOfServices];
    }
    else if (sender == searchServicesCancelbtn){
        servicesSearchView.hidden = YES;
    }
    else if (sender == searchServicesCancelbtnEng){
        servicesSearchView.hidden = YES;
    }
    else if (sender == searchServicesChoosebtn)
    {
        [self serviceSearchChoose];
    }
    else if (sender == searchServicesChoosebtnEng)
    {
        [self serviceSearchChoose];
    }
    
}

-(void)serviceSearchChoose{
    if (serviceSelectedRowRequests == -1)
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:delegationServiceNameMandatoryMsg];
    else
    {
        self.servicesSearchView.hidden = YES;
        ServicesObj *obj;
        obj = [listOfServices objectAtIndex:serviceSelectedRowRequests];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        if(appDelegate.currentLang==English)
            serviceValTxt.text = obj.serviceNameEn;
        else if(appDelegate.currentLang==Arabic)
            serviceValTxt.text = obj.serviceNameAr;
    }
}


-(IBAction)onselectdatePressed:(id)sender{
    
    NSString *stringDate;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df = [self initilizeDateFormatter];
    
    BOOL firstTime = YES;
    
    if (sender == startDateChangeBtn1 || sender == startDateChangeBtn2) {
        targetDateView = @"SearchStartDate";
        if (![startDateYearLbl.text isEqualToString:@"----"]) {
            stringDate = [self concatinateDateString:startDateDayLbl.text month:startDateMonthLbl.text year:startDateYearLbl.text];
            firstTime = FALSE;
        }
        
    }
    else if (sender == endDateChangeBtn1 || sender == endDateChangeBtn2) {
        targetDateView = @"SearchEndDate";
        if (![endDateYearLbl.text isEqualToString:@"----"]) {
            stringDate = [self concatinateDateString:endDateDayLbl.text month:endDateMonthLbl.text year:endDateYearLbl.text];
            
            firstTime = FALSE;
        }
    }
    if (!firstTime) {
        startDate = [df dateFromString:stringDate];
        [dateView.picker setDate:startDate];
    }
    else
    {
        startDate = [NSDate date];//[df dateFromString:stringDate];
        [dateView.picker setDate:startDate];
    }
    
    [self visable_hideDateControl:NO];
    [self hideKeyboard];
}

#pragma mark - refresh

- (void)refresh:(UIRefreshControl *)refreshControl_ {
    noDataLbl.hidden=YES;
    
    NSString *selectedCategory;
    RequestObj *obj = nil;
    
    if (searching) {
        if ([filteredRequests count] > 0)
            obj = [filteredRequests objectAtIndex:0];
    }else{
     
        
        if (selectedType == My){
            if ([myRequestsArr count] > 0) {
                obj = [myRequestsArr objectAtIndex:0];
            }
        }else if (selectedType == Recieved){
            if ([recievedRequestsArr count] > 0) {
                obj = [recievedRequestsArr objectAtIndex:0];
            }
        }
        else if (selectedType == Completed){
            if ([completedRequestsArr count] > 0) {
                obj = [completedRequestsArr objectAtIndex:0];
            }
        }else if (selectedType == Processed){
            if ([processedRequestsArr count] > 0) {
                obj = [processedRequestsArr objectAtIndex:0];
            }
        }
    }
    if (obj != nil) {
        if (selectedType == My)
            selectedCategory = @"mine";
        else if (selectedType == Recieved)
            selectedCategory = @"inbox";
        else if (selectedType == Completed)
            selectedCategory = @"completed";
        else if (selectedType == Processed)
            selectedCategory = @"processed";
        
        selectedDirection = @"up";
        selectedRequest = obj.requestCode;
        
        [self connect:selectedRequest withDirection:selectedDirection withCategory:selectedCategory withFilteredServiceCode:@"" withFilteredRequesterFilter:@"" withFilteredFromDate:@"" withFilteredToDate:@"" withFilteredRequestCode:@""];
    }
    

}


@end
