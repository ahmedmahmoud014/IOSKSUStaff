//
//  SalaryBalanceTableViewCell.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 10/19/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SalaryDetailsObj.h"
@interface SalaryBalanceTableViewCell : UITableViewCell{
    UILabel *codeLbl;
    UILabel *descriptionLbl;
    UILabel *valueLbl;
    SalaryDetailsObj *sDet_Obj;
    UIImageView* imageView;

}
@property (nonatomic,retain) IBOutlet UILabel *codeLbl;
@property (nonatomic,retain) IBOutlet UILabel *descriptionLbl;
@property (nonatomic,retain) IBOutlet UILabel *valueLbl;
@property (nonatomic,retain) IBOutlet UIImageView* imageView;

-(void)initWithSalaryDetailsObj:(SalaryDetailsObj*)salary withRowIndex:(int)rowID ;
@end
