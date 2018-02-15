//
//  ScheduleTableViewCell.h
//  KSU_Students
//
//  Created by EJ-Mac book on 8/2/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DelegationObj.h"

@interface DelegationTableViewCell : UITableViewCell{
    DelegationObj * dObj;
    
}

@property (nonatomic,retain) IBOutlet UIImageView * statusImg;

@property (nonatomic,retain) IBOutlet UILabel * userNameTitleLbl;
@property (nonatomic,retain) IBOutlet UILabel * startTimeTitleLbl;
@property (nonatomic,retain) IBOutlet UILabel * endTimeTitleLbl;
@property (nonatomic,retain) IBOutlet UILabel * serviceNameTitleLbl;
@property (nonatomic,retain) IBOutlet UILabel * RequestIDTitleLbl;

@property (nonatomic,retain) IBOutlet UILabel * userNameValLbl;
@property (nonatomic,retain) IBOutlet UILabel * startTimeValLbl;
@property (nonatomic,retain) IBOutlet UILabel * endTimeValLbl;
@property (nonatomic,retain) IBOutlet UILabel * serviceNameValLbl;
@property (nonatomic,retain) IBOutlet UILabel * RequestIDValLbl;





-(void)initWithDelegationObj:(DelegationObj*)obj withRowId:(int)rowId;
@end
