//
//  CategoryItemes.h
//  KSU-Staff
//
//  Created by iOSAccount on 11/6/17.
//  Copyright © 2017 E-Jawdah. All rights reserved.
//

#ifndef CategoryItemes_h
#define CategoryItemes_h


#endif /* CategoryItemes_h */
#import "BaseViewController.h"
//#import "ProfileObj.h"
#import "DataTransfer.h"

@interface CategoryItemesViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,DataTransferDelegate>{
    
    UILabel *titleLbl;
    UITableView *tableView;
    NSMutableArray *dataArray;
    NSString *checkOrder;
    
//    ProfileObj *pObj;
//    PassportObj *passObj;
}
//@property (weak, nonatomic) IBOutlet UIImageView *offer_likes_left;
//@property (weak, nonatomic) IBOutlet UIImageView *offer_expire_left;
//@property (weak, nonatomic) IBOutlet UIImageView *offfer_discount_right;
//@property (weak, nonatomic) IBOutlet UIImageView *offer_new_left;
@property (weak, nonatomic) IBOutlet UIButton *showListColor;
//@property (weak, nonatomic) IBOutlet UIImageView *offer_order_new_image;
@property (weak, nonatomic) IBOutlet UIButton *offer_order_new;
@property (weak, nonatomic) IBOutlet UIButton *offer_order_discount;
@property (weak, nonatomic) IBOutlet UIButton *offer_order_expire;
@property (weak, nonatomic) IBOutlet UIButton *offer_order_likes;
@property (weak, nonatomic) IBOutlet UILabel *nodata;
//@property (weak, nonatomic) IBOutlet UIImageView *offer_order_discount_image;
//@property (weak, nonatomic) IBOutlet UIImageView *offer_order_expire_image;
//@property (weak, nonatomic) IBOutlet UIImageView *like;

- (IBAction)orderAction:(UIButton *)sender;
- (IBAction)showOrderList:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *orderItems;
@property(nonatomic,retain) IBOutlet UILabel *titleLbl;
@property(nonatomic,retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain)  NSString *cat_URl;
@property (nonatomic, retain) NSString *cat_Name;
@property (nonatomic, retain)  NSMutableArray *dataArray;
@property (nonatomic, assign) NSString *checkOrder;

-(void )orderAllItems :(NSString*) oreder_type;
-(void)connect;
-(void) assignValueForOrderItems;
- (IBAction)backToCategory:(id)sender;

// for custom  menu  bar
@property (weak, nonatomic) IBOutlet UIButton *menuBtn;
@property (weak, nonatomic) IBOutlet UIButton *homeBtn;
- (IBAction)btnHomeOrMenuPress:(UIButton *)sender;
@end
