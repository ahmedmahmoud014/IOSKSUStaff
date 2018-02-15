//
//  PersonalTableViewCell.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 1/1/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileObj.h"

@interface PersonalTableViewCell : UITableViewCell{
    UILabel* nameArLbl;
    UILabel* nameEnLbl;
    UIImageView *profileImg;
}
@property (nonatomic,retain)IBOutlet UILabel* nameArLbl;
@property (nonatomic,retain)IBOutlet UILabel* nameEnLbl;
@property (nonatomic,retain)IBOutlet UIImageView *profileImg;

-(void)initWithProfileObj:(ProfileObj*)obj;
@end
