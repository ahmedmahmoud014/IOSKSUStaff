//
//  CategoryItemes.m
//  KSU-Staff
//
//  Created by iOSAccount on 11/6/17.
//  Copyright © 2017 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CategoryItemesViewController.h"
#import "LocalizedMessages.h"
#import "StaticVariables.h"
#import "AppDelegate.h"
#import "ProfileTableViewCell.h"
#import "StaticFuntions.h"
#import "RequestManager.h"
#import "CategoryItemesTableViewCell.h"
#import "OderItemsViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "CategoryListItems.h"
#import "Contact.h"
#import "CategoryItemDeTailsViewController.h"

@implementation CategoryItemesViewController
@synthesize titleLbl;
@synthesize tableView;
NSArray *radioImage;
NSArray *radioImageButtons;
NSArray *allOrderButtons;
NSArray  *itemsNamesAll;


NSArray  *allButtonColor;


CategoryItemDeTailsViewController *viewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self customizeNavigationBar:YES WithMenu:YES];
    
    if([self isNetworkAvailable] ==YES)
    {
        NSLog(@"Network Connection available");
        [self connect];    }
    
    else{
        [StaticFuntions showAlertWithTitle:NetWorkTitle Message:NetWorkBody];
        
    }
    
    radioImage = [[NSArray alloc] init];
    radioImageButtons = [[NSArray alloc] init];
    allOrderButtons = [[NSArray alloc] init];
    itemsNamesAll=[[NSArray alloc] init];
    allButtonColor=[[NSArray alloc] init];


    if(IS_IPAD){
        int x= (self.view.frame.size.width- tableView.frame.size.width)/2;
        tableView.frame=CGRectMake(x, tableView.frame.origin.y, tableView.frame.size.width, tableView.frame.size.height);
    }
    self.titleLbl.text=  self.cat_Name;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    allOrderButtons =@[self.offer_order_new,self.offer_order_discount,self.offer_order_expire,self.offer_order_likes];
    allButtonColor=@[@0,@0,@0,@0];

    if(appDelegate.currentLang==Arabic)
    {
    
//        radioImageButtons =@[self.offer_order_new_image,self.offer_order_discount_image,self.offer_order_expire_image,self.like];
        itemsNamesAll= @[@"عرض جديد ",@"نسبة  الخصم ",@"تاريخ  الأنتهاء",@"مرات الأعجاب"];
        for (UIButton *button in allOrderButtons ) {
//            [self textAlligmentRight:button];
        }
        
    }
    else
    {
        self.nodata.text=@"there is no offers ";
        itemsNamesAll= @[@"Latest offers",@"Discount",@"Expiring soon",@"Most popular"];
       // radioImageButtons =@[self.offer_new_left,self.offfer_discount_right,_offer_expire_left,_offer_likes_left];
        for (UIButton *button in allOrderButtons) {
//            [self textAlligmentLeft:button];
        }

    }
    
}


-(void)connect{
    // get categories
    [[RequestManager sharedInstance] getCategoryItems:self CatName:self.cat_URl];
    [self showActivityViewer];
}
- (void)processCompleted:(id)data error:(CustomError *)error withService:(NSNumber *)service {
    
    if(data!=nil)
    {
        
        dataArray = (NSMutableArray*)data;
        //dataArray = sortedArray;
        [self hideActivityViewer];
        
        
        if ([dataArray count ] == 0 ){
        
            self.nodata.hidden= false;
            self.tableView .hidden= true;
            self.orderItems.hidden=true;
        }
       
    }
    else{
        [StaticFuntions showAlertWithTitle:@"error " Message:error.errorMessage];
        [self hideActivityViewer];
        
    }
    
    if (dataArray.count !=0 ){
    
    [self.tableView reloadData];
    }
    else {
        self.nodata.hidden= false;
        self.tableView .hidden= true;
        
    }
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CategoryItemDeTailsViewController"];
    
    CategoryListItems  *category = [dataArray objectAtIndex:indexPath.section];
    viewController.catItem = category;
    viewController.catName=self.cat_URl;
  //  NSLog(@"index row   %ld",indexPath.row);
    
    [viewController setModalPresentationStyle:UIModalPresentationFormSheet];
    [viewController setModalTransitionStyle: UIModalTransitionStyleFlipHorizontal];
    [self.navigationController pushViewController:viewController animated:NO];
    // [self presentViewController:viewController animated:YES completion:nil]
    // [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    //this is the space
    return 5;
}
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier=@"CategoryItemesTableViewCell";
    
    CategoryItemesTableViewCell *cell = [ tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSLog(@"index row  cell  %ld",indexPath.row);
    
    
   
   // cell.separatorInset = UIEdgeInsetsMake(10, 10, 0, 10);
//    cell.layer.borderWidth = 2.0f;
//
//    UIColor *myColor= [self colorWithHexString:@"#252628"];
//    cell.layer.borderColor= myColor.CGColor;
    //cell.layer.borderColor = [UIColor grayColor].CGColor;
    CategoryListItems *items= [dataArray objectAtIndex:(int)indexPath.section];
    [cell initWithCatItemObj:items withRowId:(int)indexPath.section];
    [cell setNeedsLayout];
    return cell;
    
    // return nil;
}
-(void)update {
     tableView.contentInset = UIEdgeInsetsMake(0, 0, 100, 0);
    [tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return dataArray.count;
}
-(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (radioImage .count == 0 )
    {
        radioImage =@[@"radio_btn.png",@"radio_btn.png",@"radio_btn.png",@"radio_btn.png"];
    }
    [self assignValueForOrderItem];
    [self buttonColor];
   
}

- (NSComparisonResult)compare:(CategoryListItems *)otherObject {
    return [self.title compare:otherObject.title];
}




- (IBAction)orderAction:(UIButton *)sender {
  // NSInteger *tag =sender.tag ;
    allButtonColor=@[@0,@0,@0,@0];

    if ( sender.tag == 0){
        [self orderAllItems:@"created" BOOL:@YES];
        NSLog(@"order value %@",@"cre");
       // radioImage =@[@"radio_btn_selected.png",@"radio_btn.png",@"radio_btn.png",@"radio_btn.png"];
        allButtonColor=@[@1,@0,@0,@0];


    }
    else if (sender.tag == 1){
        [self orderAllItems:@"discount_perc" BOOL: NO];
        NSLog(@"order value %@",@"dis ");
       // radioImage =@[@"radio_btn.png",@"radio_btn_selected.png",@"radio_btn.png",@"radio_btn.png"];
        allButtonColor=@[@0,@2,@0,@0];


    }
    else if (sender.tag == 2){
        [self orderAllItems:@"expiration_date" BOOL:@YES];
        NSLog(@"order value %@",@"ex");
        //radioImage =@[@"radio_btn.png",@"radio_btn.png",@"radio_btn_selected.png",@"radio_btn.png"];
        allButtonColor=@[@0,@0,@3,@0];


    }
   
    else {
        NSLog(@"order value %@",@"likes");
        radioImage =@[@"radio_btn.png",@"radio_btn.png",@"radio_btn.png",@"radio_btn_selected.png"];
        allButtonColor=@[@0,@0,@0,@4];

        [self orderAllItems:@"likes" BOOL:NO];

    }
}

- (IBAction)showOrderList:(id)sender {
  [self.showListColor setImage:[UIImage imageNamed:@"sorting_selected"] forState:UIControlStateNormal];
  
    [self viewWillAppear:true];
    
    if (dataArray.count != 0){
    self.orderItems.hidden = false;
    }
}
-(void)buttonColor{
    for(int i = 0; i < [allButtonColor count]; i += 1 ){
        int item =[[allButtonColor objectAtIndex: i]intValue];
        NSLog(@"button color %d", item);

        if (item == 1){
           // [self.offer_order_new setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            [self.offer_order_new  setBackgroundColor:[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1]];
            
            
            [self.offer_order_discount  setBackgroundColor:[UIColor whiteColor]];
            [self.offer_order_expire  setBackgroundColor:[UIColor whiteColor]];
            [self.offer_order_likes  setBackgroundColor:[UIColor whiteColor]];

        }
        else if (item== 2){
            //[self.offer_order_discount setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
             [self.offer_order_discount  setBackgroundColor:[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1]];
            [self.offer_order_new  setBackgroundColor:[UIColor whiteColor]];
            [self.offer_order_expire  setBackgroundColor:[UIColor whiteColor]];
            [self.offer_order_likes  setBackgroundColor:[UIColor whiteColor]];
        }
        if (item == 3){
            //[self.offer_order_expire setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.offer_order_expire setBackgroundColor:[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1]];
            [self.offer_order_new  setBackgroundColor:[UIColor whiteColor]];
            [self.offer_order_discount  setBackgroundColor:[UIColor whiteColor]];
            [self.offer_order_likes  setBackgroundColor:[UIColor whiteColor]];
        }
        else if (item == 4){
         //   [self.offer_order_likes setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.offer_order_likes  setBackgroundColor:[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1]];
            [self.offer_order_new  setBackgroundColor:[UIColor whiteColor]];
            [self.offer_order_discount  setBackgroundColor:[UIColor whiteColor]];
            [self.offer_order_expire  setBackgroundColor:[UIColor whiteColor]];

        }
    }
    
}

-(void)orderAllItems:(NSString *)oreder_name BOOL: order_type  {
    [dataArray sortUsingDescriptors:
     [NSMutableArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey: oreder_name ascending: order_type selector:@selector(compare:)]]];
    
    
    
    
    
    self.orderItems.hidden =  true;
    [self.showListColor setImage:[UIImage imageNamed:@"sorting"] forState:UIControlStateNormal];
    
    [tableView reloadData];
}

    
    


-(void)orderAllItems:(NSString *)oreder_type{
    [dataArray sortUsingDescriptors:
     [NSMutableArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey: oreder_type ascending:true selector:@selector(compare:)]]];
    
    self.orderItems.hidden =  true;
    [self.showListColor setImage:[UIImage imageNamed:@"sorting"] forState:UIControlStateNormal];

    [tableView reloadData];
}



-(void)assignValueForOrderItem{
    // UIImageView  * imageRadio;
    [self assignOrderName:self.offer_order_new NSString:itemsNamesAll[0]];
    
     [self assignOrderName:self.offer_order_discount NSString:itemsNamesAll[1]];
    
    [self assignOrderName:self.offer_order_expire NSString:itemsNamesAll[2]];
    
    [self assignOrderName:self.offer_order_likes NSString:itemsNamesAll[3]];
    

}
- (void) assignOrderName :(UIButton*) name NSString:value{
    [name setTitle: value forState:UIControlStateNormal];

}
//-(void)textAlligmentLeft:(UIButton*)button_name{
//    button_name.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
//}
//-(void)textAlligmentRight:(UIButton*)button_name{
//    button_name.contentHorizontalAlignment =UIControlContentHorizontalAlignmentRight;
//}
- (IBAction)backToCategory:(id)sender {
    viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CartegoriesViewController"];
       // viewController.catName=self.cat_URl;
    //  NSLog(@"index row   %ld",indexPath.row);
    
    [viewController setModalPresentationStyle:UIModalPresentationFormSheet];
    [viewController setModalTransitionStyle: UIModalTransitionStyleFlipHorizontal];
    [self.navigationController pushViewController:viewController animated:NO];
}
@end

