//
//  PaymentView.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 1/11/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "PaymentView.h"
#import "AppDelegate.h"
#import "PaymentTableViewCell.h"
#import "StaticFuntions.h"
#import "LocalizedMessages.h"

@implementation PaymentView
@synthesize tableView;
@synthesize yearLbl;
//@synthesize paidSegment;
@synthesize dateView;
@synthesize bgForDate;

@synthesize paidBtn,paidSelection,unpaidBtn,unpaidSelection;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
#pragma mark - methods

-(void)initControls{
    [self damyData];
    [self expandTableSections];
    dateView.hidden=YES;
    [dateView initIslamicDateWithMonths:NO withDay:NO withDelegate:self withMaxDate:YES withMinDate:FALSE isForceHijri:NO];
   // paidSegment.selectedSegmentIndex=0;

}

-(void)locatizeLables{
    yearLbl.text=[StaticFuntions getTodayYear:FALSE];
    [paidBtn setTitle:PaymentPaidText forState:UIControlStateNormal];
    [unpaidBtn setTitle:PaymentNotPaidText forState:UIControlStateNormal];

    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.currentLang==English){
        //[paidBtn setTitle:PaymentPaidText forState:UIControlStateNormal];
        //[unpaidBtn setTitle:PaymentNotPaidText forState:UIControlStateNormal];
        //paidSegment.selectedSegmentIndex=0;
       // paidSegment.tintColor=[UIColor whiteColor];
       // paidSegment.backgroundColor=[UIColor darkGrayColor];
    }else{
       // [paidSegment setTitle:PaymentNotPaidText forSegmentAtIndex:0];
       // [paidSegment setTitle:PaymentPaidText forSegmentAtIndex:1];
       // paidSegment.selectedSegmentIndex=1;
        //paidSegment.backgroundColor=[UIColor whiteColor];
        //paidSegment.tintColor=[UIColor darkGrayColor];
    }
}

-(void)switchToLeftLayout{
}

-(void)switchToRightLayout{
    
}

-(void)expandTableSections{
    if(sectionRowsCount==nil)
        sectionRowsCount=[[NSMutableArray alloc] init];
    else{
        [sectionRowsCount removeAllObjects];
    }
    if (pObj.isPaid) {
        for(int i=0;i< [pObj.paidDetailsArr count];i++){
            [sectionRowsCount addObject:[NSNumber numberWithInt:NumberPaymentDetailsItems]];
        }
    }else{
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

#pragma mark - date delegate

-(void)onSelectDate:(NSDate*)selectedDate{
    [self visable_hideDateControl:YES];
    if(selectedDate==nil)return;
    yearLbl.text=[StaticFuntions getYearForDate:selectedDate forceHijri:FALSE forceEnLocale:FALSE];
}


#pragma mark - events


-(IBAction)onLeftYearPressed:(id)sender{
    [self visable_hideDateControl:NO];
}

-(IBAction)onRightYearPressed:(id)sender{
    [self visable_hideDateControl:NO];
    
}

-(IBAction)onTypeChanged:(id)sender{
    //paidSegment.selectedSegmentIndex
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.currentLang==English){
        //paid 0
        pObj.isPaid=NO;
    }else{
        //paid 1
        pObj.isPaid=YES;
    }
    
    
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
       obj= [pObj.paidDetailsArr objectAtIndex:(int)indexPath.section];
    else
        obj=[pObj.notPaidDetailsArr objectAtIndex:(int)indexPath.section];

    [cell initWithPaymentDetObj:obj withRowId:(int)indexPath.row];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[sectionRowsCount objectAtIndex:(int)section] intValue];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(pObj.isPaid)
        return [pObj.paidDetailsArr count];
    return [pObj.notPaidDetailsArr count];
}

-(UIView*)tableView:(UITableView *)tableView_ viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 60)];
    int btn_x=0,title_x=0,amount_x=0;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSTextAlignment align,alignAmount;
    if(appDelegate.currentLang==English){
        btn_x=260;
        title_x=5;
        amount_x=180;
        align=NSTextAlignmentLeft;
        alignAmount=NSTextAlignmentRight;
    }else{
        btn_x=0;
        title_x=60;
        amount_x=60;
        align=NSTextAlignmentRight;
        alignAmount=NSTextAlignmentLeft;
    }
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(title_x, 5, 255, 30)];
    label.textColor=[UIColor darkGrayColor];
    
    UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(btn_x, 0, 60, 60)];
    [btn addTarget:self action:@selector(sectionButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag=section;
    NSString *string =@"";
    UIImage *image=nil;
    
    PaymentDetailsObj *obj= nil;
    if(pObj.paidDetailsArr)
        obj=[pObj.paidDetailsArr  objectAtIndex:section];
    else
        obj=[pObj.notPaidDetailsArr  objectAtIndex:section];
    string=obj.description;
    if([[sectionRowsCount objectAtIndex:section] intValue]==0)
        image=[UIImage imageNamed:@"arrow_down.png"];
    else
        image=[UIImage imageNamed:@"arrow_up.png"];
    
    label.textAlignment=align;
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [label setText:string];
    [view addSubview:btn];
    [view addSubview:label];
    
    UILabel *labelDate = [[UILabel alloc] initWithFrame:CGRectMake(title_x, 30, 255, 30)];
    labelDate.textColor=[UIColor darkGrayColor];
    labelDate.text=pObj.date;
    labelDate.textAlignment=align;
    //UIFont *font=labelDate.font.s;
    labelDate.font=[labelDate.font fontWithSize:11.0];
    [view addSubview:labelDate];
    
    UILabel *amount = [[UILabel alloc] initWithFrame:CGRectMake(amount_x, 15, 70, 30)];
    amount.textColor=[UIColor colorWithRed:244.0/255.0 green:151.0/255.0 blue:42.0/255.0 alpha:1];
    amount.text=@"1005.75";
    amount.textAlignment=alignAmount;
    [view addSubview:amount];
    [view setBackgroundColor:[UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1]];
    return view;
    // return nil;
}

-(void)sectionButtonTouchUpInside:(UIButton*)sender {
    int section = (int)sender.tag;
    if([[sectionRowsCount objectAtIndex:(int)section] intValue]==0){
        int numOfRows = NumberPaymentDetailsItems;
        [sectionRowsCount replaceObjectAtIndex:section withObject:[NSNumber numberWithInt:numOfRows]];
    }else{
        [sectionRowsCount replaceObjectAtIndex:section withObject:[NSNumber numberWithInt:0]];
    }
    [self.tableView reloadData];
}


-(UIView*)tableView:(UITableView *)tableView_ viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 2)];
    [view setBackgroundColor:[UIColor clearColor]];
    return view;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

@end
