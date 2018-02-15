//
//  ProfileTableViewCell.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 10/15/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileObj.h"
#import "PassportObj.h"


@interface ProfileTableViewCell : UITableViewCell{
    UILabel *titleLbl;
    UILabel *valueLbl;
    ProfileObj* pObj;
    UIImageView *boxBarImg;
 //   UIImageView *genderImg;
    UIButton *dateBtn;
    BOOL isHijri;
    PassportObj* passObj;
}

@property (nonatomic,retain) IBOutlet UILabel *titleLbl;
@property (nonatomic,retain) IBOutlet UILabel *valueLbl;

@property (nonatomic,retain) IBOutlet UIImageView *boxBarImg;
//@property (nonatomic,retain) IBOutlet UIImageView *genderImg;

@property (nonatomic,retain) IBOutlet  UIButton *dateBtn;

-(void) initWithProfileObj:(ProfileObj *)profile withIndexPath:(NSIndexPath*)indexPath withpassInfo:(PassportObj*)pass  languageType:(NSString*) languageType;

-(void) initWithJobInfo:(ProfileObj *)profile withIndexPath:(NSIndexPath*)indexPath;

-(IBAction)onDatePressed:(id)sender;
@end
