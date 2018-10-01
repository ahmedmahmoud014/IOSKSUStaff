//
//  CartegoriesViewController.m
//  KSU-Staff
//
//  Created by iOSAccount on 11/2/17.
//  Copyright © 2017 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CartegoriesViewController.h"
#import "CategoryCollectionCell.h"
#import "NHAlignmentFlowLayout.h"
#import "AppDelegate.h"
#import "DashBoardObj.h"
#import "RequestManager.h"
#import "StaticFuntions.h"
#import "Categories.h"
#import "CategoryItemesViewController.h"
#import "CustomNavigationController.h"
#import "LoginViewController.h"
#import "DashBoardViewController.h"


#import "LocalizedMessages.h"


@interface CartegoriesViewController ()

@end

@implementation CartegoriesViewController
@synthesize collectionView,dataArray;
NSMutableArray *allCategoriesName;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self customizeNavigationBar:YES WithMenu:YES];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(!appDelegate.isSendingDeviceToken)
        [appDelegate updateDeviceToken];
        if(IS_IPAD){
        int x= (self.view.frame.size.width- collectionView.frame.size.width)/2;
        int y= 100;//(self.view.frame.size.height- collectionView.frame.size.height)/2;
        collectionView.frame=CGRectMake(x, y, collectionView.frame.size.width, collectionView.frame.size.height);
    }
    
    
    
    // navigation  button  replace
    [self replaceHomeAndMenu:_homeBtn :_menuBtn];
    
    // [collectionView setTransform:CGAffineTransformMakeScale(-1, 1)];
    
    
    NHAlignmentFlowLayout *layout = [[NHAlignmentFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(5.0, 5.0, 0.0, 0.0);
    
    if(appDelegate.currentLang==Arabic)
    {
        layout.alignment = NHAlignmentBottomRightAligned;
        self.showServiceName.textAlignment=NSTextAlignmentRight;
        self.showServiceName.text= @"خدمة نافع";

    }
    else
    {
        layout.alignment = NHAlignmentTopLeftAligned;
        self.showServiceName.textAlignment=NSTextAlignmentLeft;
        self.showServiceName.text= @"nafee service";
    }
    
    
    layout.itemSize = CGSizeMake(100.0, 100.0);
    layout.minimumInteritemSpacing = 5.0;
    layout.minimumLineSpacing = 5.0;
    
    self.collectionView.collectionViewLayout = layout;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    //
    //
    //
    
    if([self isNetworkAvailable] ==YES)
    {
        NSLog(@"Network Connection available");
        [self connect];
    }
    
    else{
        [StaticFuntions showAlertWithTitle:NetWorkTitle Message:NetWorkBody];
        
    }
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:true animated:true];

}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// 1
#pragma mark - collectionview delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    return CGSizeMake(CGRectGetWidth(collectionView.frame) /2, 100);
//}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView_ cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //    // Setup cell identifier
    static NSString *cellIdentifier = @"category";
    CategoryCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (self.dataArray.count !=0){
        Categories  *category = [self.dataArray objectAtIndex:indexPath.row];
        cell.titleLabel.text =  category.fullName;
        NSString *value =category.category_id;
        
        if ([value  isEqual: @"22"]){
            [cell.imageView setImage: [UIImage imageNamed:@"education"]];
            
        }
        
        else if ([value  isEqual: @"1"]){
            [cell.imageView setImage: [UIImage imageNamed:@"travel"]];
            
        }
        else if ([value  isEqual: @"19"]){
            [cell.imageView setImage: [UIImage imageNamed:@"health"]];
            
        }
        else if ([value  isEqual: @"2"]){
            [cell.imageView setImage: [UIImage imageNamed:@"food"]];
            
        }
        else if ([value  isEqual: @"6"]){
            [cell.imageView setImage: [UIImage imageNamed:@"cars"]];
            
        }
        else if ([value  isEqual: @"3"]){
            [cell.imageView setImage: [UIImage imageNamed:@"shops"]];
            
        }
        else {
            [cell.imageView setImage: [UIImage imageNamed:@"other_sections"]];
            
        }
        //
    }
    //[cell.imageView setImage: [UIImage imageNamed:@"books_db@2x"]];
    
    return cell;
    
}
//- (CGSize)collectionView:(UICollectionView *)collectionView
//                  layout:(UICollectionViewLayout *)collectionViewLayout
//  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    CGRect screenRect = [[UIScreen mainScreen] bounds];
//    CGFloat screenWidth = screenRect.size.width;
//    float cellWidth = screenWidth / 3.0; //Replace the divisor with the column count requirement. Make sure to have it in float.
//    CGSize size = CGSizeMake(cellWidth, cellWidth);
//
//    return size;
//}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //    NSMutableArray *data = [self.dataArray objectAtIndex:indexPath.section];
    //    MyDashBoard mydash = (MyDashBoard)[[data objectAtIndex:indexPath.row] intValue] ;
    //    NSString *seagueName=[DashBoardObj getDBItemSeague:mydash];
    //    if(seagueName==nil)return;
    
   // [self.navigationController setNavigationBarHidden:NO animated:true];

    Categories  *category = [self.dataArray objectAtIndex:indexPath.row];
    CategoryItemesViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CategoryItemesViewController"];
        viewController.cat_URl=category.url_title;
    viewController.cat_Name=category.fullName;
    [self moveToNext:viewController];

    //
   // [self.navigationController pushViewController:viewController animated:NO];
    // AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
}

- (void)processCompleted:(id)data error:(CustomError *)error withService:(NSNumber *)service {
    if(data!=nil)
    {
        self.dataArray = data;
        if (self.dataArray.count !=0 ){
        [self.collectionView reloadData];
        }
        else {
            self.noData.hidden=false;
            self.collectionView.hidden=true;
            
        }
        [self hideActivityViewer];
        
        
        
    }
    else{
        [StaticFuntions showAlertWithTitle: ErrorGeneralTitle Message:ServerErrorMsg];
        [self hideActivityViewer];
        
    }
    
}



-(void)connect{
    // get categories
    [[RequestManager sharedInstance] getOffersCategories:self ];
    [self showActivityViewer];
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

