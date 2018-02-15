//
//  CategoryItemesTableViewCell.h
//  KSU-Staff
//
//  Created by iOSAccount on 11/6/17.
//  Copyright © 2017 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryListItems.h"

@interface CategoryItemesTableViewCell : UITableViewCell
{
    UILabel *itemDiscount;
    UILabel *itemName,*like,*disLike,*stauts,*expire_date;
    UIImageView *itemImage ,*statusImage;
    CategoryListItems *catItem ;
}

@property (nonatomic,retain) IBOutlet UILabel *itemDiscount;
@property (nonatomic,retain) IBOutlet UILabel *itemName;
@property (nonatomic,retain) IBOutlet UIImageView *itemImage;

@property (nonatomic,retain) IBOutlet UILabel *status;
@property (nonatomic,retain) IBOutlet UILabel *like;
@property (nonatomic,retain) IBOutlet UILabel *disLike;
@property (nonatomic,retain) IBOutlet UILabel *expire_date;

@property (nonatomic,retain) IBOutlet UIImageView *statusImage;

//@property (nonatomic,retain) IBOutlet UIImageView *genderImg;

-(void)initWithCatItemObj:(CategoryListItems*)obj withRowId:(int)rowId;


@end
