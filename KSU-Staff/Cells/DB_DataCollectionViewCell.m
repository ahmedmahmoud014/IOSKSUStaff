//
//  DB_DataCollectionViewCell.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 2/24/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "DB_DataCollectionViewCell.h"
#import "LocalizedMessages.h"


@implementation DB_DataCollectionViewCell
@synthesize salaryTitleLbl, salaryLbl,secondTitleLbl,secondValueLbl;
@synthesize firstTitleLbl,firstValueLbl;

@synthesize valuesView,salaryFirstView,salarySecondView;

-(void)initWithDashboardData:(DashboardDataObj*)obj withType:(MyDashBoardData)type{
    
    
    switch (type) {
        case salaryData:
            [self showSalaryView:YES];
            salaryTitleLbl.text=TotalNetText;//SalaryTotalsText;
            salaryLbl.text=obj.salary;
            
            [salaryLbl setTextColor:[UIColor colorWithRed:248.0/255.0 green:163.0/255.0 blue:93.0/255.0 alpha:1]];
            break;
        case paymentData:
            [self showSalaryView:NO];
            firstTitleLbl.text=PaymentPaidText;
            firstValueLbl.text=obj.paid;
            
            secondTitleLbl.text=PaymentNotPaidText;
            secondValueLbl.text=obj.notPaid;
            
            [firstValueLbl setTextColor:[UIColor colorWithRed:20.0/255.0 green:122.0/255.0 blue:185.0/255.0 alpha:1]];
            [secondValueLbl setTextColor:[UIColor colorWithRed:20.0/255.0 green:122.0/255.0 blue:185.0/255.0 alpha:1]];
            break;
        case vacationData:
            [self showSalaryView:NO];
            
            firstTitleLbl.text=NormalText;
            firstValueLbl.text=obj.normalVacation;
            
            secondTitleLbl.text=EmergencyText;
            secondValueLbl.text=obj.emergencyVacation;
            
            [firstValueLbl setTextColor:[UIColor colorWithRed:233.0/255.0 green:19.0/255.0 blue:3.0/255.0 alpha:1]];
            [secondValueLbl setTextColor:[UIColor colorWithRed:233.0/255.0 green:19.0/255.0 blue:3.0/255.0 alpha:1]];

            break;
        default:
            break;
    }
    
    
     self.contentView.alpha = 0.0;
    [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft /*UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseInOut*/ animations:^{
        self.contentView.alpha = 1.0;
    } completion:nil];
    
    
}

-(void)showSalaryView:(BOOL)show{
    firstValueLbl.hidden=show;
    secondValueLbl.hidden=show;
    firstTitleLbl.hidden=show;
    secondTitleLbl.hidden=show;
    valuesView.hidden=show;
    
    salaryFirstView.hidden=!show;
    salarySecondView.hidden=!show;
    salaryTitleLbl.hidden=!show;
    salaryLbl.hidden=!show;
}
@end
