//
//  RequestsTableViewCell.h
//  KSU_Students
//
//  Created by EJ-Mac book on 8/2/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestActionsObj.h"



@interface RequestActionsTableViewCell : UITableViewCell{
    RequestActionsObj * rObj;
    
}
@property (nonatomic,retain) IBOutlet UIButton * detailsBtn;

@property (nonatomic,retain) IBOutlet UILabel * userNameTitleLbl;
@property (nonatomic,retain) IBOutlet UILabel * actionTitleLbl;
@property (nonatomic,retain) IBOutlet UILabel * dateTitleLbl;

@property (nonatomic,retain) IBOutlet UILabel * userNameValLbl;
@property (nonatomic,retain) IBOutlet UILabel * actionValLbl;
@property (nonatomic,retain) IBOutlet UILabel * dateValLbl;



-(void)initWithRequestActionsObj:(RequestActionsObj*)obj withRowId:(int)rowId;
@end
