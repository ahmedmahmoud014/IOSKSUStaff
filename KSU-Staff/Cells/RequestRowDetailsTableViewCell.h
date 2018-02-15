//
//  RequestsTableViewCell.h
//  KSU_Students
//
//  Created by EJ-Mac book on 8/2/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RPageSectionRowObj.h"



@interface RequestRowDetailsTableViewCell : UITableViewCell{
}
@property (nonatomic,retain) IBOutlet UILabel * title1Lbl;
@property (nonatomic,retain) IBOutlet UILabel * value1Lbl;
@property (nonatomic,retain) IBOutlet UILabel * title2Lbl;
@property (nonatomic,retain) IBOutlet UILabel * value2Lbl;
@property (nonatomic,retain) IBOutlet UIButton * detailsBtn;
@property (nonatomic,retain) IBOutlet UIView * separatorView;

-(void)initWithRequestRowItemsObj:(RPageSectionRowObj*)obj1 obj2:(RPageSectionRowObj*)obj2 withRowId:(int)rowId withHeight:(int)height;
@end
