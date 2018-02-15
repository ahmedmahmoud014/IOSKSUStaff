//
//  ProfileViewController.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 10/15/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "ProfileViewController.h"
#import "LocalizedMessages.h"
#import "StaticVariables.h"
#import "AppDelegate.h"
#import "ProfileTableViewCell.h"
#import "StaticFuntions.h"
#import "RequestManager.h"
#import "PersonalTableViewCell.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

@synthesize titleLbl;
@synthesize tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customizeNavigationBar:YES WithMenu:YES];
    
    if(IS_IPAD){
        int x= (self.view.frame.size.width- tableView.frame.size.width)/2;
        tableView.frame=CGRectMake(x, tableView.frame.origin.y, tableView.frame.size.width, tableView.frame.size.height);
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
    titleLbl.text=profileTitleText;
    
}

-(void)switchToLeftLayout{
    titleLbl.textAlignment=NSTextAlignmentLeft;
}

-(void)switchToRightLayout{
    titleLbl.textAlignment=NSTextAlignmentRight;
    
}

#pragma mark - table delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0 && indexPath.section==(int)PersonalInfo_sec)
        return 85;
    
    return 48;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0&&indexPath.section==PersonalInfo_sec){
        static NSString *CellIdentifier=@"PersonalTableViewCell";
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        if(appDelegate.currentLang==English)
            CellIdentifier=@"PersonalTableViewCell_en";
        else
            CellIdentifier=@"PersonalTableViewCell";
        
        PersonalTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[PersonalTableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier:CellIdentifier];
        }
        [cell initWithProfileObj:pObj];
        return cell;
    }
    static NSString *CellIdentifier=@"ProfileTableViewCell";
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString * type;
    if(appDelegate.currentLang==English)
    {  CellIdentifier=@"ProfileTableViewCell_en";
    type =@"en";
    }
    else{
        CellIdentifier=@"ProfileTableViewCell";
        type =@"ar";

    }
    
    ProfileTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[ProfileTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    [cell initWithProfileObj:pObj withIndexPath:indexPath withpassInfo:passObj languageType:type];
    
   return cell;
    
    // return nil;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if((int)section==PersonalInfo_sec)
        return NumberPersonalInfoItems;
    else if((int)section==PassportInfo_sec)
        return NumberpassportInfoItems;
    return 0;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(UIView*)tableView:(UITableView *)tableView_ viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
    int image_x=0,title_x=0;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSTextAlignment align;
    if(appDelegate.currentLang==English){
        image_x=5;
        title_x=40;
        align=NSTextAlignmentLeft;
    }else{
        image_x=280;
        title_x=0;
        align=NSTextAlignmentRight;
    }
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(title_x, 5, 275, 30)];
    UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(image_x, 5, 30, 30)];
    NSString *string =@"";
    UIImage *image=nil;
    if(((int)section)==PersonalInfo_sec){
        string=PresonalInfoText;
        if(!pObj.isMale){
            image=[UIImage imageNamed:@"personal_info_f.png"];
        }else
            image=[UIImage imageNamed:@"personal_info.png"];
    }else if(((int)section)==PassportInfo_sec){
        string=PassportTitleText;
        image=[UIImage imageNamed:@"passport_icon.png"];
    }
    label.textAlignment=align;
    imgView.image=image;
    [label setText:string];
    [view addSubview:imgView];
    [view addSubview:label];
    [view setBackgroundColor:[UIColor colorWithRed:244.0/255.0 green:244.0/255.0  blue:244.0/255.0  alpha:1]];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

#pragma mark - methods

-(void)damyData{
    pObj =[[ProfileObj alloc] init];
    pObj.bankAccNo=@"10000000";
    pObj.birthday=@"4/12/1986";
    pObj.empNo=@"1024";
    pObj.grade=@"7";
    pObj.hijriBirthday=@"5/5/1400";
    pObj.hiringDate=@"1/1/2014";
    pObj.isMale=NO;
    pObj.mobNo=@"123456789";
    pObj.rank=@"7";
    pObj.socialExpire=@"1/1/1435";
    pObj.socialNo=@"12345";
    pObj.status=@"مسجل";
    
    pObj.stratDate=@"1/1/2014";
    pObj.telNo=@"234567";
    pObj.type=@"مسجل";
    
    pObj.webSite=@"www.test.com";
    pObj.alternativeEmail=@"test@test.com";
    
    pObj.section=@"أدارة المالية";
    
    pObj.fullName=@"مني احمد احمد احمد احمد احمد عبد الرحمن";
    pObj.jobTitle=@"موظف";
    pObj.nationality=@"مصرية";
    pObj.department=@"القسم الأداري";
    pObj.bankName=@"البنك المصرفي";
}

-(void)connect{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[RequestManager sharedInstance] getProfileData:self forEmpNo:appDelegate.EmployeeObj.empNo];
    [self showActivityViewer];
}

#pragma mark - connection

- (void)processCompleted:(id)data error:(CustomError *)error withService:(NSNumber *)service{
    
    if(data!=nil){
        if([service intValue]==(int)UserProfile_WS){
            pObj=(ProfileObj*)data;
             AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [[RequestManager sharedInstance] getPassportInfo:self forEmpNo:appDelegate.EmployeeObj.empNo];
            
        } else if([service intValue]==(int)GetPassportInfo_WS){
            passObj=(PassportObj*)data;
            [self hideActivityViewer];
            [tableView reloadData];
        }
        
    }else{
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:error.errorMessage];
        [self hideActivityViewer];
        [tableView reloadData];
    }
}
@end
