//
//  CategoryItemDeTailsViewController.h
//  KSU-Staff
//
//  Created by iOSAccount on 11/14/17.
//  Copyright © 2017 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "CategoryListItems.h"

@interface CategoryItemDeTailsViewController :BaseViewController<UICollectionViewDataSource,UICollectionViewDelegate,UIGestureRecognizerDelegate> {
    UILabel *itemDiscount;
    UILabel *itemName,*like,*disLike,*stauts,*expire_date;
    UIImageView *itemImage ,*statusImage;
    //CategoryListItems *catItem ;
    
}
@property (weak, nonatomic) IBOutlet UIView *locatioView;
@property (weak, nonatomic) IBOutlet UIView *contactview;

- (IBAction)buttonClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextView *showDetails;
@property (weak, nonatomic) IBOutlet UIImageView *phone_image;
@property (weak, nonatomic) IBOutlet UIImageView *mobile_image;
@property (weak, nonatomic) IBOutlet UIImageView *website_image;
@property (weak, nonatomic) IBOutlet UIImageView *email_image;
@property (weak, nonatomic) IBOutlet UIButton *phone;
@property (weak, nonatomic) IBOutlet UIButton *mobile;
@property (weak, nonatomic) IBOutlet UIButton *email;
@property (weak, nonatomic) IBOutlet UIButton *website;
@property (weak, nonatomic) IBOutlet UIButton *location;

@property (weak, nonatomic) IBOutlet UICollectionView *detailscoolection;
@property (nonatomic,retain) IBOutlet UILabel *itemDiscount;
@property (nonatomic,retain) IBOutlet UILabel *itemName;
@property (nonatomic,retain) IBOutlet UIImageView *itemImage;

@property (nonatomic,retain) IBOutlet UILabel *status;
@property (nonatomic,retain) IBOutlet UILabel *like;
@property (nonatomic,retain) IBOutlet UILabel *disLike;
@property (nonatomic,retain) IBOutlet UILabel *expire_date;
@property (nonatomic,retain) IBOutlet UIImageView *statusImage;
@property (nonatomic, retain) CategoryListItems *catItem;
@property (nonatomic, retain) NSString *catName;
- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UINavigationItem *detailsName;

-(void) initValues :(CategoryListItems *)catItem;

@end
