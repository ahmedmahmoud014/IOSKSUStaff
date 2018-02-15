//
//  ScheduleTableViewCell.h
//  KSU_Students
//
//  Created by EJ-Mac book on 8/2/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserObj.h"

@interface UserTableViewCell : UITableViewCell{
    UserObj * uObj;
    
}

@property (nonatomic,retain) IBOutlet UILabel * userNameValLbl;

-(void)initWithUserObj:(UserObj*)obj withRowId:(int)rowId;
@end
