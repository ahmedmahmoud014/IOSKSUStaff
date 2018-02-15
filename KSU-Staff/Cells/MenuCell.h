//
//  MenuCell.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 11/10/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuCellObj.h"

@interface MenuCell : UITableViewCell{
    MenuCellObj* menuObj;
}

@property (nonatomic,retain) IBOutlet UILabel* menuNameLbl;
@property (nonatomic,retain) IBOutlet UIImageView* menuImgView;
@property (nonatomic,retain) IBOutlet UISwitch *NotifSwitch;

-(void) initWithMenu:(MenuCellObj*)menu;
-(void) initWithName:(NSString *)Name withImage:(UIImage *)img isSwitch:(BOOL)isSwitch;
-(IBAction)onSwitchChanged:(id)sender;
@end
