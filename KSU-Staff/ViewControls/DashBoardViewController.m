//
//  DashBoardViewController.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 10/12/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "DashBoardViewController.h"
#import "DashBoardCollectionViewCell.h"
#import "DashBoardObj.h"
#import "StaticVariables.h"
#import "AppDelegate.h"
#import "LocalizedMessages.h"
#import "RequestManager.h"
#import "DB_DataCollectionViewCell.h"
#import "StaticFuntions.h"
#import "SalaryObj.h"
#import "PaymentDetailsObj.h"
#import "CalenderViewController.h"
#import "NHAlignmentFlowLayout.h"
#import "Categories.h"
@interface DashBoardViewController ()

@end



@implementation DashBoardViewController
@synthesize collectionView,dataArray;
@synthesize menuBtn,copyrightsLbl;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customizeNavigationBar:NO WithMenu:YES];
    
    // navigation  button  replace
    [self replaceHomeAndMenu:_homeBtn :menuBtn];
   
    
    //TEST FILTER ARRAY
    
    
    NSArray  *name=[[NSArray alloc] init];
    name =@[@"b",@"d",@"f",@"a"];
    NSMutableArray *array = [NSMutableArray array];
    Categories *obj=[[Categories alloc] init];
    for (NSString *n in name ){
    [obj initWithCatName: n  category_id:@"a1"  url_title:@"aa" offersPath:@"a" ];
    [array addObject:obj];
    }
 //NSArray *sortedArray;
  [array sortUsingDescriptors:
     [NSMutableArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"fullName"
                                                            ascending:YES
                                                             selector:@selector(caseInsensitiveCompare:)]]];
   // NSLog(@"oreder array  value %@  ", array[0]);
    for (Categories *naa in  array) {
        NSLog(@"oreder array %@ ", naa.fullName);
    }
    
//    sortedArray = [array sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
//        NSString *first = [(Categories*)a fullName];
//        NSString *second = [(Categories*)b fullName];
//        return [first compare:second];
//    }];
  //  NSLog(@"oreder array %ld ", sortedArray.count);
//
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(!appDelegate.isSendingDeviceToken)
        [appDelegate updateDeviceToken];
    
    if(IS_IPAD){
        int x= (self.view.frame.size.width- collectionView.frame.size.width)/2;
        int y= 100;//(self.view.frame.size.height- collectionView.frame.size.height)/2;
        collectionView.frame=CGRectMake(x, y, collectionView.frame.size.width, collectionView.frame.size.height);
    }
    
   // [collectionView setTransform:CGAffineTransformMakeScale(-1, 1)];

    
    NHAlignmentFlowLayout *layout = [[NHAlignmentFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //layout.sectionInset = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
    
    if(appDelegate.currentLang==Arabic)
    {
        [_homeBtn setHidden: true ];

        layout.alignment = NHAlignmentBottomRightAligned;
        
    }
    else
    {
        //menuBtn.isHidden   = true
        [menuBtn setHidden: true ];
        layout.alignment = NHAlignmentTopLeftAligned;
    }
    
    
    layout.itemSize = CGSizeMake(100.0, 100.0);
    layout.minimumInteritemSpacing = 5.0;
    layout.minimumLineSpacing = 5.0;
    
    self.collectionView.collectionViewLayout = layout;
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    

}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];

}



-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
   // [self.navigationController setNavigationBarHidden:YES animated:YES];

    if([repeatingTimer isValid])
        [repeatingTimer invalidate];
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


#pragma mark - collectionview delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.dataArray count];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSMutableArray *sectionArray = [self.dataArray objectAtIndex:section];
    return [sectionArray count];
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView_ cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // Setup cell identifier
    static NSString *cellIdentifier = @"DashBoardCollectionViewCell";
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSMutableArray *data = [self.dataArray objectAtIndex:indexPath.section];
    MyDashBoard mydash = (MyDashBoard)[[data objectAtIndex:indexPath.row] intValue] ;
    
    
    if(mydash==VacationsDB&& appDelegate.DB_data &&isTileView &&(!appDelegate.EmployeeObj.isTeacher)){
        cellIdentifier = @"DB_DataCollectionViewCell";
        DB_DataCollectionViewCell *cell = (DB_DataCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        [cell initWithDashboardData:appDelegate.DB_data withType:vacationData];

        return cell;
    }else if(mydash==SalaryDB&& appDelegate.DB_data.salary &&isTileView){
        cellIdentifier = @"DB_DataCollectionViewCell";
        DB_DataCollectionViewCell *cell = (DB_DataCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        [cell initWithDashboardData:appDelegate.DB_data withType:salaryData];
        
        return cell;
    }else if(mydash==PaymentDB&& appDelegate.DB_data.notPaid &&isTileView&&([appDelegate.DB_data.notPaid intValue]!=0|| [appDelegate.DB_data.paid intValue]!=0)){
        cellIdentifier = @"DB_DataCollectionViewCell";
        DB_DataCollectionViewCell *cell = (DB_DataCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        [cell initWithDashboardData:appDelegate.DB_data withType:paymentData];
        
        return cell;
    }
    else{
        cellIdentifier = @"DashBoardCollectionViewCell";
        DashBoardCollectionViewCell *cell = (DashBoardCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        
        [cell.titleLabel setText:[DashBoardObj getDBItemTitle:mydash]];
        [cell.imageView setImage:[DashBoardObj getDBItemImage:mydash]];
        
        [cell.commingSoonImg setHidden:!([DashBoardObj getDBItemIsCommingSoon:mydash])];
        if(appDelegate.currentLang==Arabic){
            [cell.commingSoonImg setImage:[UIImage imageNamed:@"comingsoon_ar.png"]];
        }else{
            [cell.commingSoonImg setImage:[UIImage imageNamed:@"comingsoon.png"]];
        }
        
        if(!isTileView&& mydash==VacationsDB&& appDelegate.DB_data &&(!appDelegate.EmployeeObj.isTeacher)){
            [cell isAnimated];
        }else if(!isTileView&& mydash==SalaryDB&& appDelegate.DB_data.salary ){
            [cell isAnimated];
        }else if(!isTileView&& mydash==PaymentDB&& appDelegate.DB_data.notPaid &&([appDelegate.DB_data.notPaid intValue]!=0|| [appDelegate.DB_data.paid intValue]!=0)){
            [cell isAnimated];
        }
        return cell;
    }
    
    return nil;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableArray *data = [self.dataArray objectAtIndex:indexPath.section];
    MyDashBoard mydash = (MyDashBoard)[[data objectAtIndex:indexPath.row] intValue] ;
    NSString *seagueName=[DashBoardObj getDBItemSeague:mydash];
    
    if (seagueName != SeagueCalendarScreen && seagueName !=SeagueVacationScreen){
    if([self isNetworkAvailable] ==YES)
    {
        NSLog(@"Network Connection available");
        [self moveTo:seagueName secondView : mydash];
         }
    
    else{
        [StaticFuntions showAlertWithTitle:NetWorkTitle Message:NetWorkBody];
        
    }
    }else {
        [self moveTo:seagueName secondView :mydash];

    }
    
    

}

- (void) moveTo : (NSString *) seagueName  secondView: (MyDashBoard*)mydash {
    [self.navigationController setNavigationBarHidden:false animated:true];

    if(seagueName==nil)return;
//    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:seagueName];
    printf("rrrrrrrrrrr",seagueName);
//    [self.navigationController pushViewController:viewController animated:NO];
    UIViewController * viewController = [self.storyboard instantiateViewControllerWithIdentifier:seagueName];
    [self moveToNext:viewController];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(mydash==VacationsDB&& appDelegate.EmployeeObj.isTeacher){
        [((CalenderViewController*)viewController) changeToVacationCalender];
    }
}

#pragma mark - base methods

-(void)initalizeViews{
    self.BGImage.image= [UIImage imageNamed:@"bg.png"];
    /*AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
     if(appDelegate.currentLang==Arabic){
     
     }*/
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.EmployeeObj.showTotalsDB)
        [self getData];
}

-(void)locatizeLables{
    [self initDashboardItems];
   
    copyrightsLbl.text=copyRightsText;
}

-(void)switchToLeftLayout{
    CGRect frame=menuBtn.frame;
    frame.origin.x=20;
    menuBtn.frame=frame;
}

-(void)switchToRightLayout{
    CGRect frame=menuBtn.frame;
    frame.origin.x=264;
    menuBtn.frame=frame;

}

#pragma mark - methods

-(void)showTile{
    isTileView=!isTileView;
    [collectionView reloadData];
}
-(void)getData{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.DB_data){
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(showTile) userInfo:nil repeats:YES];
        repeatingTimer = timer;
    }else{
        if(!appDelegate.EmployeeObj.isTeacher)
            [[RequestManager sharedInstance] getVacations:self forEmpNo:appDelegate.EmployeeObj.empNo];
        
        NSDate* date=[NSDate date];
        NSString *month=[StaticFuntions getIstamicMonthNumForWebService:date];
        NSString *year=[StaticFuntions getIstamicYearNumForWebService:date];
        
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [[RequestManager sharedInstance] getSalaryData:self forEmpNo:appDelegate.EmployeeObj.empNo  withMonth:month withYear:year];
        
        [[RequestManager sharedInstance] getPaymentData:self forEmpNo:appDelegate.EmployeeObj.empNo    withYear:year];
        
    }
}
-(void)initDashboardItems{
    NSMutableArray *data = [[NSMutableArray alloc] init];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (appDelegate.currentLang == Arabic) {
        
        [data addObject:[NSNumber numberWithInt:(int)CustodyDB]];
        [data addObject:[NSNumber numberWithInt:(int)JobInfoDB]];
        [data addObject:[NSNumber numberWithInt:(int)ProfileDB]];

        if (appDelegate.EmployeeObj.isTeacher) {
            
            [data addObject:[NSNumber numberWithInt:(int)PermissionsDB]];
            [data addObject:[NSNumber numberWithInt:(int)RequestsDB]];
            [data addObject:[NSNumber numberWithInt:(int)DelegationsDB]];
            
            
            [data addObject:[NSNumber numberWithInt:(int)SchduleDB]];
            
            [data addObject:[NSNumber numberWithInt:(int)PaymentDB]];
            [data addObject:[NSNumber numberWithInt:(int)SalaryDB]];
            
            [data addObject:[NSNumber numberWithInt:(int)ITSupportDB]];
            [data addObject:[NSNumber numberWithInt:(int)ContactsDB]];
            [data addObject:[NSNumber numberWithInt:(int)VacationsDB]];
            [data addObject:[NSNumber numberWithInt:(int)ReportProblemDB]];
            [data addObject:[NSNumber numberWithInt:(int)NoftificationDB]];
            [data addObject:[NSNumber numberWithInt:(int)CalenderDB]];

            if(appDelegate.EmployeeObj.hasVehicles)
                [data addObject:[NSNumber numberWithInt:(int)VehiclesDB]];
            [data addObject:[NSNumber numberWithInt:(int)Nafee]];
            [data addObject:[NSNumber numberWithInt:(int)BookDB]];

            
        } else {
            
            [data addObject:[NSNumber numberWithInt:(int)PermissionsDB]];
            [data addObject:[NSNumber numberWithInt:(int)RequestsDB]];
            [data addObject:[NSNumber numberWithInt:(int)DelegationsDB]];
            
            
            [data addObject:[NSNumber numberWithInt:(int)VacationsDB]];
            [data addObject:[NSNumber numberWithInt:(int)PaymentDB]];
            [data addObject:[NSNumber numberWithInt:(int)SalaryDB]];
            
            
            
            [data addObject:[NSNumber numberWithInt:(int)CalenderDB]];
            [data addObject:[NSNumber numberWithInt:(int)ITSupportDB]];
            [data addObject:[NSNumber numberWithInt:(int)ContactsDB]];
            
            if(appDelegate.EmployeeObj.hasVehicles)
                [data addObject:[NSNumber numberWithInt:(int)VehiclesDB]];
            
            [data addObject:[NSNumber numberWithInt:(int)BookDB]];
            [data addObject:[NSNumber numberWithInt:(int)ReportProblemDB]];
            [data addObject:[NSNumber numberWithInt:(int)NoftificationDB]];
            [data addObject:[NSNumber numberWithInt:(int)Nafee]];

            
        }

        // [data addObject:[NSNumber numberWithInt:(int)RequestsDB]];
        // [data addObject:[NSNumber numberWithInt:(int)TasksDB]];
    }
    else {
        [data addObject:[NSNumber numberWithInt:(int)ProfileDB]];

        [data addObject:[NSNumber numberWithInt:(int)JobInfoDB]];
        [data addObject:[NSNumber numberWithInt:(int)CustodyDB]];
        
        [data addObject:[NSNumber numberWithInt:(int)DelegationsDB]];
        [data addObject:[NSNumber numberWithInt:(int)RequestsDB]];
        [data addObject:[NSNumber numberWithInt:(int)PermissionsDB]];
        
        
        [data addObject:[NSNumber numberWithInt:(int)SalaryDB]];
        [data addObject:[NSNumber numberWithInt:(int)PaymentDB]];
        if(appDelegate.EmployeeObj.isTeacher)
            [data addObject:[NSNumber numberWithInt:(int)SchduleDB]];
        [data addObject:[NSNumber numberWithInt:(int)VacationsDB]];
        [data addObject:[NSNumber numberWithInt:(int)ContactsDB]];
        [data addObject:[NSNumber numberWithInt:(int)ITSupportDB]];
        [data addObject:[NSNumber numberWithInt:(int)CalenderDB]];
        [data addObject:[NSNumber numberWithInt:(int)NoftificationDB]];
        [data addObject:[NSNumber numberWithInt:(int)ReportProblemDB]];
        if(appDelegate.EmployeeObj.hasVehicles)
            [data addObject:[NSNumber numberWithInt:(int)VehiclesDB]];
        [data addObject:[NSNumber numberWithInt:(int)BookDB]];
        [data addObject:[NSNumber numberWithInt:(int)Nafee]];

    }
    self.dataArray=[[NSArray alloc] initWithObjects:data, nil];
}

#pragma mark - connection

- (void)processCompleted:(id)data error:(CustomError *)error withService:(NSNumber *)service{
    [self hideActivityViewer];
     AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(data!=nil){
        if([service intValue]==(int)GetVacationBalance_WS){
            NSMutableArray *arr=(NSMutableArray*)data;
            if(!appDelegate.DB_data)
                appDelegate.DB_data=[[DashboardDataObj alloc] init];
            appDelegate.DB_data.emergencyVacation=[arr objectAtIndex:0];
            appDelegate.DB_data.normalVacation=[arr objectAtIndex:1];

        }else if([service intValue]==(int)EmployeeSalaryInfo_WS){
            SalaryObj* sObj=(SalaryObj*)data;
            if(sObj.totalDiscount&&sObj.totalDeserve){
                float totalDesrve=[sObj.totalDeserve floatValue];
                float totalDiscount=[sObj.totalDiscount floatValue];
                float net= totalDesrve-totalDiscount;
                if(!appDelegate.DB_data)
                    appDelegate.DB_data=[[DashboardDataObj alloc] init];
                appDelegate.DB_data.salary= [NSString stringWithFormat:@"%.2f",net];
            }
        }else if([service intValue]==(int)EmployeePaymentList_WS){
            NSMutableArray *arr=(NSMutableArray*)data;
            float paid=0;
            float Notpaid=0;
            for(int i=0;i<[arr count];i++){
                PaymentDetailsObj *obj= [arr objectAtIndex:i];
                if(obj.isPaid)
                    paid+=[obj.amount floatValue];
                else
                    Notpaid+=[obj.amount floatValue];
            }
            if(!appDelegate.DB_data)
                appDelegate.DB_data=[[DashboardDataObj alloc] init];
            appDelegate.DB_data.paid= [NSString stringWithFormat:@"%.2f",paid];
            appDelegate.DB_data.notPaid= [NSString stringWithFormat:@"%.2f",Notpaid];
        }
       
        if(!repeatingTimer){
            NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(showTile) userInfo:nil repeats:YES];
            repeatingTimer = timer;
        }
        
    }else{
        //[StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:error.errorMessage];
    }
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
