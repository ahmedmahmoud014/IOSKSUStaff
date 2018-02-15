//
//  ScheduleTableViewCell.h
//  KSU_Students
//
//  Created by EJ-Mac book on 8/2/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServicesObj.h"

@interface ServiceTableViewCell : UITableViewCell{
    ServicesObj * sObj;
    
}

@property (nonatomic,retain) IBOutlet UILabel * ServiceNameLbl;

-(void)initWithServicesObj:(ServicesObj*)obj withRowId:(int)rowId;
@end
