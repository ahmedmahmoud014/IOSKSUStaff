 //
//  SalaryViewController.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 10/19/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "SalaryViewController.h"
#import "LocalizedMessages.h"
#import "SalaryPaymentTableViewCell.h"
#import "SalaryBalanceTableViewCell.h"
#import "AppDelegate.h"
#import "StaticFuntions.h"
#import "RequestManager.h"

@interface SalaryViewController ()
@end

@implementation SalaryViewController
@synthesize tableView,titleLbl,monthLbl,yearLbl;
@synthesize dateView;
@synthesize bgForDate;

@synthesize totalDeserveValLbl;
@synthesize totalDiscountValLbl;
@synthesize totalNetValLbl;

@synthesize totalDeserveLbl;
@synthesize totalDiscountLbl;
@synthesize totalNetLbl;
@synthesize summaryView;
@synthesize summaryLbl;
@synthesize selectionView;
@synthesize allowanceBtn,allowanceSelection,paymentBtn,paymentSelection,deductionBtn,deductionSelection;

@synthesize sendClaimBtn,ClaimLstBtn;
@synthesize sendClaimImgBtn,ClaimLstImgBtn;

@synthesize controlsView;
@synthesize noDataImg;



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customizeNavigationBar:YES WithMenu:YES];
    
    if(IS_IPAD){
        int x= (self.view.frame.size.width- controlsView.frame.size.width)/2;
        controlsView.frame=CGRectMake(x, controlsView.frame.origin.y, controlsView.frame.size.width, controlsView.frame.size.height);
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
    self.BGImage.image= [UIImage imageNamed:@"bg.png"];
    /*AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
     if(appDelegate.currentLang==Arabic){
     
     }*/
    //[self dumyData];
    
    
    
    
    dateView.hidden=YES;
    [dateView initIslamicDateWithMonths:YES withDay:NO withDelegate:self withMaxDate:YES withMinDate:FALSE isForceHijri:YES];
    [dateView toolbarAlignment];

    //[dateView initIslamicDateWithMonths:YES withDay:YES withDelegate:self withMaxDate:YES isForceHijri:NO];
    date=[NSDate date];

    
    summaryView.hidden = YES;
    selectionView.hidden = YES;
    tableView.hidden = YES;
    noDataLbl.hidden = FALSE;
    noDataImg.hidden=FALSE;
    
    if([self isNetworkAvailable] ==YES)
    {
        NSLog(@"Network Connection available");
        [self connect :true];
    }
    
    else{
        [StaticFuntions showAlertWithTitle:NetWorkTitle Message:NetWorkBody];
        
    }
}

-(void)locatizeLables{
    noDataLbl.text=NoDataFoundMsg;
    titleLbl.text=SalaryTitleText;

    if (sObj.YEAR == nil){
    monthLbl.text=[StaticFuntions getTodayMonthForSalary:YES];
    yearLbl.text=[StaticFuntions getTodayYearForSalary:YES];

    }
    else {
        monthLbl.text=sObj.MONTH;
        yearLbl.text=sObj.YEAR;
    }
    totalDeserveLbl.text=TotalDeserveText;
    totalDiscountLbl.text=TotalDiscountText;
    totalNetLbl.text=TotalNetText;
    summaryLbl.text=SalaryTotalsText;
    
    [paymentBtn setTitle:SalaryPaymentInfoText forState:UIControlStateNormal];
    [allowanceBtn setTitle:SalaryAllowanceText forState:UIControlStateNormal];
    [deductionBtn setTitle:SalaryDeductionText forState:UIControlStateNormal];
    
   // [sendClaimBtn setTitle:sendClaimTitleTxt];
    //[ClaimLstBtn setTitle:claimLstTitleTxt];
    [sendClaimBtn setTitle:sendClaimTitleTxt forState:UIControlStateNormal];
    [ClaimLstBtn setTitle:claimLstTitleTxt forState:UIControlStateNormal];

}

-(void)switchToLeftLayout{
    
    titleLbl.textAlignment=NSTextAlignmentLeft;
    
    CGRect frame=ClaimLstImgBtn.frame;
    frame.origin.x=175;//21;
    ClaimLstImgBtn.frame=frame;
    
    frame=ClaimLstBtn.frame;
    frame.origin.x=205;//51;
    ClaimLstBtn.frame=frame;
    
    frame=sendClaimImgBtn.frame;
    frame.origin.x=23;//175;
    sendClaimImgBtn.frame=frame;
    
    frame=sendClaimBtn.frame;
    frame.origin.x=51;//205;
    sendClaimBtn.frame=frame;
    
}

-(void)switchToRightLayout{
    
    titleLbl.textAlignment=NSTextAlignmentRight;
    
    CGRect frame=ClaimLstBtn.frame;
    frame.origin.x=170;//21;
    ClaimLstBtn.frame=frame;
    
    frame=ClaimLstImgBtn.frame;
    frame.origin.x=265;//115;
    ClaimLstImgBtn.frame=frame;
    
    frame=sendClaimBtn.frame;
    frame.origin.x=21;//170;
    sendClaimBtn.frame=frame;
    
    frame=sendClaimImgBtn.frame;
    frame.origin.x=115;//265;
    sendClaimImgBtn.frame=frame;
}

#pragma mark - table delegate

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        static NSString *CellIdentifier=@"SalaryPaymentTableViewCell";
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        if(appDelegate.currentLang==English)
            CellIdentifier=@"SalaryPaymentTableViewCell_en";
        else
            CellIdentifier=@"SalaryPaymentTableViewCell";
        
        SalaryPaymentTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[SalaryPaymentTableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier:CellIdentifier];
        }
        [cell initWithSalaryObj:sObj withIndexPath:indexPath withSection:activeSection];
        return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(activeSection==PaymentInfo_sec){
        //noDataLbl.hidden=YES;
        return NumberSalaryPaymentInfoItems;
    }else if(activeSection==Allowances_sec){
        if([sObj.allowanceArr count]==0){
            //noDataLbl.hidden=NO;
            return 0;
        }
        //noDataLbl.hidden=YES;
        return [sObj.allowanceArr count];
    }else if(activeSection==Deductions_sec){
        if([sObj.deductionArr count]==0){
            //noDataLbl.hidden=NO;
            return 0;
        }
        //noDataLbl.hidden=YES;
        return [sObj.deductionArr count];
    }
    return 0;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}
#pragma mark - events


-(IBAction)onLeftPressed:(id)sender{
    [self visable_hideDateControl:NO];
}

-(IBAction)onRightPressed:(id)sender{
    [self visable_hideDateControl:NO];
    
}

-(IBAction)ontabChange:(id)sender{
    int tag=(int) ((UIButton*)sender).tag;
    if(tag==1){
        allowanceSelection.hidden=YES;
        deductionSelection.hidden=YES;
        paymentSelection.hidden=NO;
        activeSection=PaymentInfo_sec;
    }else if(tag==2){
        allowanceSelection.hidden=NO;
        deductionSelection.hidden=YES;
        paymentSelection.hidden=YES;
        activeSection=Allowances_sec;
    }else if(tag==3){
        allowanceSelection.hidden=YES;
        deductionSelection.hidden=NO;
        paymentSelection.hidden=YES;
        activeSection=Deductions_sec;
    }
    [tableView reloadData];
}

-(IBAction)onSendClaimPressed:(id)sender{
    NSString *seagueName=SeagueSendClaimScreen;
    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:seagueName];
    [self.navigationController pushViewController:viewController animated:NO];
    
}

-(IBAction)onClaimLstPressed:(id)sender{
    NSString *seagueName=SeagueClaimListScreen;
    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:seagueName];

    [self.navigationController pushViewController:viewController animated:NO];
}
#pragma mark - methods

-(void)visable_hideDateControl:(BOOL)hidden{
    dateView.hidden=hidden;
    bgForDate.hidden=hidden;
}

-(void) connect:(BOOL) status{
    NSString *month=[StaticFuntions getIstamicMonthNumForWebServiceTest:date checkCall:status];
    NSString *year= [StaticFuntions getIstamicYearNumForWebService:date];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[RequestManager sharedInstance] getSalaryData:self forEmpNo:appDelegate.EmployeeObj.empNo  withMonth:month withYear:year];//yearLbl.text];
    [self showActivityViewer];
    
}

-(void) dumyData{
    sObj=[[SalaryObj alloc] init];
    sObj.allowanceArr=[[NSMutableArray alloc] init];
    SalaryDetailsObj *details=[[SalaryDetailsObj alloc] init];
    details.code=@"1001";
    details.description=@"مكافاة";
    details.value=@"2000";
    details.isAllowance=YES;
    [sObj.allowanceArr addObject:details];
    [sObj.allowanceArr addObject:details];
    [sObj.allowanceArr addObject:details];
    
    sObj.deductionArr=[[NSMutableArray alloc] init];
    
    SalaryDetailsObj *d=[[SalaryDetailsObj alloc] init];
    d.code=@"3000";
    d.description=@"خصم قسط التامين";
    d.value=@"500";
    d.isAllowance=NO;
    [sObj.deductionArr addObject:d];
    [sObj.deductionArr addObject:d];
    
    sObj.bankName=@"البنك المصرفي";
     sObj.type=@"مرتب شهر محرم";
     sObj.date=@"1/1/1436";
    
     sObj.totalDeserve=@"6000";
     sObj.totalDiscount=@"1000";
     sObj.totalNet=@"5000";
    totalNetValLbl.text=@"30000.00";
    totalDiscountValLbl.text=@"30000.00";
    totalDeserveValLbl.text=@"30000.00";
}

#pragma mark - date delegate

-(void)onSelectDate:(NSDate*)selectedDate{
    [self visable_hideDateControl:YES];
    
    if(selectedDate == nil)return;
    date=selectedDate;
//    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//   // if( sObj.YEAR == nil){
//    if(appDelegate.currentLang==English){
//        yearLbl.text=[StaticFuntions getYearForDate:selectedDate forceHijri:false forceEnLocale:true];
//        monthLbl.text=[StaticFuntions getMonthForDate:selectedDate forceHijri:false];    }
//    else
//    {
        yearLbl.text=[StaticFuntions getYearForDate:selectedDate forceHijri:YES forceEnLocale:FALSE];
        monthLbl.text=[StaticFuntions getMonthForDate:selectedDate forceHijri:YES];
   // }
 //   }
//    else{
//        yearLbl.text = sObj.YEAR;
//        monthLbl.text=  sObj.MONTH;
//    }
//
    
   
    if([self isNetworkAvailable] ==YES)
    {
        NSLog(@"Network Connection available");
        [self connect : false];
    }
    
    else{
        [StaticFuntions showAlertWithTitle:NetWorkTitle Message:NetWorkBody];
        
    }
    
}
#pragma mark - connection

- (void)processCompleted:(id)data error:(CustomError *)error withService:(NSNumber *)service{
    [self hideActivityViewer];
    if(data!=nil){
        sObj=(SalaryObj*)data;
        
        if (sObj.totalDeserve) {
            summaryView.hidden = FALSE;
            selectionView.hidden = FALSE;
            tableView.hidden = FALSE;
            noDataLbl.hidden = YES;
            noDataImg.hidden=YES;
            
            
            if(sObj.totalDeserve){
                float totalDesrve=[sObj.totalDeserve floatValue];
                totalDeserveValLbl.text=[NSString stringWithFormat:@"%.2f",totalDesrve];//sObj.totalDeserve;
            }else{
                totalDeserveValLbl.text=@"-";
            }
            if(sObj.totalDiscount){
                float totalDiscount=[sObj.totalDiscount floatValue];
                totalDiscountValLbl.text=[NSString stringWithFormat:@"%.2f",totalDiscount];//sObj.totalDiscount;
            }else{
                totalDiscountValLbl.text=@"-";
            }
            if(sObj.totalDiscount&&sObj.totalDeserve){
                float totalDesrve=[sObj.totalDeserve floatValue];
                float totalDiscount=[sObj.totalDiscount floatValue];
                float net= totalDesrve-totalDiscount;
                totalNetValLbl.text=[NSString stringWithFormat:@"%.2f",net];
                sObj.date=[NSString stringWithFormat:@"%@ - %@",monthLbl.text,yearLbl.text];
                 sObj.YEAR=yearLbl.text;
                 sObj.MONTH =monthLbl.text;
            }else{
                totalNetValLbl.text=@"-";
            }
        }
        else
        {
            summaryView.hidden = YES;
            selectionView.hidden = YES;
            tableView.hidden = YES;
            noDataLbl.hidden = FALSE;
            noDataImg.hidden=FALSE;
            
        }
        
        
    }else{
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:error.errorMessage];
        summaryView.hidden = YES;
        selectionView.hidden = YES;
        tableView.hidden = YES;
        noDataLbl.hidden = FALSE;
        noDataImg.hidden=FALSE;
    }
    [tableView reloadData];
}
@end
