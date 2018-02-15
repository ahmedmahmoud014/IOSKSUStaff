//
//  DB_DataCollectionViewCell.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 2/24/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DashboardDataObj.h"

@interface DB_DataCollectionViewCell : UICollectionViewCell{
    UILabel *salaryTitleLbl;
    UILabel *salaryLbl;
    UILabel *firstTitleLbl;
    UILabel *firstValueLbl;
    UILabel *secondTitleLbl;
    UILabel *secondValueLbl;
    
    UIView *salaryFirstView;
    UIView *salarySecondView;
    UIView *valuesView;
    DashboardDataObj *DBobj;
}
@property (nonatomic, strong) IBOutlet UILabel *salaryTitleLbl;
@property (nonatomic, strong) IBOutlet UILabel *salaryLbl;
@property (nonatomic, strong) IBOutlet UILabel *firstTitleLbl;
@property (nonatomic, strong) IBOutlet UILabel *firstValueLbl;
@property (nonatomic, strong) IBOutlet UILabel *secondTitleLbl;
@property (nonatomic, strong) IBOutlet UILabel *secondValueLbl;

@property (nonatomic, strong) IBOutlet UIView *salaryFirstView;
@property (nonatomic, strong) IBOutlet UIView *salarySecondView;
@property (nonatomic, strong) IBOutlet UIView *valuesView;


-(void)initWithDashboardData:(DashboardDataObj*)obj withType:(MyDashBoardData)type;

@end
