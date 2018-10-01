//
//  DocInfoViewController.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 11/26/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "BaseViewController.h"
#import "ForgetPWObj.h"
#import "DataTransfer.h"
#import "HijriDateView.h"
#import "HijriDateYearView.h"

@interface DocInfoViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate,UITextFieldDelegate,DataTransferDelegate>{
    
    NSString *parentName;
    
    UIButton *byIDBtn;
    UILabel *byIDLbl;
    
    UIView *docIDView;
    UITextField *docIDTxt;
    UIButton *changeDate1Btn;
    UILabel *dayLbl;
    UILabel *monthLbl;
    UILabel *yearLbl;
    UIButton *changeDate2Btn;
    UIButton *ShowDocAgencyLstBtn;
    UIView *docAgencyIDView;
    UITextField *docAgencyTxt;
    UIView *docAgencyNameView;
    UILabel *DocAgencyNameLbl;
    
    HijriDateView *dateView;
    UIView *bgForDate;
    NSDate *date;
    
    UIButton *byLogBookBtn;
    UILabel *byLogBookLbl;
    
    UIView *logBookView;
    UITextField *logBookTxt;
    UIButton *changeYear1Btn;
    UILabel *logBookyearLbl;
    UIButton *changeYear2Btn;
    HijriDateYearView *yearView;
    

    UILabel *logBookIDHeader;
    UILabel *logBookIDResult;
    UILabel *logBookDateHeader;
    UILabel *logBookDateResult;
    UILabel *logBookStatusHeader;
    UILabel *logBookStatusResult;
    UIButton *backBtn;
    
    UILabel *titleLbl;
    UILabel *resultTitleLbl;
    
    UIButton *SearchBtn;
    ForgetPWObj *FPWObj;
    NSString *enteredUserName;
    UIView *controlsView;
    UIView *resultView;
    
    
    
    IBOutlet UIView *searchBarview;
    IBOutlet UISearchBar *externalDocsearchBar;
    IBOutlet UITableView *externalDoctblView;
    NSMutableArray	*ListOfexternalDoctblView;
    NSMutableArray	*filteredListOfexternalDoctblView;
    UIButton *searchCancelbtn;
    UIButton *searchChoosebtn;
    UIButton *searchCancelbtnEng;
    UIButton *searchChoosebtnEng;
    UIButton *backTologin;
    
    BOOL searching;
    BOOL letUserSelectRow;
}
@property(nonatomic,retain) NSString *parentName;
@property(nonatomic,retain) IBOutlet UIButton *byIDBtn;
@property(nonatomic,retain) IBOutlet UILabel *byIDLbl;

@property(nonatomic,retain) IBOutlet UIView *docIDView;
@property(nonatomic,retain) IBOutlet UITextField *docIDTxt;
@property(nonatomic,retain) IBOutlet UIButton *backTologin;
@property(nonatomic,retain) IBOutlet UIButton *changeDate1Btn;
@property(nonatomic,retain) IBOutlet UILabel *dayLbl;
@property(nonatomic,retain) IBOutlet UILabel *monthLbl;
@property(nonatomic,retain) IBOutlet UILabel *yearLbl;
@property(nonatomic,retain) IBOutlet UIButton *changeDate2Btn;
@property(nonatomic,retain) IBOutlet UIButton *ShowDocAgencyLstBtn;
@property(nonatomic,retain) IBOutlet UIView *docAgencyIDView;
@property(nonatomic,retain) IBOutlet UITextField *docAgencyTxt;
@property(nonatomic,retain) IBOutlet UIView *docAgencyNameView;
@property(nonatomic,retain) IBOutlet UILabel *DocAgencyNameLbl;

@property(nonatomic,retain) IBOutlet HijriDateView *dateView;
@property(nonatomic,retain) IBOutlet UIView *bgForDate;

@property(nonatomic,retain) IBOutlet UIButton *byLogBookBtn;
@property(nonatomic,retain) IBOutlet UILabel *byLogBookLbl;

@property(nonatomic,retain) IBOutlet UIView *logBookView;
@property(nonatomic,retain) IBOutlet UITextField *logBookTxt;
@property(nonatomic,retain) IBOutlet UIButton *changeYear1Btn;
@property(nonatomic,retain) IBOutlet UILabel *logBookyearLbl;
@property(nonatomic,retain) IBOutlet UIButton *changeYear2Btn;
@property(nonatomic,retain) IBOutlet HijriDateYearView *yearView;

@property(nonatomic,retain) IBOutlet UILabel *logBookIDHeader;
@property(nonatomic,retain) IBOutlet UILabel *logBookIDResult;
@property(nonatomic,retain) IBOutlet UILabel *logBookDateHeader;
@property(nonatomic,retain) IBOutlet UILabel *logBookDateResult;
@property(nonatomic,retain) IBOutlet UILabel *logBookStatusHeader;
@property(nonatomic,retain) IBOutlet UILabel *logBookStatusResult;
@property(nonatomic,retain) IBOutlet UIButton *backBtn;

@property(nonatomic,retain) IBOutlet UILabel *titleLbl;
@property(nonatomic,retain) IBOutlet UILabel *resultTitleLbl;

@property(nonatomic,retain) IBOutlet UIButton *SearchBtn;


@property(nonatomic,retain) IBOutlet UIView *controlsView;
@property(nonatomic,retain) IBOutlet UIView *resultView;


@property(nonatomic,retain) IBOutlet UIView *searchBarview;
@property(nonatomic,retain) IBOutlet UISearchBar *externalDocsearchBar;
@property(nonatomic,retain) IBOutlet UITableView *externalDoctblView;
@property(nonatomic,retain) NSMutableArray	*ListOfexternalDoctblView;
@property(nonatomic,retain) NSMutableArray	*filteredListOfexternalDoctblView;
@property(nonatomic,retain) IBOutlet UIButton *searchCancelbtn;
@property(nonatomic,retain) IBOutlet UIButton *searchChoosebtn;

@property(nonatomic,retain) IBOutlet UIButton *searchCancelbtnEng;
@property(nonatomic,retain) IBOutlet UIButton *searchChoosebtnEng;


@property(nonatomic) BOOL searching;
@property(nonatomic) BOOL letUserSelectRow;

-(IBAction)onShowDocExternalPressed:(id)sender;
-(IBAction)onChangeYearPressed:(id)sender;
-(IBAction)onselectdatePressed:(id)sender;
-(IBAction)onSearchPressed:(id)sender;
-(IBAction)onBackPressed:(id)sender;
-(IBAction)doneSearching_Clicked:(id)sender;



// for custom  menu  bar  
@property (weak, nonatomic) IBOutlet UIButton *menuBtn;
@property (weak, nonatomic) IBOutlet UIButton *homeBtn;
- (IBAction)btnHomeOrMenuPress:(UIButton *)sender;


@end
