//
//  PaymentTableViewCell.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 10/22/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaymentDetailsObj.h"



@interface PaymentTableViewCell : UITableViewCell{
    UILabel *titleLbl;
    UILabel *valueLbl;
    
    PaymentDetailsObj *pDetObj;
}

@property (nonatomic,retain) IBOutlet UILabel *titleLbl;
@property (nonatomic,retain) IBOutlet UILabel *valueLbl;


-(void) initWithPaymentDetObj:(PaymentDetailsObj*)obj withRowId:(int)index;

@end
