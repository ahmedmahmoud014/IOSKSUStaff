//
//  FinancialViewController.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 1/11/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "FinancialViewController.h"
#import "LocalizedMessages.h"

@interface FinancialViewController ()

@end

@implementation FinancialViewController
@synthesize paymentView;
@synthesize salaryView;

@synthesize paymentImgBtn;
@synthesize salaryImgBtn;

@synthesize paymentBtn;
@synthesize SalaryBtn;

@synthesize arrowPayImg;
@synthesize arrowSalImg;
@synthesize titleLbl;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customizeNavigationBar:YES WithMenu:YES];
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
    [paymentView initControls];
    [salaryView initControls];
}

-(void)locatizeLables{
    [paymentView locatizeLables];
    [salaryView locatizeLables];
    titleLbl.text=finInfoDBText;
    [paymentBtn setTitle:paymentDBText forState:UIControlStateNormal];
    [SalaryBtn setTitle:salaryDBText forState:UIControlStateNormal];
}

-(void)switchToLeftLayout{
    [paymentView switchToLeftLayout];
    [salaryView switchToLeftLayout];
    titleLbl.textAlignment= NSTextAlignmentLeft;
}

-(void)switchToRightLayout{
    [paymentView switchToRightLayout];
    [salaryView switchToRightLayout];
    titleLbl.textAlignment= NSTextAlignmentRight;
}

#pragma mark - events

-(IBAction)onPaymentPressed:(id)sender{
    [self showPayment:YES];
}

-(IBAction)onSalaryPressed:(id)sender{
    [self showPayment:NO];
}

#pragma mark - methods

-(void)showPayment:(BOOL)flag{
    paymentView.hidden=!flag;
    arrowPayImg.hidden=!flag;
    
    salaryView.hidden=flag;
    arrowSalImg.hidden=flag;
}

@end
