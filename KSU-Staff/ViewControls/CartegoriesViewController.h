//
//  Cartegories.h
//  KSU-Staff
//
//  Created by iOSAccount on 11/2/17.
//  Copyright © 2017 E-Jawdah. All rights reserved.
//

#ifndef Cartegories_h
#define Cartegories_h


#endif /* Cartegories_h */

#import "BaseViewController.h"
#import "DataTransfer.h"

@interface CartegoriesViewController : BaseViewController <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,DataTransferDelegate>
{
    UICollectionView *collectionView;
    NSMutableArray *dataArray;

}




@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;
//
@property (weak, nonatomic) IBOutlet UILabel *noData;

@property (weak, nonatomic) IBOutlet UILabel *showServiceName;

@property (weak, nonatomic) IBOutlet UIButton *menuBtn;
@property (weak, nonatomic) IBOutlet UIButton *homeBtn;
- (IBAction)btnHomeOrMenuPress:(UIButton *)sender;

//-(void) showMenu;
//-(void) backHome;

@end
