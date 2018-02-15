//
//  PermissionsTableViewCell.h
//  KSU_Students
//
//  Created by EJ-Mac book on 8/10/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageObj.h"

@interface PermissionsTableViewCell : UITableViewCell{
    PageObj * pObj;
}
@property (nonatomic,retain) IBOutlet UILabel *pageNameLbl;
@property (nonatomic,retain) IBOutlet UILabel *actionsLbl;

-(void) initWithPageObj:(PageObj *)page withRowId:(int)rowID;
@end