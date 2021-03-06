//
//  SettingArViewController.h
//  KSU-Staff
//
//  Created by iOSAccount on 12/3/17.
//  Copyright © 2017 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

typedef enum mysettingItems{
    LangSettingItem=0,
    NotifSettingItem,
    TotalsDBSettingItem,
    AboutSettingItem
    
}MysettingItems;

@interface SettingArViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{
    UILabel *titleLbl;
    
    UITableView *tableView;
    UITableViewCell *languageCell;
    UITableViewCell *notificationCell;
    UITableViewCell *aboutCell;
    UITableViewCell *totalsDBCell;
    
    UILabel *languageLbl;
    UILabel *languageValLbl;
    UILabel *notifictionLbl;
    UISwitch *notificationSwitch;
    UILabel *aboutLbl;
    UILabel *totalsDBLbl;
    UISwitch *totalsSwitch;
}

@property(nonatomic,retain)IBOutlet UILabel *titleLbl;
@property(nonatomic,retain)IBOutlet UITableView *tableView;
@property(nonatomic,retain)IBOutlet UITableViewCell *languageCell ;
@property(nonatomic,retain)IBOutlet UITableViewCell *notificationCell;
@property(nonatomic,retain)IBOutlet UITableViewCell *aboutCell;

@property(nonatomic,retain)IBOutlet UITableViewCell *totalsDBCell;

@property(nonatomic,retain)IBOutlet UILabel *languageLbl;
@property(nonatomic,retain)IBOutlet UILabel *languageValLbl;
@property(nonatomic,retain)IBOutlet UILabel *notifictionLbl;
@property(nonatomic,retain)IBOutlet UISwitch *notificationSwitch;
@property(nonatomic,retain)IBOutlet UILabel *aboutLbl;

@property(nonatomic,retain)IBOutlet UILabel *totalsDBLbl;
@property(nonatomic,retain)IBOutlet UISwitch *totalsSwitch;

-(IBAction)onswitchchanged:(id)sender;

-(IBAction)onTotalsSwitchchanged:(id)sender;

// for custom  menu  bar
@property (weak, nonatomic) IBOutlet UIButton *menuBtn;
@property (weak, nonatomic) IBOutlet UIButton *homeBtn;
- (IBAction)btnHomeOrMenuPress:(UIButton *)sender;
@end
