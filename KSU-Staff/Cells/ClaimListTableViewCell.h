//
//  ClaimListTableViewCell.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 2/2/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClaimObj.h"

@interface ClaimListTableViewCell : UITableViewCell{
    UILabel* createDateLbl;
    UILabel* claimDescpLbl;
    UILabel* ticketNoLbl;
    ClaimObj *cObj;
}

@property (nonatomic,retain) IBOutlet UILabel* createDateLbl;
@property (nonatomic,retain) IBOutlet UILabel* claimDescpLbl;
@property (nonatomic,retain) IBOutlet UILabel* ticketNoLbl;

-(void)initWithObj:(ClaimObj*)obj  withRowIndex:(int)rowID;

@end
