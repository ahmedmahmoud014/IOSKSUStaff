//
//  NotificationViewController.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 6/24/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "NotificationViewController.h"
#import "LocalizedMessages.h"
#import "StaticFuntions.h"
#import "AppDelegate.h"
#import "NotificationTableViewCell.h"
#import "RequestManager.h"
#import "NotifyObj.h"

@implementation NotificationViewController
@synthesize tableView,titleLbl;
@synthesize deleteBtn;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customizeNavigationBar:YES WithMenu:YES];
    if(IS_IPAD){
        int x= (self.view.frame.size.width- tableView.frame.size.width)/2;
        tableView.frame=CGRectMake(x, tableView.frame.origin.y, tableView.frame.size.width, tableView.frame.size.height);
        noDataLbl.frame=CGRectMake(x, noDataLbl.frame.origin.y, noDataLbl.frame.size.width, noDataLbl.frame.size.height);
    }
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if([self isNetworkAvailable] ==YES)
    {
        NSLog(@"Network Connection available");
            [self connect];    }
    
    else{
        [StaticFuntions showAlertWithTitle:NetWorkTitle Message:NetWorkBody];
        
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
    
}

-(void)locatizeLables{
    titleLbl.text=notificationDBText;
    noDataLbl.text=NoDataFoundMsg;
}

-(void)switchToLeftLayout{
    titleLbl.textAlignment=NSTextAlignmentLeft;
    
    
    CGRect frame;
    frame = self.titleLbl.frame;
    frame.origin.x = 12;
    self.titleLbl.frame = frame;
    
    
    frame = self.deleteBtn.frame;
    frame.origin.x = self.titleLbl.frame.origin.x + self.titleLbl.frame.size.width + 12;
    self.deleteBtn.frame = frame;
    
}

-(void)switchToRightLayout{
    titleLbl.textAlignment=NSTextAlignmentRight;
    
    CGRect frame;
    frame = self.deleteBtn.frame;
    frame.origin.x = 12;
    self.deleteBtn.frame = frame;
    
    
    frame = self.titleLbl.frame;
    frame.origin.x = self.deleteBtn.frame.origin.x + self.deleteBtn.frame.size.width + 12;
    self.titleLbl.frame = frame;
}

#pragma mark - methods

-(void)connect{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[RequestManager sharedInstance] getNotifications:self forEmpNo: appDelegate.EmployeeObj.empNo];
    [self showActivityViewer];
}


#pragma mark - connection

- (void)processCompleted:(id)data error:(CustomError *)error withService:(NSNumber *)service{
    [self hideActivityViewer];
    if(data!=nil){
        
        if([service intValue]==(int)DeleteNotifications_WS){
            if ([data isEqualToString:@"Delete all data"]) {
                [StaticFuntions showAlertWithTitle:ApplicationTitleText Message:DeleteNotification];
                deleteBtn.hidden = YES;
                notifyLstArr = [[NSMutableArray alloc] init];
            }
        }
        else if([service intValue]==(int)GetNotifications_WS)
        {
            notifyLstArr=(NSMutableArray*)data;
            sectionRowsCount = [[NSMutableArray alloc] init];
            for(int i=0; i< [notifyLstArr count];i++){
                [sectionRowsCount addObject:[NSNumber numberWithInteger:[((NotifyObj*)[notifyLstArr objectAtIndex:i]).notifyArr count]]];
            }
            
            if ([notifyLstArr count] == 0) {
                deleteBtn.hidden = YES;
            }
            else
                deleteBtn.hidden = FALSE;
        }
        
        
    }else{
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:error.errorMessage];
    }
    [tableView reloadData];
}

-(IBAction)onDeletePressed:(id)sender
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[RequestManager sharedInstance] deleteNotifications:self forEmpNo: appDelegate.EmployeeObj.empNo];
    [self showActivityViewer];
}
#pragma mark - table delegate

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier=@"NotificationTableViewCell";
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.currentLang==English)
        CellIdentifier=@"NotificationTableViewCell_en";
    else
        CellIdentifier=@"NotificationTableViewCell";
    
    NotificationTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[NotificationTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    NotifyObj *obj=[notifyLstArr objectAtIndex:(int)indexPath.section];
    NotifyDetailsObj *detObj= [obj.notifyArr objectAtIndex:(int)indexPath.row];
    [cell initWithNotifyObj:detObj withRowId:(int)indexPath.row];
    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[sectionRowsCount objectAtIndex:(int)section] intValue];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if([notifyLstArr count]==0){
        noDataLbl.hidden=NO;
        return 0;
    }
    noDataLbl.hidden=YES;
    return [notifyLstArr count];
}

-(UIView*)tableView:(UITableView *)tableView_ viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 3)];
    [view setBackgroundColor:[UIColor clearColor]];
    return view;
}

-(UIView*)tableView:(UITableView *)tableView_ viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
    int img_x=0,title_x;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSTextAlignment align;
    if(appDelegate.currentLang==English){
        title_x=60;
        img_x=20;
        align=NSTextAlignmentLeft;
    }else{
        title_x=20;
        img_x=270;
        align=NSTextAlignmentRight;
    }
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(title_x, 3, 240, 25)];
    label.textColor=[UIColor darkGrayColor];
    label.font=[label.font fontWithSize:14.0];
    label.textAlignment=align;

    NSString *string =@"";
    UIImage *image=[UIImage imageNamed:@"notify_date.png"];

    NotifyObj *obj=[notifyLstArr objectAtIndex:section];
    string=obj.date;
    
    [label setText:string];
    
    UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(img_x, 2, 30, 30)];
    [imgView setImage:image];
    
    [view addSubview:imgView];
    [view addSubview:label];
    
    [view setBackgroundColor:[UIColor colorWithRed:228.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1]];
    return view;
    // return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}


@end
