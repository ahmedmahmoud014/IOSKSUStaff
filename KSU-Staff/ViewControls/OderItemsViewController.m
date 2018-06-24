//
//  OderItemsViewController.m
//  KSU-Staff
//
//  Created by iOSAccount on 11/13/17.
//  Copyright © 2017 E-Jawdah. All rights reserved.
//

#import "OderItemsViewController.h"
#import "OderItemTableViewCell.h"
#import "CategoryItemesViewController.h"
#import "CategoryListItems.h"


@interface OderItemsViewController ()

@end

@implementation OderItemsViewController

@synthesize titleLbl;
@synthesize tableView;
CategoryItemesViewController * categoryItemesViewController;
NSArray *itemsNames;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // [self customizeNavigationBar:YES WithMenu:YES];
    
//    if(IS_IPAD){
//        int x= (self.view.frame.size.width- tableView.frame.size.width)/2;
//        tableView.frame=CGRectMake(x, tableView.frame.origin.y, tableView.frame.size.width, tableView.frame.size.height);
//    }
  
    dataArray = [[NSMutableArray alloc] init];
    for (NSString *itemName in  itemsNames ){
        OrderItemObj *oderObj =[[OrderItemObj alloc] init];
        [oderObj initWithOderName:itemName orderImageName:@"like"];
        [dataArray addObject:oderObj];
        
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    categoryItemesViewController.checkOrder= @"ahmed";
   [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"order value%@",@" ttttttttttt");
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier=@"orderItemesTableViewCell";
    OderItemTableViewCell *cell = [ tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    OrderItemObj *items= [dataArray objectAtIndex:(int)indexPath.row];
//    cell.orderImage.image =[UIImage imageNamed:items.orderImageName];
//    cell.orderName.text =items.orderImageName;
//

   [cell initWithOrderObj:items withRowId:(int)indexPath.row];
//
    return cell;
  
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"test will appear %@ ",@"test will appper ");
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
@end
