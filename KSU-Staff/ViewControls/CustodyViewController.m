//
//  CustodyViewController.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 1/4/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "CustodyViewController.h"
#import "AppDelegate.h"
#import "StaticFuntions.h"
#import "LocalizedMessages.h"
#import "RequestManager.h"
#import "StaticFuntions.h"
#import "CustodyTableViewCell.h"

@interface CustodyViewController ()

@end

@implementation CustodyViewController

@synthesize titleLbl;
@synthesize tableView;

@synthesize headerView;
@synthesize remarksHeaderLbl;
@synthesize decrpHeaderLbl;
@synthesize quantityHeaderLbl;
@synthesize headerSperator2View;
@synthesize headerSperatorView;
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
    ///testing
       //[self dummyData];
    ///live
    
    if([self isNetworkAvailable] ==YES)
    {
        NSLog(@"Network Connection available");        
        [self connect];
    }
    
    else{
        [StaticFuntions showAlertWithTitle:NetWorkTitle Message:NetWorkBody];
        
    }}

-(void)locatizeLables{
    titleLbl.text=custodyDBText;
    remarksHeaderLbl.text=custodyRemarksText;
    quantityHeaderLbl.text=custodyQuantityText;
    decrpHeaderLbl.text=custodyDescText;
    
    noDataLbl.text=custodyDontExistMsg;
}

-(void)switchToLeftLayout{
    
    titleLbl.textAlignment=NSTextAlignmentLeft;
    decrpHeaderLbl.textAlignment=NSTextAlignmentLeft;
    
    /*CGRect frame=remarksHeaderLbl.frame;
    frame.origin.x=210;
    remarksHeaderLbl.frame=frame;
    
    frame=decrpHeaderLbl.frame;
    frame.origin.x=0;
    decrpHeaderLbl.frame=frame;*/
    
    CGRect frame=quantityHeaderLbl.frame;
    frame.origin.x=240;
    quantityHeaderLbl.frame=frame;
    
    frame=decrpHeaderLbl.frame;
    frame.origin.x=0;
    decrpHeaderLbl.frame=frame;
    
    frame=headerSperatorView.frame;
    frame.origin.x=240;
    headerSperatorView.frame=frame;
    
    /*frame=dateHeaderLbl.frame;
     frame.origin.x=49;
     dateHeaderLbl.frame=frame;
    
    
    frame=headerSperatorView.frame;
    frame.origin.x=91;
    headerSperatorView.frame=frame;
    
    frame=headerSperator2View.frame;
    frame.origin.x=181;
    headerSperator2View.frame=frame;
*/
    
}

-(void)switchToRightLayout{
    
    titleLbl.textAlignment=NSTextAlignmentRight;
    decrpHeaderLbl.textAlignment=NSTextAlignmentRight;
    /*CGRect frame=remarksHeaderLbl.frame;
    frame.origin.x=0;
    remarksHeaderLbl.frame=frame;
    
    frame=decrpHeaderLbl.frame;
    frame.origin.x=210;
    decrpHeaderLbl.frame=frame;*/
    CGRect frame=quantityHeaderLbl.frame;
    frame.origin.x=0;
    quantityHeaderLbl.frame=frame;
    
    frame=decrpHeaderLbl.frame;
    frame.origin.x=80;
    decrpHeaderLbl.frame=frame;
    
    frame=headerSperatorView.frame;
    frame.origin.x=80;
    headerSperatorView.frame=frame;
    
    /*frame=dateHeaderLbl.frame;
    frame.origin.x=49;
    dateHeaderLbl.frame=frame;
    
    
    frame=headerSperatorView.frame;
    frame.origin.x=229;
    headerSperatorView.frame=frame;
    
    frame=headerSperator2View.frame;
    frame.origin.x=139;
    headerSperator2View.frame=frame;
*/
    
}

#pragma mark - table delegate

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier=@"CustodyTableViewCell";
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.currentLang==English)
        CellIdentifier=@"CustodyTableViewCell_en";
    else
        CellIdentifier=@"CustodyTableViewCell";
    
    CustodyTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[CustodyTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    CustodyObj *obj=[custodyArr objectAtIndex:(int)indexPath.row];
    [cell initWithCustodyObj:obj withRowIndex:(int)indexPath.row];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if([custodyArr count]==0){
        noDataLbl.hidden=NO;
        noDataImg.hidden=NO;
        return 0;
    }
    noDataLbl.hidden=YES;
    noDataImg.hidden=YES;
    return [custodyArr count];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

#pragma mark - methods

-(void)dummyData{
    
    custodyArr=[[NSMutableArray alloc]init];
    CustodyObj *obj=[[CustodyObj alloc] init];
    obj.cust_remarks=@"ملاحظات العهدة";
    obj.cust_desc=@"لاب توب";
    obj.cust_quantity=@"4/4/1435";
    
    [custodyArr addObject:obj];
    [custodyArr addObject:obj];
    [custodyArr addObject:obj];
    [custodyArr addObject:obj];
    [custodyArr addObject:obj];
    [custodyArr addObject:obj];
    [custodyArr addObject:obj];
}

-(void)connect{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[RequestManager sharedInstance] getCustodyInfo:self forEmpNo:appDelegate.EmployeeObj.empNo];
    [self showActivityViewer];
}


#pragma mark - connection

- (void)processCompleted:(id)data error:(CustomError *)error withService:(NSNumber *)service{
    [self hideActivityViewer];
    if(data!=nil){
        custodyArr=(NSMutableArray*)data;
    }else{
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:error.errorMessage];
    }
    [tableView reloadData];
}
@end
