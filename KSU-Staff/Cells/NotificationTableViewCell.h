//
//  NotificationTableViewCell.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 6/25/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotifyDetailsObj.h"

@interface NotificationTableViewCell : UITableViewCell{
    UILabel * notifyLbl;
    UILabel * dateLbl;
    NotifyDetailsObj *nObj;
}

@property (nonatomic,retain) IBOutlet UILabel * notifyLbl;
@property (nonatomic,retain) IBOutlet UILabel * dateLbl;

-(void)initWithNotifyObj:(NotifyDetailsObj*)obj withRowId:(int)rowId;

@end
