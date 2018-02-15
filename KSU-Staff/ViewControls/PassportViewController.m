//
//  PassportViewController.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 11/16/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "PassportViewController.h"
#import "LocalizedMessages.h"
#import "PassportCollectionViewCell.h"

@interface PassportViewController ()

@end

@implementation PassportViewController
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
    titleLbl.text=PassportTitleText;
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
    static NSString *cellIdentifier = @"PassportCollectionViewCell";
    
    PassportCollectionViewCell *cell = (PassportCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSMutableArray *data = [dataArray objectAtIndex:indexPath.section];
    PassportObj *pass = (PassportObj*)[data objectAtIndex:indexPath.row];
    [cell initWithPassportObj:pass withRowId:(int)indexPath.row];
    
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
}

#pragma mark - methods


-(void)damyData{
    passortsArr= [[NSMutableArray alloc] init];
    PassportObj *pass=[[PassportObj alloc] init];
    pass.name=@"أحمد محمد ابراهيم عبد الرحمن";
    pass.passportNo=@"1234567";
    pass.expireDate=@"11/4/1435";
    [passortsArr addObject:pass];
    [passortsArr addObject:pass];
    [passortsArr addObject:pass];
    [passortsArr addObject:pass];
    [passortsArr addObject:pass];
    [passortsArr addObject:pass];
    
    dataArray=[[NSArray alloc] initWithObjects:passortsArr, nil];
}
@end
