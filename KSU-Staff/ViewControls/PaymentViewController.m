//
//  PaymentViewController.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 10/22/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "PaymentViewController.h"
#import "StaticFuntions.h"
#import "LocalizedMessages.h"
#import "PaymentTableViewCell.h"
#import "AppDelegate.h"
#import "RequestManager.h"


@interface PaymentViewController ()

@end

@implementation PaymentViewController
@synthesize tableView,titleLbl/*,paidSegment*/,yearLbl;
@synthesize dateView;
@synthesize bgForDate;
@synthesize selectionView;
@synthesize paidBtn,paidSelection,unpaidBtn,unpaidSelection;
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
    [dateView  toolbarAlignment];
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
    
    [self expandTableSections];
    dateView.hidden=YES;
    [dateView initIslamicDateWithMonths:NO withDay:NO withDelegate:self withMaxDate:YES withMinDate:FALSE isForceHijri:NO];
    //paidSegment.selectedSegmentIndex=0;
    pObj=[[PaymentObj alloc] init];
    pObj.isPaid=YES;
    [self showPaid:YES];
    //[self damyData];
    date=[NSDate date];
    
    
    
    selectionView.hidden = YES;
    tableView.hidden = YES;
    noDataLbl.hidden = FALSE;
    
    if([self isNetworkAvailable] ==YES)
    {
        NSLog(@"Network Connection available");
        [self connect];
    }
    
    else{
        [StaticFuntions showAlertWithTitle:NetWorkTitle Message:NetWorkBody];
        
    }}

-(void)locatizeLables{
    noDataLbl.text= NoDataFoundMsg;
    
    
    titleLbl.text=paymentDBText;
    yearLbl.text=[StaticFuntions getTodayYear:FALSE];
    [paidBtn setTitle:PaymentPaidText forState:UIControlStateNormal];
    [unpaidBtn setTitle:PaymentNotPaidText forState:UIControlStateNormal];
    
     AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.currentLang==English){
    /*    [paidSegment setTitle:PaymentPaidText forSegmentAtIndex:0];
        [paidSegment setTitle:PaymentNotPaidText forSegmentAtIndex:1];
        paidSegment.selectedSegmentIndex=0;
        paidSegment.tintColor=[UIColor whiteColor];
        paidSegment.backgroundColor=[UIColor darkGrayColor];*/
    }else{
       /* [paidSegment setTitle:PaymentNotPaidText forSegmentAtIndex:0];
        [paidSegment setTitle:PaymentPaidText forSegmentAtIndex:1];
        paidSegment.selectedSegmentIndex=1;
        paidSegment.backgroundColor=[UIColor whiteColor];
        paidSegment.tintColor=[UIColor darkGrayColor];*/
    }
}

-(void)switchToLeftLayout{
    
    titleLbl.textAlignment=NSTextAlignmentLeft;
}

-(void)switchToRightLayout{
    
    titleLbl.textAlignment=NSTextAlignmentRight;
    
}

#pragma mark - table delegate

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier=@"PaymentTableViewCell";
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.currentLang==English)
        CellIdentifier=@"PaymentTableViewCell_en";
    else
        CellIdentifier=@"PaymentTableViewCell";
    
    PaymentTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[PaymentTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    
    PaymentDetailsObj *obj=nil;
    if(pObj.isPaid)
        obj=[pObj.paidDetailsArr objectAtIndex:(int)indexPath.section];
    else
        obj=[pObj.notPaidDetailsArr objectAtIndex:(int)indexPath.section];
    [cell initWithPaymentDetObj:obj withRowId:(int)indexPath.row];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[sectionRowsCount objectAtIndex:(int)section] intValue];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(pObj.isPaid){
        if([pObj.paidDetailsArr count]==0){
            noDataLbl.hidden=NO;
            noDataImg.hidden=NO;
            return 0;
        }
        noDataLbl.hidden=YES;
        noDataImg.hidden=YES;
        return [pObj.paidDetailsArr count];
    }else{
        if([pObj.notPaidDetailsArr count]==0){
            noDataLbl.hidden=NO;
            noDataImg.hidden=NO;
            return 0;
        }
        noDataLbl.hidden=YES;
        noDataImg.hidden=YES;
        return [pObj.notPaidDetailsArr count];
    }
    return 0;
}

-(UIView*)tableView:(UITableView *)tableView_ viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 60)];
    int btn_x=0,title_x=0,amount_x=0;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSTextAlignment align,alignAmount;
    if(appDelegate.currentLang==English){
        btn_x=260+15;
        title_x=5;
        amount_x=180;
        align=NSTextAlignmentLeft;
        alignAmount=NSTextAlignmentRight;
    }else{
        btn_x=0+15;
        title_x=60;
        amount_x=60;
        align=NSTextAlignmentRight;
        alignAmount=NSTextAlignmentLeft;
    }
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(title_x, 3, 255, 35)];
    label.textColor=[UIColor darkGrayColor];
    label.font=[label.font fontWithSize:14.0];
    
    
    UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(btn_x, 15, 30, 30)];
    [btn addTarget:self action:@selector(sectionButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag=section;
    NSString *string =@"";
    UIImage *image=nil;
    
    PaymentDetailsObj *obj= nil;
    if(pObj.isPaid)
        obj= [pObj.paidDetailsArr  objectAtIndex:section];
    else
        obj= [pObj.notPaidDetailsArr  objectAtIndex:section];
    
    string=obj.mainName;
    if([[sectionRowsCount objectAtIndex:section] intValue]==0)
        image=[UIImage imageNamed:@"arrow_down.png"];
    else
        image=[UIImage imageNamed:@"arrow_up.png"];
    
    label.textAlignment=align;
    label.lineBreakMode=NSLineBreakByWordWrapping;
    label.numberOfLines=2;
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [label setText:string];
    [view addSubview:btn];
    [view addSubview:label];
    
    UILabel *labelDate = [[UILabel alloc] initWithFrame:CGRectMake(title_x, 33, 255, 30)];
    labelDate.textColor=[UIColor blackColor];
    labelDate.text=obj.date;
    labelDate.textAlignment=align;
    //UIFont *font=labelDate.font.s;
    labelDate.font=[labelDate.font fontWithSize:11.0];
    [view addSubview:labelDate];
    
    UILabel *amount = [[UILabel alloc] initWithFrame:CGRectMake(amount_x, 33, 80, 30)];
    amount.textColor=[UIColor colorWithRed:244.0/255.0 green:151.0/255.0 blue:42.0/255.0 alpha:1];
    amount.text=obj.amount;
    amount.textAlignment=alignAmount;
    amount.font=[amount.font fontWithSize:14.0];
    [view addSubview:amount];
    [view setBackgroundColor:[UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1]];
    return view;
    // return nil;
}

/*
 -(NSArray*) indexPathsForSection:(int)section withNumberOfRows:(int)numberOfRows {
 NSMutableArray* indexPaths = [NSMutableArray new];
 for (int i = 0; i < numberOfRows; i++) {
 NSIndexPath* indexPath = [NSIndexPath indexPathForRow:i inSection:section];
 [indexPaths addObject:indexPath];
 }
 return indexPaths;
 }*/

-(void)sectionButtonTouchUpInside:(UIButton*)sender {
    //[self.tableView beginUpdates];
    int section = (int)sender.tag;
    if([[sectionRowsCount objectAtIndex:(int)section] intValue]==0){
        int numOfRows = NumberPaymentDetailsItems;
        // NSArray* indexPaths = [self indexPathsForSection:section withNumberOfRows:numOfRows];
        //  [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
        [sectionRowsCount replaceObjectAtIndex:section withObject:[NSNumber numberWithInt:numOfRows]];
    }else{
        // int numOfRows = [self.tableView numberOfRowsInSection:section];
        // NSArray* indexPaths = [self indexPathsForSection:section withNumberOfRows:numOfRows];
        [sectionRowsCount replaceObjectAtIndex:section withObject:[NSNumber numberWithInt:0]];
    }
    //  [self.tableView endUpdates];
    [self.tableView reloadData];
}


-(UIView*)tableView:(UITableView *)tableView_ viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 3)];
    [view setBackgroundColor:[UIColor clearColor]];
    return view;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}
#pragma mark - events


-(IBAction)onLeftYearPressed:(id)sender{
     [self visable_hideDateControl:NO];
}

-(IBAction)onRightYearPressed:(id)sender{
     [self visable_hideDateControl:NO];

}

-(IBAction)onTypeChanged:(id)sender{
    int tag= (int)((UIButton*)sender).tag;
    if(tag==1){
        pObj.isPaid=YES;
        [self showPaid:YES];
    }else{
        pObj.isPaid=NO;
        [self showPaid:NO];
    }
    [self expandTableSections];
    [tableView reloadData];
   /* AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.currentLang==English){
        //paid 0
        pObj.isPaid=NO;
    }else{
       //paid 1
        pObj.isPaid=YES;
    }
*/
    
}
#pragma mark - methods

-(void)showPaid:(BOOL)flag{
    //paidBtn.hidden=!flag;
    paidSelection.hidden=!flag;
    
  //  unpaidBtn.hidden=flag;
    unpaidSelection.hidden=flag;
}

-(void)expandTableSections{
    if(sectionRowsCount==nil)
        sectionRowsCount=[[NSMutableArray alloc] init];
    else{
        [sectionRowsCount removeAllObjects];
    }
    if(pObj.isPaid)
        for(int i=0;i< [pObj.paidDetailsArr count];i++){
            [sectionRowsCount addObject:[NSNumber numberWithInt:NumberPaymentDetailsItems]];
        }
    else{
        for(int i=0;i< [pObj.notPaidDetailsArr count];i++){
            [sectionRowsCount addObject:[NSNumber numberWithInt:NumberPaymentDetailsItems]];
        }
    }
}

-(void)visable_hideDateControl:(BOOL)hidden{
    dateView.hidden=hidden;
    bgForDate.hidden=hidden;
}

-(void)damyData{
    pObj =[[PaymentObj alloc] init];
    pObj.isPaid=YES;
    pObj.date=@"12/12/1435";
    pObj.paidDetailsArr=[[NSMutableArray alloc] init];
    
    PaymentDetailsObj *obj= [[PaymentDetailsObj alloc] init];
    obj.date=@"12/12/1435";
    obj.description=@"بدل كتب و مراجع";
    obj.number=@"1024";
    obj.month=@"12";
    obj.amount=@"1005.75";
    obj.idicator=@"مدفوع";
    
    [pObj.paidDetailsArr addObject:obj];
    [pObj.paidDetailsArr addObject:obj];
    [pObj.paidDetailsArr addObject:obj];
    [pObj.paidDetailsArr addObject:obj];
    [pObj.paidDetailsArr addObject:obj];
    [pObj.paidDetailsArr addObject:obj];
}

-(void)connect{
    NSString *year= [StaticFuntions getIstamicYearNumForWebService:date];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[RequestManager sharedInstance] getPaymentData:self forEmpNo:appDelegate.EmployeeObj.empNo    withYear:year];//yearLbl.text];
    [self showActivityViewer];
}
#pragma mark - date delegate

-(void)onSelectDate:(NSDate*)selectedDate{
    [self visable_hideDateControl:YES];
    if(selectedDate==nil)return;
    date=selectedDate;
    yearLbl.text=[StaticFuntions getYearForDate:selectedDate forceHijri:FALSE forceEnLocale:FALSE];
    [self connect];
}

#pragma mark - connection

- (void)processCompleted:(id)data error:(CustomError *)error withService:(NSNumber *)service{
    [self hideActivityViewer];
    if(data!=nil){
        NSMutableArray *arr=(NSMutableArray*)data;
        pObj.paidDetailsArr=[[NSMutableArray alloc] init];
        pObj.notPaidDetailsArr=[[NSMutableArray alloc]init];
        
            for(int i=0;i<[arr count];i++){
                PaymentDetailsObj *obj= [arr objectAtIndex:i];
                if(obj.isPaid)
                    [pObj.paidDetailsArr addObject:obj];
                else
                    [pObj.notPaidDetailsArr addObject:obj];
            }
            //        pObj.paymentDetailsArr=(NSMutableArray*)data;
            [self expandTableSections];
        
        if ([pObj.paidDetailsArr count] == 0 && [pObj.notPaidDetailsArr count] == 0) {
            selectionView.hidden = YES;
            tableView.hidden = YES;
            noDataLbl.hidden = FALSE;
            noDataImg.hidden = FALSE;
        }
        else if ([pObj.paidDetailsArr count] == 0 && [pObj.notPaidDetailsArr count] > 0) {
            selectionView.hidden = FALSE;
            tableView.hidden = FALSE;
            noDataLbl.hidden = YES;
            noDataImg.hidden = YES;
            
            pObj.isPaid=NO;
            [self showPaid:NO];
            [self expandTableSections];
            [tableView reloadData];
        }
        else
        {
            selectionView.hidden = FALSE;
            tableView.hidden = FALSE;
            noDataLbl.hidden = YES;
            noDataImg.hidden = YES;
        }
        

        

        
        
    }else{
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:error.errorMessage];
        
        selectionView.hidden = YES;
        tableView.hidden = YES;
        noDataLbl.hidden = FALSE;
        noDataImg.hidden = FALSE;
    }
    [tableView reloadData];
}

@end

