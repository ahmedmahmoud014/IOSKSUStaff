//
//  TicketViewController.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 11/17/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "TicketViewController.h"
#import "LocalizedMessages.h"
#import "TicketObj.h"
#import "TicketCollectionViewCell.h"

@interface TicketViewController ()

@end

@implementation TicketViewController

@synthesize titleLbl,collectionView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customizeNavigationBar:YES WithMenu:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - base methods

-(void)initalizeViews{
    self.BGImage.image= [UIImage imageNamed:@"bg.png"];
    /*AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
     if(appDelegate.currentLang==Arabic){
     
     }*/
    [self damyData];
    
    
}

-(void)locatizeLables{
    titleLbl.text=TicketTitleText;
}

-(void)switchToLeftLayout{
    
    titleLbl.textAlignment=NSTextAlignmentLeft;
}

-(void)switchToRightLayout{
    
    titleLbl.textAlignment=NSTextAlignmentRight;
    
}

#pragma mark - collectionview delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [dataArray count];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSMutableArray *sectionArray = [dataArray objectAtIndex:section];
    return [sectionArray count];
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView_ cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // Setup cell identifier
    static NSString *cellIdentifier = @"TicketCollectionViewCell";
    
    TicketCollectionViewCell *cell = (TicketCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSMutableArray *data = [dataArray objectAtIndex:(int)indexPath.section];
    TicketObj *ticket = (TicketObj*)[data objectAtIndex:(int)indexPath.row];
    [cell initWithTicketObj:ticket withRowId:(int)indexPath.row];
    
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
}

#pragma mark - methods


-(void)damyData{
    ticketsArr= [[NSMutableArray alloc] init];
    TicketObj *ticket=[[TicketObj alloc] init];
    ticket.name=@"أحمد محمد ابراهيم عبد الرحمن";
    ticket.ticketType=@"ذهاب و عودة";
    ticket.contactYear=@"1436";
    [ticketsArr addObject:ticket];
    [ticketsArr addObject:ticket];
    [ticketsArr addObject:ticket];
    [ticketsArr addObject:ticket];
    [ticketsArr addObject:ticket];
    [ticketsArr addObject:ticket];
    
    dataArray=[[NSArray alloc] initWithObjects:ticketsArr, nil];
}

@end
