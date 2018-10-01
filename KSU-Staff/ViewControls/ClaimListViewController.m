//
//  ClaimListViewController.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 2/2/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "ClaimListViewController.h"
#import "AppDelegate.h"
#import "RequestManager.h"
#import "LocalizedMessages.h"
#import "StaticFuntions.h"
#import "ClaimListTableViewCell.h"
#import "ClaimObj.h"

@interface ClaimListViewController ()

@end

@implementation ClaimListViewController
@synthesize tableView,titleLbl;
@synthesize dateLbl,descrpLbl,ticketNoLbl;
@synthesize controlsView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customizeNavigationBar:YES WithMenu:YES];
    
    // navigation  button  replace
    [self replaceHomeAndMenu:_homeBtn :_menuBtn];
    
    if(IS_IPAD){
        int x= (self.view.frame.size.width- controlsView.frame.size.width)/2;
        controlsView.frame=CGRectMake(x, controlsView.frame.origin.y, controlsView.frame.size.width, controlsView.frame.size.height);
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:true animated:animated];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
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
    if([self isNetworkAvailable] ==YES)
    {
        NSLog(@"Network Connection available");
            [self connect];
        
    }
    
    else{
        [StaticFuntions showAlertWithTitle:NetWorkTitle Message:NetWorkBody];
        
    }
}

-(void)locatizeLables{
    titleLbl.text=claimLstTitleTxt;

    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.currentLang==English){
    dateLbl.text=claimLstDateTxt;
    descrpLbl.text= claimLstTicketNoTxt;
    ticketNoLbl.text=claimLstDescpTxt;
        
    }
    else {
        dateLbl.text=claimLstDateTxt;
        descrpLbl.text=claimLstTicketNoTxt ;
        ticketNoLbl.text=claimLstDescpTxt;
        }
    
    
    noDataLbl.text=NoDataFoundMsg;
}

-(void)switchToLeftLayout{
    
    titleLbl.textAlignment=NSTextAlignmentLeft;

    CGRect frame=ticketNoLbl.frame;
    frame.origin.x=210;
    ticketNoLbl.frame=frame;
    
    frame=descrpLbl.frame;
    frame.origin.x=0;
    descrpLbl.frame=frame;
    
}

-(void)switchToRightLayout{
    
    titleLbl.textAlignment=NSTextAlignmentRight;
    CGRect frame=ticketNoLbl.frame;
    frame.origin.x=0;
    ticketNoLbl.frame=frame;
    
    frame=descrpLbl.frame;
    frame.origin.x=210;
    descrpLbl.frame=frame;
}

#pragma mark - methods

-(void)connect{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[RequestManager sharedInstance] getClaimLst:self forEmpNo:appDelegate.EmployeeObj.empNo];
    [self showActivityViewer];
}


#pragma mark - connection

- (void)processCompleted:(id)data error:(CustomError *)error withService:(NSNumber *)service{
    [self hideActivityViewer];
    if(data!=nil){
        claimLstArr=(NSMutableArray*)data;
    }else{
        [StaticFuntions showAlertWithTitle:@"" Message:error.errorMessage];
    }
    [tableView reloadData];
}

#pragma mark - table delegate

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier=@"ClaimListTableViewCell";
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    if(appDelegate.currentLang==English)
//        CellIdentifier=@"ClaimListTableViewCell_en";
//    else
        CellIdentifier=@"ClaimListTableViewCell";
    
    ClaimListTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[ClaimListTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    ClaimObj *obj=[claimLstArr objectAtIndex:(int)indexPath.row];
    [cell initWithObj:obj withRowIndex:(int)indexPath.row];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if([claimLstArr count]==0){
        noDataLbl.hidden=NO;
        return 0;
    }
    noDataLbl.hidden=YES;
    return [claimLstArr count];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

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
