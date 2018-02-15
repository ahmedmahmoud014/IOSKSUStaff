//
//  BookViewController.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 4/15/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "BookViewController.h"
#import "BookObj.h"
#import "LocalizedMessages.h"
#import "BookCollectionViewCell.h"
#import "AppDelegate.h"
#import "RequestManager.h"
#import "StaticFuntions.h"
#import "StaticVariables.h"

@interface BookViewController ()

@end

@implementation BookViewController

@synthesize titleLbl,collectionView;
@synthesize noDataImg;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customizeNavigationBar:YES WithMenu:YES];
    /*if ([[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)]){
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            int x= (self.view.frame.size.width- collectionView.frame.size.width)/2;
            collectionView.frame=CGRectMake(x, collectionView.frame.origin.y, collectionView.frame.size.width, collectionView.frame.size.height);
            noDataLbl.frame=CGRectMake(x, noDataLbl.frame.origin.y, noDataLbl.frame.size.width, noDataLbl.frame.size.height);
        }
    }
    if([[UIDevice currentDevice] userInterfaceIdiom]== UIUserInterfaceIdiomPhone){
         NSLog(@"3");
    }*/
    if(IS_IPAD){
         //NSLog(@"4");
        int x= (self.view.frame.size.width- collectionView.frame.size.width)/2;
        collectionView.frame=CGRectMake(x, collectionView.frame.origin.y, collectionView.frame.size.width, collectionView.frame.size.height);
        noDataLbl.frame=CGRectMake(x, noDataLbl.frame.origin.y, noDataLbl.frame.size.width, noDataLbl.frame.size.height);
        noDataImg.frame=CGRectMake(x+110, noDataImg.frame.origin.y, noDataImg.frame.size.width, noDataImg.frame.size.height);
    }
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
   // [self damyData];
    if([self isNetworkAvailable] ==YES)
    {
        NSLog(@"Network Connection available");
            [self connect];    }
    
    else{
        [StaticFuntions showAlertWithTitle:NetWorkTitle Message:NetWorkBody];
        
    }
    //self.collectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"shelves.png"]];

}

-(void)locatizeLables{
    titleLbl.text=bookScreenTitle;
    noDataLbl.text=bookBorrowedNoDataMSG;
}

-(void)switchToLeftLayout{
    
    titleLbl.textAlignment=NSTextAlignmentLeft;
}

-(void)switchToRightLayout{
    
    titleLbl.textAlignment=NSTextAlignmentRight;
    
}

#pragma mark - collectionview delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if([dataArray count]==0){
        noDataLbl.hidden=NO;
        noDataImg.hidden=NO;
        return 0;
    }
    noDataLbl.hidden=YES;
    noDataImg.hidden=YES;
    return [dataArray count];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSMutableArray *sectionArray = [dataArray objectAtIndex:section];
    return [sectionArray count];
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView_ cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // Setup cell identifier
    static NSString *cellIdentifier = @"BookCollectionViewCell";
    
    BookCollectionViewCell *cell = (BookCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSMutableArray *data = [dataArray objectAtIndex:(int)indexPath.section];
    BookObj *book = (BookObj*)[data objectAtIndex:(int)indexPath.row];
    [cell initWithBookObj:book withRowId:(int)indexPath.row];
    
    return cell;
    
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
}

#pragma mark - methods


-(void)damyData{
    booksArr= [[NSMutableArray alloc] init];
    BookObj *book=[[BookObj alloc] init];
    book.bookName=@"أحمد محمد ابراهيم عبد الرحمن";
    book.borrowedDate=@"11/2/1436";

    [booksArr addObject:book];
    [booksArr addObject:book];
    [booksArr addObject:book];
    [booksArr addObject:book];
    [booksArr addObject:book];
    [booksArr addObject:book];
    [booksArr addObject:book];
    [booksArr addObject:book];
    [booksArr addObject:book];
    [booksArr addObject:book];
    
    dataArray=[[NSArray alloc] initWithObjects:booksArr, nil];
}


-(void)connect{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[RequestManager sharedInstance] getBookBorrowed:self forEmpNo:appDelegate.EmployeeObj.empNo];
    [self showActivityViewer];
}


#pragma mark - connection

- (void)processCompleted:(id)data error:(CustomError *)error withService:(NSNumber *)service{
    [self hideActivityViewer];
    if(data!=nil){
        booksArr=(NSMutableArray*)data;
        if(booksArr!=nil&& [booksArr count]!=0)
            dataArray=[[NSArray alloc] initWithObjects:booksArr, nil];
    }else{
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:error.errorMessage];
    }
    [collectionView reloadData];
}


@end
