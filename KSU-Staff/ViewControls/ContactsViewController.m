//
//  ContactsViewController.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 11/18/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "ContactsViewController.h"
#import "AppDelegate.h"
#import "LocalizedMessages.h"
#import "ContactTableViewCell.h"
#import "RequestManager.h"
#import "StaticFuntions.h"

@interface ContactsViewController ()

@end

@implementation ContactsViewController
@synthesize titleLbl,tableView;

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
    /// testing
    //[self damyData];
    
    ///live
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
    titleLbl.text=MenuItemContactsText;
    noDataLbl.text=NoDataFoundMsg;
    
}

-(void)switchToLeftLayout{
    
    titleLbl.textAlignment=NSTextAlignmentLeft;
}

-(void)switchToRightLayout{
    
    titleLbl.textAlignment=NSTextAlignmentRight;
    
}

#pragma mark - table delegate

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier=@"ContactTableViewCell";
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.currentLang==English)
        CellIdentifier=@"ContactTableViewCell_en";
    else
        CellIdentifier=@"ContactTableViewCell";
    
    ContactTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[ContactTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    ContactObj *cObj=[contactsArr objectAtIndex:(int)indexPath.row];
    [cell initWithContactObj:cObj withRowIndex:(int)indexPath.row];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if([contactsArr count]==0){
        noDataLbl.hidden=NO;
        return 0;
    }
    noDataLbl.hidden=YES;
    return [contactsArr count];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

#pragma mark - methods
-(void)damyData{
    contactsArr=[[NSMutableArray alloc] init];
    ContactObj *contact0=[[ContactObj alloc] init];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.currentLang==Arabic){
        contact0.contactName=@"رقم الاتصال بالجامعة";
    }else
        contact0.contactName=@"Unversity Center";
    contact0.phoneNo=@"12345678";
    [contactsArr addObject:contact0];
    [contactsArr addObject:contact0];
    [contactsArr addObject:contact0];
    [contactsArr addObject:contact0];
    [contactsArr addObject:contact0];
    [contactsArr addObject:contact0];

    
}

-(void)connect{
    [[RequestManager sharedInstance] contacts:self];
    [self showActivityViewer];
}

#pragma mark - connection

- (void)processCompleted:(id)data error:(CustomError *)error withService:(NSNumber *)service{
    [self hideActivityViewer];
    if(data!=nil){
        contactsArr=(NSMutableArray*)data;
    }else{
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:error.errorMessage];
    }
    [tableView reloadData];
}
@end
