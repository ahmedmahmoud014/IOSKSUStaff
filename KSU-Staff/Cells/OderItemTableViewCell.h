//
//  OderItemTableViewCell.h
//  KSU-Staff
//
//  Created by iOSAccount on 11/13/17.
//  Copyright © 2017 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderItemObj.h"
@interface OderItemTableViewCell : UITableViewCell{
    UILabel *orderName;
    UIImageView *orderImage;
    OrderItemObj *orderObj;
}
@property (nonatomic,retain) IBOutlet UIImageView *orderImage;
@property (nonatomic,retain) IBOutlet UILabel *orderName;
-(void)initWithOrderObj:(OrderItemObj*)obj withRowId:(int)rowId;

@end
