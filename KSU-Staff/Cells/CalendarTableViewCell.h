//
//  CalendarTableViewCell.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 11/13/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarObj.h"

@interface CalendarTableViewCell : UITableViewCell{
    UILabel* eventLbl;
    UILabel *fromLbl;
    UILabel *fromTextLbl;
    UILabel *toLbl;
    UILabel *toTextLbl;
    
    UIView *fristCircle;
    UIView *secondCircle;
    UIView *circlesSepalator;
    
}
@property (nonatomic,retain) IBOutlet UILabel* eventLbl;
@property (nonatomic,retain) IBOutlet UILabel *fromLbl;
@property (nonatomic,retain) IBOutlet UILabel *fromTextLbl;
@property (nonatomic,retain) IBOutlet UILabel *toLbl;
@property (nonatomic,retain) IBOutlet UILabel *toTextLbl;

@property (nonatomic,retain) IBOutlet UIView *fristCircle;
@property (nonatomic,retain) IBOutlet UIView *secondCircle;
@property (nonatomic,retain) IBOutlet UIView *circlesSepalator;

-(void)initWithCalendarObj:(CalendarObj*)obj withRowIndex:(int)row;

@end
