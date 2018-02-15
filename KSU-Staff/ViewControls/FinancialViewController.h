//
//  FinancialViewController.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 1/11/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "BaseViewController.h"
#import "SalaryView.h"
#import "PaymentView.h"


@interface FinancialViewController : BaseViewController{
    PaymentView *paymentView;
    SalaryView *salaryView;
    
    UIButton *paymentImgBtn;
    UIButton *salaryImgBtn;
    
    UIButton *paymentBtn;
    UIButton *SalaryBtn;
    
    UIImageView *arrowPayImg;
    UIImageView *arrowSalImg;
    UILabel *titleLbl;
}
@property (nonatomic,retain) IBOutlet PaymentView *paymentView;
@property (nonatomic,retain) IBOutlet SalaryView *salaryView;

@property (nonatomic,retain) IBOutlet UIButton *paymentImgBtn;
@property (nonatomic,retain) IBOutlet UIButton *salaryImgBtn;

@property (nonatomic,retain) IBOutlet UIButton *paymentBtn;
@property (nonatomic,retain) IBOutlet UIButton *SalaryBtn;

@property (nonatomic,retain) IBOutlet UIImageView *arrowPayImg;
@property (nonatomic,retain) IBOutlet UIImageView *arrowSalImg;
@property (nonatomic,retain) IBOutlet UILabel *titleLbl;

-(IBAction)onPaymentPressed:(id)sender;
-(IBAction)onSalaryPressed:(id)sender;
@end
