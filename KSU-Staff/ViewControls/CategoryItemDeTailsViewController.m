//
//  CategoryItemDeTailsViewController.m
//  KSU-Staff
//
//  Created by iOSAccount on 11/14/17.
//  Copyright © 2017 E-Jawdah. All rights reserved.
//

#import "CategoryItemDeTailsViewController.h"
#import "CategoryItemesViewController.h"
#import "CategoryDetailsCollection.h"
#import "ShowImageFullScreenViewController.h"
#import "AppDelegate.h"

#import "FLAnimatedImageView+WebCache.h"
#import "UIImageView+WebCache.h"

@implementation CategoryItemDeTailsViewController

@synthesize itemName,like,disLike,itemDiscount,status,itemImage,statusImage;
-(void)viewDidLoad{
    [super viewDidLoad];
//     [self customizeNavigationBar:YES WithMenu:YES];
    
    // navigation  button  replace
    [self replaceHomeAndMenu:_homeBtn :_menuBtn];
    
     [self initValues:self.catItem];
    
    
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:true animated:animated];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
   // [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (IBAction)back:(id)sender {
   // [self dismissViewControllerAnimated:YES completion:nil];
//    [self.navigationController setNavigationBarHidden:NO animated:true];

    CategoryItemesViewController * viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CategoryItemesViewController"];
    
    viewController.dataArray =  self.dataArray ; 
    [self.navigationController pushViewController:viewController animated:YES];
    
//    [self.navigationController popToRootViewControllerAnimated:YES];

}

-(void)initValues:(CategoryListItems *)catItem{
    catItem = self.catItem;
    self.detailsName.text= catItem.title;
    itemName.text= catItem.title;
    //    NSString *str = @"hello ";
    //    str = [str stringByAppendingString:@"world"];
    itemDiscount.text = [NSString stringWithFormat: @"%@ %@" ,(catItem.discount_perc).stringValue,@"٪ خصم "];
    like.text= (catItem.likes).stringValue;
    disLike.text= (catItem.dislikes).stringValue;
    NSString *status_Value= catItem.status;
    status.text= status_Value;
    if([status_Value isEqual:@"open"]){
        statusImage.image = [UIImage imageNamed:@"open"];
    }
    else {
        statusImage.image = [UIImage imageNamed:@"featured"];
    }
    NSString *date_value = catItem.expiration_date  ;
    if(![date_value isEqual:@""]){
        NSString * timeStampString =date_value;
        NSTimeInterval _interval=[timeStampString doubleValue];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
        NSDateFormatter *_formatter=[[NSDateFormatter alloc]init];
        [_formatter setDateFormat:@"dd/MM/yyyy"];
        self.expire_date.text=[_formatter stringFromDate:date];
        
        
        
    }
    else{
        self.expire_date.text=@"no date";
        
    }
    
    
    self.showDetails.text= catItem.description;
    NSString *phone_value= catItem.contact.phone;
    if (![phone_value isEqualToString:@""]){
    [self.phone setTitle: phone_value
                forState:UIControlStateNormal];
    }else {
        [self.phone setTitle: @"لا  يوجد بيانات "
                    forState:UIControlStateNormal];
//        self.phone.hidden= true;
//        self.phone_image.hidden=true;
        
    }
    
    // add mobile
   
    
    NSString *mobile_value=catItem.contact.mobile;
    if (![mobile_value isEqualToString:@""]){
        [self.mobile setTitle: mobile_value
                    forState:UIControlStateNormal];
    }else {
        [self.mobile setTitle: @"لا  يوجد بيانات "
                    forState:UIControlStateNormal];
//        self.mobile.hidden= true;
//        self.mobile_image.hidden=true;
//
    }
      // add email
    
    NSString *email_value=catItem.contact.email;
    if (![email_value isEqualToString:@""]){
        [self.email setTitle: email_value
                     forState:UIControlStateNormal];
    }else {
        [self.email setTitle: @"لا  يوجد بيانات "
                    forState:UIControlStateNormal];
//        self.email.hidden= true;
//        self.email_image.hidden=true;
        
    }
    // add website
    NSString *website_value=catItem.contact.website;
    if (![website_value isEqualToString:@""]){
        [self.website setTitle: website_value                   forState:UIControlStateNormal];
    }else {
        [self.website setTitle: @"لا  يوجد بيانات "
                    forState:UIControlStateNormal];
//        self.website.hidden= true;
//        self.website_image.hidden=true;
        
    }
    
    // add location
    NSString *location = catItem.contact.location ;
    if(![location isEqual:@""]){
    [self.location setTitle: location forState:UIControlStateNormal];
    }else {
        self.locatioView.hidden= true;
    }
    itemImage.layer.borderWidth = .5f;
    itemImage.layer.borderColor = [[UIColor grayColor] CGColor];
   // [itemImage setImage:catItem.slide_images[0]];
    [itemImage sd_setImageWithURL:[NSURL URLWithString:catItem.slide_images[0]]
                 placeholderImage:[UIImage imageNamed:@"loader"]
                          options:SDWebImageRefreshCached];
    
    
//    if ([phone_value isEqualToString:@""]&&[mobile_value isEqualToString:@""]&&[email_value isEqualToString:@""]&&[website_value isEqualToString:@""]){
//        self.contactview.hidden= true ;
//
//    }
    
}


#pragma mark - collectionview delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ShowImageFullScreenViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ShowImageFullScreenViewController"];
    NSLog(@"index row   %ld",indexPath.row);
    viewController.imageValue = self.catItem.slide_images[indexPath.row];
    [viewController setModalPresentationStyle:UIModalPresentationFormSheet];
    [viewController setModalTransitionStyle: UIModalTransitionStyleFlipHorizontal];
    [self presentViewController:viewController animated:NO completion:nil];
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.catItem.slide_images.count;
}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    return CGSizeMake(CGRectGetWidth(collectionView.frame) /2, 100);
//}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView_ cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //    // Setup cell identifier
    static NSString *cellIdentifier = @"categoryDetailsCell";
    CategoryDetailsCollection *cell = [self.detailscoolection dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell initalizeValues: self.catItem.slide_images[indexPath.row]];
    return cell;
}
-(void)buttonClick:(UIButton *)sender{
    //UIButton *button=(UIButton*)sender;
    NSLog(@"button click %ld",sender.tag);
    //    if (sender.tag == 0){
    //        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.catItem.contact.phone]]];
    //
    //    }
    //    if (sender.tag == 1){
    //        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.catItem.contact.mobile]]];
    //
    //    }
    
    if ( sender.tag == 4){
        
        NSString* directionsURL = [NSString stringWithFormat: @"%@", self.catItem.contact.location];
        if ([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString: directionsURL] options:@{} completionHandler:^(BOOL success) {}];
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString: directionsURL]];
        }

    }
    
}

- (IBAction)btnHomeOrMenuPress:(UIButton *)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UIButton *button = (UIButton *)sender;
    NSInteger *tag  =  [button tag];
    // menu button
    if (tag ==  0 )  {
        
        if(appDelegate.currentLang==Arabic)
        {
            [self showMenu];
        }else{
            [self  backHome];
        }
        
        
        
    }
    // home button
    else {
        if(appDelegate.currentLang==Arabic)
        {
            [self  backHome];
        }else{
            [self showMenu];
        }
        
    }
}
@end
