//
//  TasksTableViewCell.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 11/16/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskObj.h"

@interface TasksTableViewCell : UITableViewCell{
    UILabel *titleLbl;
    UILabel *valueLbl;
    
    TaskObj *tObj;
}

@property (nonatomic,retain) IBOutlet UILabel *titleLbl;
@property (nonatomic,retain) IBOutlet UILabel *valueLbl;


-(void) initWithTaskObj:(TaskObj*)obj withRowId:(int)index;


@end
