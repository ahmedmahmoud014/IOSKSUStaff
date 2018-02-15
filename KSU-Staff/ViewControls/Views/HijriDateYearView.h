//
//  HijriDateYearView.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 10/22/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NTYearPicker.h"

@protocol HijriDateYearDelegate <NSObject>

-(void)onSelectDate:(NSDate*)selectedDate;

@end
@interface HijriDateYearView : UIView{
    NTYearPicker *yearPicker;
    UIToolbar *toolBar;
    UIBarButtonItem *cancelBtn;
    UIBarButtonItem *doneBtn;
    id delegate;
}

@property (nonatomic,retain)IBOutlet NTYearPicker *yearPicker;
@property (nonatomic,retain)IBOutlet UIToolbar *toolBar;
@property (nonatomic,retain)IBOutlet UIBarButtonItem *cancelBtn;
@property (nonatomic,retain)IBOutlet UIBarButtonItem *doneBtn;

-(void)initIslamicDatewithDelegate:(id)del;


-(IBAction)onDonePressed:(id)sender;
-(IBAction)onCancelPressed:(id)sender;

@end
