//
//  VacationsViewController.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 10/28/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "VacationsViewController.h"
#import "LocalizedMessages.h"
#import "RequestManager.h"
#import "AppDelegate.h"
#import "StaticFuntions.h"

@interface VacationsViewController ()

@end

@implementation VacationsViewController
@synthesize titleLbl,normalVac_Lbl,normalVac_ValueLbl,emergencyVac_Lbl,emergencyVac_ValueLbl;

@synthesize controlsView;
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
    titleLbl.text=VacationTitleText;
    normalVac_Lbl.text=VacationNormalText;
    emergencyVac_Lbl.text=VacationEmergencyText;
    
}

-(void)switchToLeftLayout{
    
    titleLbl.textAlignment=NSTextAlignmentLeft;
}

-(void)switchToRightLayout{
    
    titleLbl.textAlignment=NSTextAlignmentRight;
    
}

#pragma mark - methods
-(void) connect{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[RequestManager sharedInstance] getVacations:self forEmpNo:appDelegate.EmployeeObj.empNo ];
    [self showActivityViewer];

}

#pragma mark - connection

- (void)processCompleted:(id)data error:(CustomError *)error withService:(NSNumber *)service{
    [self hideActivityViewer];
    if(data!=nil){
        NSMutableArray *arr=(NSMutableArray*)data;
        emergencyVac_ValueLbl.text=[arr objectAtIndex:0];
        normalVac_ValueLbl.text=[arr objectAtIndex:1];
    }else{
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:error.errorMessage];
    }
}

@end
