//
//  ScheduleViewController.m
//  KSU_Students
//
//  Created by EJ-Mac book on 8/2/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "PermissionsViewController.h"
#import "AppDelegate.h"
#import "LocalizedMessages.h"
#import "StaticFuntions.h"
#import "PermissionsTableViewCell.h"
#import "RequestManager.h"
#import "PermissionsTableViewCell.h"

@interface PermissionsViewController ()

@end

@implementation PermissionsViewController

@synthesize titleLbl;
@synthesize tableView;
@synthesize controlsView;
@synthesize permissionsList,sectionRowsCount;
@synthesize noDataImg;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customizeNavigationBar:YES WithMenu:YES];
    /*if(IS_IPAD){
     int x= (self.view.frame.size.width- controlsView.frame.size.width)/2;
     controlsView.frame=CGRectMake(x, controlsView.frame.origin.y, controlsView.frame.size.width, controlsView.frame.size.height);
     }*/
    tableView.layoutMargins = UIEdgeInsetsZero;
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
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
    
    noDataLbl.hidden=YES;
    noDataImg.hidden=YES;
    permissionsList = [[NSMutableArray alloc] init];
    
    
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
    
    titleLbl.text=PermissionsTitleText;
    noDataLbl.text=PermissionsNoDataFoundMsg;
    
}

-(void)switchToLeftLayout{
    titleLbl.textAlignment=NSTextAlignmentLeft;
}

-(void)switchToRightLayout{
    titleLbl.textAlignment=NSTextAlignmentRight;
}

#pragma mark - methods

-(void)expandTableSections{
    if(sectionRowsCount==nil)
        sectionRowsCount=[[NSMutableArray alloc] init];
    else{
        [sectionRowsCount removeAllObjects];
    }
    for(int i=0;i< [permissionsList count];i++){
        if (i == 0) {
            PermissionObj *pObj = [permissionsList objectAtIndex:i];
            [sectionRowsCount addObject:[NSNumber numberWithInt:(int)[pObj.pages count]]];
        }
        else
        {
            [sectionRowsCount addObject:[NSNumber numberWithInt:0]];
        }
    }
}



-(void)connect{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[RequestManager sharedInstance] getPermissions:self withUsername:appDelegate.EmployeeObj.userName];
    [self showActivityViewer];
    
    /*PermissionObj *permissionObj=[[PermissionObj alloc] init];
    
    PageObj *pObj=[[PageObj alloc] init];
    permissionObj.pages = [[NSMutableArray alloc] init];
    
    
    
    permissionObj=[[PermissionObj alloc] init];
    permissionObj.pages = [[NSMutableArray alloc] init];
    permissionObj.serviceName = @"البوابة";
    
    pObj=[[PageObj alloc] init];
    pObj.pageName = @"المجموعات";
    pObj.actions = @"إضافة , حذف , تعديل , الرئيسية";
    [permissionObj.pages addObject:pObj];
    
    pObj=[[PageObj alloc] init];
    pObj.pageName = @"إدارة الطلبات";
    pObj.actions = @"الرئيسية";
    [permissionObj.pages addObject:pObj];
    
    pObj=[[PageObj alloc] init];
    pObj.pageName = @"الخدمات";
    pObj.actions = @"تعديل , الرئيسية";
    [permissionObj.pages addObject:pObj];
    
    pObj=[[PageObj alloc] init];
    pObj.pageName = @"فئة الخدمات";
    pObj.actions = @"إضافة , حذف , تعديل , الرئيسية";
    [permissionObj.pages addObject:pObj];
    
    pObj=[[PageObj alloc] init];
    pObj.pageName = @"إستطلاعات الرأي";
    pObj.actions = @"الرئيسية";
    [permissionObj.pages addObject:pObj];
    
    pObj=[[PageObj alloc] init];
    pObj.pageName = @"المستخدمين";
    pObj.actions = @"إضافة , التفاصيل , تعديل , الرئيسية";
    [permissionObj.pages addObject:pObj];
    
    [permissionsList addObject:permissionObj];
    
    
    
    
    permissionObj=[[PermissionObj alloc] init];
    permissionObj.pages = [[NSMutableArray alloc] init];
    permissionObj.serviceName = @"التعريف الألكتروني";
    
    pObj=[[PageObj alloc] init];
    pObj.pageName = @"النماذج";
    pObj.actions = @"إضافة , الرئيسية";
    [permissionObj.pages addObject:pObj];
    
    pObj=[[PageObj alloc] init];
    pObj.pageName = @"خطابات التعريف";
    pObj.actions = @"التقارير";
    [permissionObj.pages addObject:pObj];
    
    pObj=[[PageObj alloc] init];
    pObj.pageName = @"طباعة خطاب التعريف للموظفين";
    pObj.actions = @"الرئيسية";
    [permissionObj.pages addObject:pObj];
    
    pObj=[[PageObj alloc] init];
    pObj.pageName = @"الجهات";
    pObj.actions = @"إضافة , حذف , تعديل , الرئيسية";
    [permissionObj.pages addObject:pObj];
    
    [permissionsList addObject:permissionObj];
    
    
    
    
    
    permissionObj=[[PermissionObj alloc] init];
    permissionObj.pages = [[NSMutableArray alloc] init];
    permissionObj.serviceName = @"حضور المؤتمرات";
    
    pObj=[[PageObj alloc] init];
    pObj.pageName = @"اعدادات الخدمه";
    pObj.actions = @"اضافة";
    [permissionObj.pages addObject:pObj];
    
    pObj=[[PageObj alloc] init];
    pObj.pageName = @"قائمة الشروط و الضوابط";
    pObj.actions = @"تفعيل المرفقات , إضافة الشروط و الضوابط , حذف الشروط و الضوابط , حذف المرفقات , تعديل الشروط و الضوابط , الرئيسية , إضافة المرفقات";
    [permissionObj.pages addObject:pObj];
    
    [permissionsList addObject:permissionObj];
    
    
    permissionObj=[[PermissionObj alloc] init];
    permissionObj.pages = [[NSMutableArray alloc] init];
    permissionObj.serviceName = @"نظام الإستعانة";
    
    pObj=[[PageObj alloc] init];
    pObj.pageName = @"تقديم طلب";
    pObj.actions = @"تقديم طلبات لكل الموظفين , متابعة الطلبات";
    [permissionObj.pages addObject:pObj];
    
    pObj=[[PageObj alloc] init];
    pObj.pageName = @"التقارير";
    pObj.actions = @"تقرير تفصيلي بأسماء أعضاء هيئة التدريس , تقرير احصائي بعدد أعضاء هيئة التدريس , احصائيات الطلبات المرفوضة , الطلبات المرفوضة";
    [permissionObj.pages addObject:pObj];
    
    pObj=[[PageObj alloc] init];
    pObj.pageName = @"إعدادت الخدمة";
    pObj.actions = @"إعدادت الخدمة , ممثلين الكليات بالمجلس العلمي";
    [permissionObj.pages addObject:pObj];
    
    [permissionsList addObject:permissionObj];
    
    
    
    permissionObj=[[PermissionObj alloc] init];
    permissionObj.pages = [[NSMutableArray alloc] init];
    permissionObj.serviceName = @"الإستقالة والتقاعد المبكر";
    
    pObj=[[PageObj alloc] init];
    pObj.pageName = @"التقارير";
    pObj.actions = @"التقارير";
    [permissionObj.pages addObject:pObj];
    
    pObj=[[PageObj alloc] init];
    pObj.pageName = @"إستعلام عن الطلبات";
    pObj.actions = @"استعلام عن الطلبات";
    [permissionObj.pages addObject:pObj];
    
    pObj=[[PageObj alloc] init];
    pObj.pageName = @"إعدادت الخدمة";
    pObj.actions = @"إعدادت الخدمة";
    [permissionObj.pages addObject:pObj];
    
    [permissionsList addObject:permissionObj];
    
    */


}





#pragma mark - connection

- (void)processCompleted:(id)data error:(CustomError *)error withService:(NSNumber *)service{
    [self hideActivityViewer];
    if(data!=nil){
        NSMutableArray* arr =(NSMutableArray*)data;
        for(int i=0;i<[arr count];i++){
            PermissionObj* obj=[arr objectAtIndex:i];
            [permissionsList addObject:obj];
        }
        [self expandTableSections];
    }else{
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:error.errorMessage];
    }
    [tableView reloadData];
}




#pragma mark - table delegate

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier=@"PermissionsTableViewCell";
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.currentLang==English)
        CellIdentifier=@"PermissionsTableViewCell_en";
    else
        CellIdentifier=@"PermissionsTableViewCell";
    
    PermissionsTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[PermissionsTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    PermissionObj *PermissionObj=[permissionsList objectAtIndex:(int)indexPath.section];
    PageObj *pageObj=[PermissionObj.pages objectAtIndex:(int)indexPath.row];
    [cell initWithPageObj:pageObj withRowId:(int)indexPath.row];
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[sectionRowsCount objectAtIndex:(int)section] intValue];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if([permissionsList count]==0){
        noDataLbl.hidden=NO;
        noDataImg.hidden=NO;
        return 0;
    }
    noDataLbl.hidden=YES;
    noDataImg.hidden=YES;
    return [permissionsList count];
}

-(UIView*)tableView:(UITableView *)tableView_ viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 3)];
    [view setBackgroundColor:[UIColor clearColor]];
    return view;
}

-(UIView*)tableView:(UITableView *)tableView_ viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
    //int lable_x=0,semester_x,major_x,lbl_size;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSTextAlignment align;
    
    int btn_x=0,title_x=0;
    
    if(appDelegate.currentLang==English){
        align=NSTextAlignmentLeft;
        btn_x=self.view.frame.size.width-36;
        title_x=6;
    }else{
        align=NSTextAlignmentRight;
        btn_x=6;
        title_x=42;
    }
    UILabel *serviceLbl = [[UILabel alloc] initWithFrame:CGRectMake(title_x, 2, self.view.frame.size.width-48, 36)];
    serviceLbl.numberOfLines= 2;
    
    
    serviceLbl.textColor=[UIColor whiteColor];
    serviceLbl.font=[UIFont boldSystemFontOfSize:15.0];
    serviceLbl.textAlignment=align;
    
    
    PermissionObj *obj=[permissionsList objectAtIndex:section];
    
    [serviceLbl setText:obj.serviceName];
    [view addSubview:serviceLbl];
    
    
    UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(btn_x, 5, 30, 30)];
    [btn addTarget:self action:@selector(sectionButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag=section;
    UIImage *image=nil;
    
    if([[sectionRowsCount objectAtIndex:section] intValue]==0)
        image=[UIImage imageNamed:@"arrow_open.png"];
    else
        image=[UIImage imageNamed:@"arrow_close.png"];
    
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [view addSubview:btn];
    
    
    UIButton *Backgroundbtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    [Backgroundbtn addTarget:self action:@selector(sectionButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    Backgroundbtn.tag=section;
    [view addSubview:Backgroundbtn];
    
    [view setBackgroundColor:[UIColor colorWithRed:32.0/255.0 green:145.0/255.0 blue:206.0/255.0 alpha:1]];
    return view;
    // return nil;
    
    
}
-(void)sectionButtonTouchUpInside:(UIButton*)sender {
    //[self.tableView beginUpdates];
    
    int section = (int)sender.tag;
    if([[sectionRowsCount objectAtIndex:(int)section] intValue]==0){
        for(int i=0;i< [permissionsList count];i++){
            if (i == section) {
                PermissionObj *pObj = [permissionsList objectAtIndex:section];
                [sectionRowsCount replaceObjectAtIndex:section withObject:[NSNumber numberWithInt:(int)[pObj.pages count]]];
            }
            else
            {
                [sectionRowsCount replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:0]];
            }
            
        }
        
        
    }else{
        [sectionRowsCount replaceObjectAtIndex:section withObject:[NSNumber numberWithInt:0]];
    }
    //  [self.tableView endUpdates];
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}





@end
