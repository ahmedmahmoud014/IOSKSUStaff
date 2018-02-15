//
//  SalaryPaymentTableViewCell.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 10/19/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SalaryObj.h"

@interface SalaryPaymentTableViewCell : UITableViewCell{
    UILabel *titleLbl;
    UILabel *valueLbl;
    SalaryObj *sObj;

}
@property (nonatomic,retain) IBOutlet UILabel *titleLbl;
@property (nonatomic,retain) IBOutlet UILabel *valueLbl;

-(void)initWithSalaryObj:(SalaryObj*)salary withIndexPath:(NSIndexPath*)indexPath withSection:(SalarySections) section;
@end
