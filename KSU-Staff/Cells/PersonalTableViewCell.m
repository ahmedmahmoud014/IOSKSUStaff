//
//  PersonalTableViewCell.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 1/1/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "PersonalTableViewCell.h"
#import <QuartzCore/QuartzCore.h>


@implementation PersonalTableViewCell
@synthesize nameArLbl,nameEnLbl,profileImg;

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initWithProfileObj:(ProfileObj *)obj{
    profileImg.layer.cornerRadius =profileImg.frame.size.width / 2;
    profileImg.clipsToBounds = YES;

    profileImg.layer.borderWidth=0.5f;
    profileImg.layer.backgroundColor=[[UIColor colorWithRed:237.0/255.0 green:237.0/255.0 blue:237.0/255.0 alpha:1] CGColor];
    
    nameEnLbl.text=obj.latinName;
    nameArLbl.text=obj.fullName;
    if(obj.isMale){
        profileImg.image=[UIImage imageNamed:@"male.png"];
    }else{
        profileImg.image=[UIImage imageNamed:@"female.png"];
    }

}

@end
