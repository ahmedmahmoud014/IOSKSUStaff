//
//  DocInfoViewController.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 11/26/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "DocInfoViewController.h"
#import "ExternalDocumentUnitObj.h"
#import "ExternalDocumentUnitTableViewCell.h"
#import "LocalizedMessages.h"
#import <QuartzCore/QuartzCore.h>
#import "StaticFuntions.h"
#import "RequestManager.h"
#import "DocInfoObj.h"
#import "AppDelegate.h"

@interface DocInfoViewController ()

@end

@implementation DocInfoViewController


@synthesize parentName,byIDBtn,byIDLbl;
@synthesize docIDView,docIDTxt,changeDate1Btn,dayLbl,monthLbl,yearLbl,changeDate2Btn,ShowDocAgencyLstBtn,docAgencyIDView,docAgencyTxt,docAgencyNameView,DocAgencyNameLbl;
@synthesize dateView,bgForDate;

@synthesize searchBarview,externalDocsearchBar;

@synthesize externalDoctblView,ListOfexternalDoctblView,filteredListOfexternalDoctblView,searchCancelbtn,searchChoosebtn,searchCancelbtnEng
,searchChoosebtnEng;
@synthesize searching,letUserSelectRow;


@synthesize logBookView,byLogBookBtn,byLogBookLbl;
@synthesize logBookTxt,changeYear1Btn,logBookyearLbl,changeYear2Btn,yearView;
@synthesize logBookIDHeader,logBookIDResult,logBookDateHeader,logBookDateResult,logBookStatusHeader,logBookStatusResult,backBtn;
@synthesize titleLbl,resultTitleLbl;
@synthesize SearchBtn, backTologin;

@synthesize controlsView,resultView;

NSInteger SelectedRow;
NSInteger previousrow;

- (void)viewDidLoad {
    
    [super viewDidLoad];
  
    
    // navigation  button  replace 
    [self replaceHomeAndMenu:_homeBtn :_menuBtn];

    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.currentLang==English){
        
        searchChoosebtn.hidden=true;
        searchCancelbtn.hidden=true;
    }else{
        searchChoosebtnEng.hidden=true;
        searchCancelbtnEng.hidden=true;
    }
    
    // Do any additional setup after loading the view.
    
    filteredListOfexternalDoctblView = [[NSMutableArray alloc] init];
    
    if ([parentName isEqualToString:@"Login"]) {
        [self customizeNavigationBar:YES WithMenu:NO];
        backTologin.hidden= false;
        CGFloat spacing = 10; // the amount of spacing to appear between image and title
        backTologin.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, spacing);
        backTologin.titleEdgeInsets = UIEdgeInsetsMake(0, spacing, 0, 0);
        
        SearchBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, spacing);
        SearchBtn.titleEdgeInsets = UIEdgeInsetsMake(0, spacing, 0, 0);
    }
    else
    {
        [self customizeNavigationBar:YES WithMenu:YES];
    }
    
    DocAgencyNameLbl.adjustsFontSizeToFitWidth = YES;
    docAgencyTxt.adjustsFontSizeToFitWidth = YES;
    
 
    if(IS_IPAD){
        int x= (self.view.frame.size.width- controlsView.frame.size.width)/2;
        controlsView.frame=CGRectMake(x, controlsView.frame.origin.y, controlsView.frame.size.width, controlsView.frame.size.height);
        resultView.frame=CGRectMake(x, resultView.frame.origin.y, resultView.frame.size.width, resultView.frame.size.height);
    }
    searching=NO;
    letUserSelectRow = YES;
    previousrow = -1;
    SelectedRow = -1;
    
    
    self.externalDoctblView.allowsSelection = YES;
    self.externalDoctblView.allowsSelectionDuringEditing = YES;
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == logBookTxt) {
        CGRect frame = controlsView.frame;
        frame.origin.y -= 45;
        controlsView.frame = frame;
    }
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:true animated:animated];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    BOOL found = FALSE;
    if (textField == docAgencyTxt) {
        
        if (![StaticFuntions isStringEmpty:docAgencyTxt.text]) {
            ExternalDocumentUnitObj *obj;
            for (int i = 0 ; i < [ListOfexternalDoctblView count]; i++) {
                obj = [ListOfexternalDoctblView objectAtIndex:i];
                if ([textField.text isEqualToString:obj.ExternalUnitCode]) {
                    found = YES;
                    DocAgencyNameLbl.text = obj.ExternalUnitName;
                    DocAgencyNameLbl.textColor = [UIColor colorWithRed:130.0/255.0 green:139.0/255.0 blue:147.0/255.0 alpha:1];;
                    break;
                }
            }
            if (found == FALSE) {
                DocAgencyNameLbl.text = noDocOrganizationText;
                DocAgencyNameLbl.textColor = [UIColor redColor];
                
            }
        }
        else
        {
            DocAgencyNameLbl.text = @"";
        }
        
        
        
    }
    if (textField == logBookTxt) {
        CGRect frame = controlsView.frame;
        frame.origin.y += 45;
        controlsView.frame = frame;
    }
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
    
    externalDocsearchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    externalDocsearchBar.showsSearchResultsButton = FALSE;
    externalDocsearchBar.showsCancelButton = FALSE;
    externalDocsearchBar.showsBookmarkButton = FALSE;

    externalDocsearchBar.placeholder = externalDocOrganizationSearchText;
    
    
    for (UIView *subview in externalDocsearchBar.subviews) {
        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            UIView *bg = [[UIView alloc] initWithFrame:subview.frame];
            bg.backgroundColor = [UIColor colorWithRed:(2/255.f) green:(125/255.f) blue:(175/255.f) alpha:1.0];
            [externalDocsearchBar insertSubview:bg aboveSubview:subview];
            [subview removeFromSuperview];
            break;
        }
    }

    
    
    self.BGImage.image= [UIImage imageNamed:@"bg.png"];
    
    [byIDBtn setImage:[UIImage imageNamed:@"radio-empty.png"] forState:UIControlStateNormal];
    [byIDBtn setImage:[UIImage imageNamed:@"radio-selected.png"] forState:UIControlStateSelected];
    
    [byLogBookBtn setImage:[UIImage imageNamed:@"radio-empty.png"] forState:UIControlStateNormal];
    [byLogBookBtn setImage:[UIImage imageNamed:@"radio-selected.png"] forState:UIControlStateSelected];
    
    byIDBtn.selected=YES;
    
    [logBookTxt setEnabled:NO];
    
    dateView.hidden=YES;
    [dateView initIslamicDateWithMonths:YES withDay:YES withDelegate:self withMaxDate:YES withMinDate:FALSE isForceHijri:NO];
    
    date=[NSDate date];
    
    yearView.hidden=YES;

    [yearView initIslamicDatewithDelegate:self];
    
    changeDate1Btn.enabled = YES;
    changeDate2Btn.enabled = YES;
    ShowDocAgencyLstBtn.enabled = YES;
    
    changeYear1Btn.enabled = FALSE;
    changeYear2Btn.enabled = FALSE;
    
    
    [self initBGViews];
}

-(void)locatizeLables{
    titleLbl.text=DocInfoLblText;
    
    
    byIDLbl.text =ByIDLblText;
    byLogBookLbl.text =byLogBookLblText;
    
    UIColor *color = [UIColor colorWithRed:130.0/255.0 green:139.0/255.0 blue:147.0/255.0 alpha:1];

    
    docIDTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:docIDText attributes:@{NSForegroundColorAttributeName:color}];
    
    docAgencyTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:docOrganizationText attributes:@{NSForegroundColorAttributeName:color}];
    
    logBookTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:logBookText attributes:@{NSForegroundColorAttributeName:color}];

    
    [SearchBtn setTitle:SearchButtonText forState:UIControlStateNormal];
    [backBtn setTitle:BackButtonText forState:UIControlStateNormal];
    [backTologin setTitle:BackButtonText forState:UIControlStateNormal];
    [searchCancelbtn setTitle:BackButtonText forState:UIControlStateNormal];
    [searchChoosebtn setTitle:ChooseButtonText forState:UIControlStateNormal];
    
    [searchCancelbtnEng setTitle:BackButtonText forState:UIControlStateNormal];
    [searchChoosebtnEng setTitle:ChooseButtonText forState:UIControlStateNormal];
    
    logBookIDHeader.text=logBookIDHeaderText;
    logBookDateHeader.text=logBookDateHeaderText;
    logBookStatusHeader.text=logBookStatusHeaderText;
    
    
    
    dayLbl.text=[StaticFuntions getTodayDay:FALSE];
    monthLbl.text=[StaticFuntions getTodayMonth:FALSE];
    yearLbl.text=[StaticFuntions getTodayYear:FALSE];
    
    logBookyearLbl.text=[StaticFuntions getTodayYear:FALSE];
    [externalDocsearchBar setReturnKeyType:UIReturnKeyDone];
    [docIDTxt setReturnKeyType:UIReturnKeyDone];
    [docAgencyTxt setReturnKeyType:UIReturnKeyDone];
    [logBookTxt setReturnKeyType:UIReturnKeyDone];
    
}



-(void)switchToLeftLayout{
    
    NSTextAlignment align=NSTextAlignmentLeft;
    titleLbl.textAlignment=align;
    resultTitleLbl.textAlignment=align;
    
    docIDTxt.textAlignment=align;
    docAgencyTxt.textAlignment=align;
    DocAgencyNameLbl.textAlignment=align;
    logBookTxt.textAlignment=align;
    
    UITextField *searchField;
    for (UIView *subview in self.externalDocsearchBar.subviews)
    {
        if ([subview isKindOfClass:[UITextField class]]) {
            searchField = (UITextField *)subview;
            break;
        }
    }
    if (searchField) {
        searchField.textAlignment = align;
    }
    
    byIDLbl.textAlignment=align;
    byLogBookLbl.textAlignment=align;
    
    logBookIDHeader.textAlignment=align;
    logBookIDResult.textAlignment=align;
    logBookDateHeader.textAlignment=align;
    logBookDateResult.textAlignment=align;
    logBookStatusHeader.textAlignment=align;
    logBookStatusResult.textAlignment=align;
    
    CGRect frame = byIDBtn.frame;
    frame.origin.x = 10;
    byIDBtn.frame = frame;
    
    frame = byIDLbl.frame;
    frame.origin.x = byIDBtn.frame.origin.x + byIDBtn.frame.size.width + 5;
    byIDLbl.frame = frame;
    
    frame = byLogBookBtn.frame;
    frame.origin.x = 10;
    byLogBookBtn.frame = frame;
    
    frame = byLogBookLbl.frame;
    frame.origin.x = byLogBookBtn.frame.origin.x + byLogBookBtn.frame.size.width + 5;
    byLogBookLbl.frame = frame;
    
    
    frame = docAgencyIDView.frame;
    frame.origin.x = 5;
    docAgencyIDView.frame = frame;
    
    
    frame = docAgencyNameView.frame;
    frame.origin.x = docAgencyIDView.frame.origin.x + docAgencyIDView.frame.size.width + 5;
    docAgencyNameView.frame = frame;
    
    
    frame = ShowDocAgencyLstBtn.frame;
    frame.origin.x = docAgencyNameView.frame.origin.x + docAgencyNameView.frame.size.width + 5;
    ShowDocAgencyLstBtn.frame = frame;
    
    
    
    frame = logBookIDHeader.frame;
    frame.origin.x = 5;
    logBookIDHeader.frame = frame;
    
    frame = logBookIDResult.frame;
    frame.origin.x = logBookIDHeader.frame.origin.x + logBookIDHeader.frame.size.width + 5;
    logBookIDResult.frame = frame;
    
    frame = logBookDateHeader.frame;
    frame.origin.x = 5;
    logBookDateHeader.frame = frame;
    
    frame = logBookDateResult.frame;
    frame.origin.x = logBookDateHeader.frame.origin.x + logBookDateHeader.frame.size.width + 5;
    logBookDateResult.frame = frame;
    
    
    frame = logBookStatusHeader.frame;
    frame.origin.x = 10;
    logBookStatusHeader.frame = frame;
    
    frame = logBookStatusResult.frame;
    frame.origin.x = logBookStatusHeader.frame.origin.x + logBookStatusHeader.frame.size.width + 5;
    logBookStatusResult.frame = frame;
    
    
    
    
}

-(void)switchToRightLayout{
    
    NSTextAlignment align=NSTextAlignmentRight;
    titleLbl.textAlignment=align;
    resultTitleLbl.textAlignment=align;
    docIDTxt.textAlignment=align;
    docAgencyTxt.textAlignment=align;
    DocAgencyNameLbl.textAlignment=align;
    logBookTxt.textAlignment=align;
    
    byIDLbl.textAlignment=align;
    byLogBookLbl.textAlignment=align;
    
    UITextField *searchField;
    for (UIView *subview in self.externalDocsearchBar.subviews)
    {
        if ([subview isKindOfClass:[UITextField class]]) {
            searchField = (UITextField *)subview;
            break;
        }
    }
    if (searchField) {
        searchField.textAlignment = align;
    }
    
    
    logBookIDHeader.textAlignment=align;
    logBookIDResult.textAlignment=align;
    logBookDateHeader.textAlignment=align;
    logBookDateResult.textAlignment=align;
    logBookStatusHeader.textAlignment=align;
    logBookStatusResult.textAlignment=align;
    
    
    CGRect frame = byIDLbl.frame;
    frame.origin.x = 10;
    byIDLbl.frame = frame;
    
    frame = byIDBtn.frame;
    frame.origin.x = byIDLbl.frame.origin.x + byIDLbl.frame.size.width + 5;
    byIDBtn.frame = frame;
    
    frame = byLogBookLbl.frame;
    frame.origin.x = 10;
    byLogBookLbl.frame = frame;
    
    frame = byLogBookBtn.frame;
    frame.origin.x = byLogBookLbl.frame.origin.x + byLogBookLbl.frame.size.width + 5;
    byLogBookBtn.frame = frame;
    
    frame = ShowDocAgencyLstBtn.frame;
    frame.origin.x = 5;
    ShowDocAgencyLstBtn.frame = frame;
    
    
    frame = docAgencyNameView.frame;
    frame.origin.x = ShowDocAgencyLstBtn.frame.origin.x + ShowDocAgencyLstBtn.frame.size.width + 5;
    docAgencyNameView.frame = frame;
    
    frame = docAgencyIDView.frame;
    frame.origin.x = docAgencyNameView.frame.origin.x + docAgencyNameView.frame.size.width + 5;
    docAgencyIDView.frame = frame;
 
    
    frame = logBookIDResult.frame;
    frame.origin.x = 10;
    logBookIDResult.frame = frame;
    
    frame = logBookIDHeader.frame;
    frame.origin.x = logBookIDResult.frame.origin.x + logBookIDResult.frame.size.width + 5;
    logBookIDHeader.frame = frame;
    
    frame = logBookDateResult.frame;
    frame.origin.x = 10;
    logBookDateResult.frame = frame;
    
    frame = logBookDateHeader.frame;
    frame.origin.x = logBookDateResult.frame.origin.x + logBookDateResult.frame.size.width + 5;
    logBookDateHeader.frame = frame;
    
    frame = logBookStatusResult.frame;
    frame.origin.x = 10;
    logBookStatusResult.frame = frame;
    
    frame = logBookStatusHeader.frame;
    frame.origin.x = logBookStatusResult.frame.origin.x + logBookStatusResult.frame.size.width + 5;
    logBookStatusHeader.frame = frame;
    
}


#pragma mark - Search delegate

- (void) searchBarTextDidBeginEditing:(UISearchBar *)theSearchBar {
    
    if(![theSearchBar.text isEqualToString:@""])
    {
        searching = YES;
        
        return;
    }
    
    
}

- (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText {
    
    //Remove all objects first.
    [filteredListOfexternalDoctblView removeAllObjects];
    
    if([searchText length] > 0) {
        
        searching = YES;
        letUserSelectRow = YES;
        [self searchTableView];
    }
    else {
        searching = NO;
        [theSearchBar resignFirstResponder];
    }
    
    
    [self.externalDoctblView reloadData];
    
    
    ExternalDocumentUnitObj *obj;
    NSString *objID = @"";
    if (searching) {
        for (int i = 0 ; i < [filteredListOfexternalDoctblView count]; i++) {
            obj = [self.filteredListOfexternalDoctblView objectAtIndex:i];
        
            objID = obj.ExternalUnitID;
            
            if (([objID integerValue] -1) == SelectedRow) {
                
                NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
                [externalDoctblView selectRowAtIndexPath:selectedIndexPath animated:YES  scrollPosition:UITableViewScrollPositionBottom];
                break;
            }
        }
    }
    else
    {
        for (int i = 0 ; i < [ListOfexternalDoctblView count]; i++) {
            obj = [self.ListOfexternalDoctblView objectAtIndex:i];
            
            objID = obj.ExternalUnitID;
            
            if (([objID integerValue] -1) == SelectedRow) {
                
                NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
                [externalDoctblView selectRowAtIndexPath:selectedIndexPath animated:YES  scrollPosition:UITableViewScrollPositionBottom];
                break;
            }
        }
        
    }
    
}



-(void)searchBarTextDidEndEditing:(UISearchBar *)thesearchBar
{
    
}


- (void) doneSearching_Clicked:(id)sender {
    
    externalDocsearchBar.text = @"";
    [externalDocsearchBar resignFirstResponder];
    
    letUserSelectRow = YES;
    searching = NO;
    

    
}


-(void)searchBarCancelButtonClicked:(UISearchBar *)theSearchBar
{
    
    letUserSelectRow = YES;
    searching = NO;
    
    ///self.AssignedtotblView.scrollEnabled = YES;
    theSearchBar.text = @"";
    [theSearchBar resignFirstResponder];
    
    
    [self.externalDoctblView reloadData];
    
    
    externalDocsearchBar.text = @"";
    [externalDocsearchBar resignFirstResponder];
    
    letUserSelectRow = YES;
    searching = NO;
    

    [self.externalDoctblView reloadData];
    
    ExternalDocumentUnitObj *obj;
    NSString *objID;
    for (int i = 0 ; i < [ListOfexternalDoctblView count]; i++) {
        obj = [self.ListOfexternalDoctblView objectAtIndex:i];
        
        objID = obj.ExternalUnitID;
        
        if (([objID integerValue] -1) == SelectedRow) {
            
            NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [externalDoctblView selectRowAtIndexPath:selectedIndexPath animated:YES  scrollPosition:UITableViewScrollPositionBottom];
            break;
        }
    }
    
    
    
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)theSearchBar {
    
    
    [theSearchBar resignFirstResponder];
    
    
}

- (void) searchTableView {
    
    filteredListOfexternalDoctblView = [[NSMutableArray alloc] init];
    
    NSString *searchText = externalDocsearchBar.text;

    for (ExternalDocumentUnitObj *item in self.ListOfexternalDoctblView )
    {
        
        NSRange titleResultsRange = [item.ExternalUnitName rangeOfString:searchText options:NSCaseInsensitiveSearch];
        
        if (titleResultsRange.length > 0)
        {
            [filteredListOfexternalDoctblView addObject:item];
        }
    }
    
    [self.externalDoctblView reloadData];
    
}






#pragma mark - touch delegate
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([docIDTxt isFirstResponder] && [touch view] != docIDTxt) {
        [docIDTxt resignFirstResponder];
    }
    if ([docAgencyTxt isFirstResponder] && [touch view] != docAgencyTxt) {
        [docAgencyTxt resignFirstResponder];
    }
    if ([logBookTxt isFirstResponder] && [touch view] != logBookTxt) {
        [logBookTxt resignFirstResponder];
    }
    if ([externalDocsearchBar isFirstResponder] && [touch view] != externalDocsearchBar) {
        [externalDocsearchBar resignFirstResponder];
    }
    
    [super touchesBegan:touches withEvent:event];
}

#pragma mark - events

-(IBAction)onShowDocExternalPressed:(id)sender{
    [self hideKeyboard];
    previousrow = -1;
    externalDocsearchBar.text = @"";
    
    if (sender == ShowDocAgencyLstBtn) {
        searching = NO;
        letUserSelectRow = YES;
        [externalDoctblView reloadData];
        
        if (![docAgencyTxt.text isEqualToString:@""] && ![StaticFuntions isStringEmpty:docAgencyTxt.text]) {
            
            ExternalDocumentUnitObj *obj;
            for (int i = 0 ; i < [ListOfexternalDoctblView count]; i++) {
                obj = [ListOfexternalDoctblView objectAtIndex:i];
                if ([docAgencyTxt.text isEqualToString:obj.ExternalUnitCode]) {
                    SelectedRow = i;
                }
            }
            NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:SelectedRow inSection:0];
            previousrow = SelectedRow;
            
            if (SelectedRow  != -1)
            [externalDoctblView selectRowAtIndexPath:selectedIndexPath animated:YES  scrollPosition:UITableViewScrollPositionBottom];
            
            //ExternalDocumentUnitTableViewCell *cell = [self.externalDoctblView cellForRowAtIndexPath:selectedIndexPath];
            
            
                    //[cell.titleLbl setTextColor:[UIColor whiteColor]];
                    //[cell.IDLbl setTextColor:[UIColor whiteColor]];
            
        }
        
        
        
        searchBarview.hidden = FALSE;
        bgForDate.hidden = FALSE;
    }
    else if (sender == searchCancelbtn)
    {
        
        searchBarview.hidden = YES;
        bgForDate.hidden = YES;
    }
    else if (sender == searchCancelbtnEng)
    {
        
        searchBarview.hidden = YES;
        bgForDate.hidden = YES;
    }
    else if (sender == searchChoosebtn)
    {
        
        [self searchChooose];
}
    else if (sender == searchChoosebtnEng)
    {
        
        [self searchChooose];
    }
}
-(void) searchChooose{
    if (SelectedRow == -1) {
        [StaticFuntions showAlertWithTitle:externalDocOrganizationSearchText Message:externalDocOrganizationSearchErrorText];
    }
    else
    {
        self.bgForDate.hidden = YES;
        self.searchBarview.hidden = YES;
        
        
        searching = NO;
        letUserSelectRow = YES;
        
        
        ExternalDocumentUnitObj *obj;
        if (searching) {
            obj = [filteredListOfexternalDoctblView objectAtIndex:SelectedRow];
        }
        else
        {
            obj = [ListOfexternalDoctblView objectAtIndex:SelectedRow];
        }
        
        
        DocAgencyNameLbl.text = obj.ExternalUnitName;
        DocAgencyNameLbl.textColor = [UIColor colorWithRed:130.0/255.0 green:139.0/255.0 blue:147.0/255.0 alpha:1];;
        
        docAgencyTxt.text = obj.ExternalUnitCode;
    }

}

-(IBAction)onChangeYearPressed:(id)sender{
    [self visable_hideYearControl:NO];
    
    [self hideKeyboard];
}

-(IBAction)onChangeSearchPressed:(id)sender{

    if (sender == byIDBtn) {
        if (byIDBtn.selected == FALSE) {
            byIDBtn.selected=YES;
            byLogBookBtn.selected=FALSE;
            
            [logBookTxt setEnabled:NO];
            [docIDTxt setEnabled:YES];
            [docAgencyTxt setEnabled:YES];
            
            changeDate1Btn.enabled = YES;
            changeDate2Btn.enabled = YES;
            ShowDocAgencyLstBtn.enabled = YES;
            
            changeYear1Btn.enabled = FALSE;
            changeYear2Btn.enabled = FALSE;
            
        }
    }
    else
    {
        if (byLogBookBtn.selected == FALSE) {
            byIDBtn.selected=FALSE;
            byLogBookBtn.selected=YES;
            
            [logBookTxt setEnabled:YES];
            
            [docIDTxt setEnabled:NO];
            [docAgencyTxt setEnabled:NO];
            
            changeDate1Btn.enabled = NO;
            changeDate2Btn.enabled = NO;
            ShowDocAgencyLstBtn.enabled = NO;
            
            changeYear1Btn.enabled = YES;
            changeYear2Btn.enabled = YES;
        }
    }
}

-(IBAction)onselectdatePressed:(id)sender{
    [self visable_hideDateControl:NO];
    [self hideKeyboard];
}
-(IBAction)onSearchPressed:(id)sender{
    [self hideKeyboard];
    
    if([self isNetworkAvailable] ==YES)
    {
        NSLog(@"Network Connection available");
        if(![self validate])return;
        [self connect];
    }
    
    else{
        [StaticFuntions showAlertWithTitle:NetWorkTitle Message:NetWorkBody];
        
    }
    
}
-(IBAction)onBackPressed:(id)sender{
    controlsView.hidden =FALSE;
    resultView.hidden = YES;
    resultTitleLbl.hidden=YES;
    
    byIDBtn.selected = YES;
    byLogBookBtn.selected = FALSE;
    
    
    changeDate1Btn.enabled = YES;
    changeDate2Btn.enabled = YES;
    ShowDocAgencyLstBtn.enabled = YES;
    
    changeYear1Btn.enabled = FALSE;
    changeYear2Btn.enabled = FALSE;
    
    
    docIDTxt.enabled = YES;
    docAgencyTxt.enabled = YES;
    
    logBookTxt.enabled=FALSE;
    
    
    docIDTxt.text = @"";
    docAgencyTxt.text = @"";
    DocAgencyNameLbl.text = @"";
    logBookTxt.text = @"";
    
    dayLbl.text=[StaticFuntions getTodayDay:FALSE];
    monthLbl.text=[StaticFuntions getTodayMonth:FALSE];
    yearLbl.text=[StaticFuntions getTodayYear:FALSE];
    
    logBookyearLbl.text=[StaticFuntions getTodayYear:FALSE];
    
    
    
    // Convert string to date object
    /*NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSIslamicCivilCalendar];
    df.dateStyle = NSDateFormatterLongStyle;
    df.dateFormat = @"yyyy/MM/dd";
    NSString *stringDate = [NSString stringWithFormat:@"%@/%@/%@",[StaticFuntions get]];*/
    date = [NSDate date];//[df dateFromString:stringDate];

    
    [dateView initIslamicDateWithMonths:YES withDay:YES withDelegate:self withMaxDate:YES withMinDate:FALSE isForceHijri:NO];
    [dateView.picker setDate:date];
    
    //[yearView initIslamicDatewithDelegate:self];
    [yearView.yearPicker setDate:date];
}

#pragma mark - table delegate

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier=@"ExternalDocumentUnitTableViewCell";
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.currentLang==English)
        CellIdentifier=@"ExternalDocumentUnitTableViewCell_en";
    else
        CellIdentifier=@"ExternalDocumentUnitTableViewCell";
    
    ExternalDocumentUnitTableViewCell *cell = [self.externalDoctblView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell == nil) {
        cell = [[ExternalDocumentUnitTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    
    ExternalDocumentUnitObj *obj;
    if (searching) {
        obj=[filteredListOfexternalDoctblView objectAtIndex:indexPath.row];
    }
    else
    {
        obj=[ListOfexternalDoctblView objectAtIndex:indexPath.row];
    }
    
    [cell initWithExternalDocumentUnitObj:obj withRowId:(int)indexPath.row];
    
    UIView *bgColorView = [[UIView alloc] init];
    //bgColorView.backgroundColor = [UIColor colorWithRed:(88/255.f) green:(133/255.f) blue:(193/255.f) alpha:1.0];
    bgColorView.backgroundColor = [UIColor colorWithRed:(206/255.f) green:(206/255.f) blue:(206/255.f) alpha:1.0];
    //bgColorView.backgroundColor = [UIColor whiteColor];
    bgColorView.layer.masksToBounds = YES;
    [cell setSelectedBackgroundView:bgColorView];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (searching) {
        return [filteredListOfexternalDoctblView count];
    }
    
    return [ListOfexternalDoctblView count];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(UIView*)tableView:(UITableView *)tableView_ viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, externalDoctblView.frame.size.width, 3)];
    [view setBackgroundColor:[UIColor clearColor]];
    return view;
}
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(letUserSelectRow)
        return indexPath;
    else
        return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [self hideKeyboard];
    ///ExternalDocumentUnitTableViewCell *cell = [self.externalDoctblView cellForRowAtIndexPath:indexPath];
    
    if (previousrow != -1 || previousrow != -2) {
        NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:previousrow inSection:0];
    
        if (indexPath.row != previousrow) {
            

           // [cell.titleLbl setTextColor:[UIColor whiteColor]];
            //[cell.IDLbl setTextColor:[UIColor whiteColor]];
            
            
            //selectedIndexPath = [NSIndexPath indexPathForRow:previousrow inSection:0];
            //cell = [self.externalDoctblView cellForRowAtIndexPath:selectedIndexPath];
           // [cell.titleLbl setTextColor:[StaticFuntions getTableLableColor]];
           // [cell.IDLbl setTextColor:[StaticFuntions getTableValueColor]];
            
            
            previousrow = indexPath.row;
            selectedIndexPath = [NSIndexPath indexPathForRow:previousrow inSection:0];
            
        }
        else
        {
            [externalDoctblView deselectRowAtIndexPath:selectedIndexPath animated:NO];
            previousrow = -2;
            
           // [cell.titleLbl setTextColor:[StaticFuntions getTableLableColor]];
           // [cell.IDLbl setTextColor:[StaticFuntions getTableValueColor]];
            
        }
    }
    else if (previousrow == -2)
    {
        [externalDoctblView deselectRowAtIndexPath:indexPath animated:NO];
       // [cell.titleLbl setTextColor:[StaticFuntions getTableLableColor]];
       // [cell.IDLbl setTextColor:[StaticFuntions getTableValueColor]];
    }
    
    
    [self tableView: tableView ButtonTappedForRowWithIndexPath: indexPath];
}
- (void)tableView:(UITableView *)tableView ButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    if (previousrow != -2 && previousrow != -1) {
        ExternalDocumentUnitObj *obj;
        if (searching)
        {
            obj = [self.filteredListOfexternalDoctblView objectAtIndex:indexPath.row];
        }
        else
        {
            obj = [self.ListOfexternalDoctblView objectAtIndex:indexPath.row];
        }
        
        SelectedRow = [obj.ExternalUnitID integerValue] - 1;
        
        
    }
    else
    {
        SelectedRow = -1;
    }
}



#pragma mark - methods

-(void)visable_hideDateControl:(BOOL)hidden{
    dateView.hidden=hidden;
    bgForDate.hidden=hidden;
}

-(void)visable_hideYearControl:(BOOL)hidden{
    yearView.hidden=hidden;
    bgForDate.hidden=hidden;
}

-(BOOL)validate{
    if (byIDBtn.selected == YES) {
        if([StaticFuntions isStringEmpty:docIDTxt.text]){
            [StaticFuntions showAlertWithTitle:@"" Message:docIDErrorText];
            return NO;
        }
        if([StaticFuntions isStringEmpty:docAgencyTxt.text]){
            [StaticFuntions showAlertWithTitle:@"" Message:docOrganizationErrorText];
            return NO;
        }
    }
    else if (byLogBookBtn.selected == YES)
    {
        if([StaticFuntions isStringEmpty:logBookTxt.text]){
            [StaticFuntions showAlertWithTitle:@"" Message:logBookErrorText];
            return NO;
        }
    }

    
    
    return YES;
}
-(void)dummyData{
    
}
-(void)initBGViews{
    int radiusVal=5;
    docIDView.layer.cornerRadius=radiusVal;
    docIDView.layer.borderWidth=0.5;
    docIDView.layer.borderColor=[[UIColor grayColor] CGColor];
    
    docAgencyIDView.layer.cornerRadius=radiusVal;
    docAgencyIDView.layer.borderWidth=0.5;
    docAgencyIDView.layer.borderColor=[[UIColor grayColor] CGColor];
    
    docAgencyNameView.layer.cornerRadius=radiusVal;
    docAgencyNameView.layer.borderWidth=0.5;
    docAgencyNameView.layer.borderColor=[[UIColor grayColor] CGColor];
    
    
    logBookView.layer.cornerRadius=radiusVal;
    logBookView.layer.borderWidth=0.5;
    logBookView.layer.borderColor=[[UIColor grayColor] CGColor];
}

-(void)hideKeyboard{
    [docIDTxt resignFirstResponder];
    [docAgencyTxt resignFirstResponder];
    [logBookTxt resignFirstResponder];
    [externalDocsearchBar resignFirstResponder];
}

-(void)connect{

    
    NSString *dateStr;
    
    
    if (byIDBtn.selected ==YES) {
        dateStr=[NSString stringWithFormat:@"%@/%@/%@",[StaticFuntions getIstamicYearNumForWebService:date],[StaticFuntions getIstamicMonthNumForWebService:date],[StaticFuntions getIstamicDayNumForWebService:date]];
        
        [[RequestManager sharedInstance] docSelfInquiry:self withDocNumber:docIDTxt.text withDocDate:dateStr withDocCode:docAgencyTxt.text];
    }
    else if (byLogBookBtn.selected ==YES) {
        dateStr=[NSString stringWithFormat:@"%@",[StaticFuntions getIstamicYearNumForWebService:date]];
        
        [[RequestManager sharedInstance] docSelfInquiry:self withLogBookNumber:logBookTxt.text withLogBookYear:dateStr];
    }
    
    [self showActivityViewer];
}
#pragma mark - date delegate

-(void)onSelectDate:(NSDate*)selectedDate{

    if(selectedDate==nil)
    {
        [self visable_hideDateControl:YES];
        [self visable_hideYearControl:YES];
        return;
    }
    date=selectedDate;
    
    if (dateView.hidden == FALSE) {
        yearLbl.text=[StaticFuntions getYearForDate:selectedDate forceHijri:FALSE forceEnLocale:FALSE];
        monthLbl.text=[StaticFuntions getMonthForDate:selectedDate forceHijri:FALSE];
        dayLbl.text=[StaticFuntions getDayForDate:selectedDate forceEnLocale:FALSE];
    }
    else if (yearView.hidden == FALSE)
    {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        if(appDelegate.currentLang==Arabic){
            
            logBookyearLbl.text=[StaticFuntions getYearForDate:selectedDate forceHijri:false forceEnLocale:FALSE];
            
        }else{

            NSString * year_value=[StaticFuntions getYearForDate:selectedDate forceHijri:FALSE forceEnLocale:FALSE];
            if ([year_value  isEqual: @"1439"]){
                logBookyearLbl.text =@"2018";
            }
            else if([year_value  isEqual: @"1438"]){
                logBookyearLbl.text =@"2017";

            }else if([year_value  isEqual: @"1437"]){
                logBookyearLbl.text =@"2016";
                
            }else if([year_value  isEqual: @"1436"]){
                logBookyearLbl.text =@"2015";
                
            }else if([year_value  isEqual: @"1435"]){
                logBookyearLbl.text =@"2014";
                
            }else if([year_value  isEqual: @"1434"]){
                logBookyearLbl.text =@"2013";
                
            }else if([year_value  isEqual: @"1433"]){
                logBookyearLbl.text =@"2012";
                
            }else if([year_value  isEqual: @"1432"]){
                logBookyearLbl.text =@"2011";
                
            }else{
                logBookyearLbl.text =@"2010";
            }
        }
    }

    
    [self visable_hideDateControl:YES];
    [self visable_hideYearControl:YES];

}


#pragma mark - connection

- (void)processCompleted:(id)data error:(CustomError *)error withService:(NSNumber *)service{
    [self hideActivityViewer];
    if(data!=nil){
        controlsView.hidden=YES;
        resultView.hidden=FALSE;
        resultTitleLbl.hidden=FALSE;
        NSMutableArray *responseArr=(NSMutableArray*)data;
        DocInfoObj *responseDic=[responseArr objectAtIndex:0];
        logBookDateResult.text = responseDic.DocumentDate;
        logBookStatusResult.text = responseDic.ActionDescription;
        if([service intValue]==(int)GetDocSelfInquiryDate_WS){
            logBookIDResult.text = docIDTxt.text;
            resultTitleLbl.text =ByIDLblText;
        }
        else
        {
            logBookIDResult.text = logBookTxt.text;
            resultTitleLbl.text =byLogBookLblText;
        }
    }else{
        [StaticFuntions showAlertWithTitle:@"" Message:NoDataFoundMsg];
    }
}


// custom  navigation  bar

- (IBAction)btnHomeOrMenuPress:(UIButton *)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UIButton *button = (UIButton *)sender;
    NSInteger *tag  =  [button tag];
    // menu button
    if (tag ==  0 )  {
        
        if(appDelegate.currentLang==Arabic)
        {
            [self showMenu];
        }else{
            [self  backHome];
        }
        
        
        
    }
    // home button
    else {
        if(appDelegate.currentLang==Arabic)
        {
            [self  backHome];
        }else{
            [self showMenu];
        }
        
    }
}
@end
