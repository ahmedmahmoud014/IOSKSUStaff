//
//  PassportCollectionViewCell.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 11/16/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PassportObj.h"

@interface PassportCollectionViewCell : UICollectionViewCell{
    UIImageView *bgImg;
    UILabel *nameLbl;
    UILabel *passportNoLbl;
    UILabel *expireDateLbl;
    PassportObj *pObj;
    
    
    UILabel *nameTextLbl;
    UILabel *passportNoTextLbl;
    UILabel *expireDateTextLbl;
}

@property (nonatomic,retain) IBOutlet UIImageView *bgImg;
@property (nonatomic,retain) IBOutlet UILabel *nameLbl;
@property (nonatomic,retain) IBOutlet UILabel *passportNoLbl;
@property (nonatomic,retain) IBOutlet UILabel *expireDateLbl;

@property (nonatomic,retain) IBOutlet UILabel *nameTextLbl;
@property (nonatomic,retain) IBOutlet UILabel *passportNoTextLbl;
@property (nonatomic,retain) IBOutlet UILabel *expireDateTextLbl;

-(void)initWithPassportObj:(PassportObj *)obj withRowId:(int)rowId;
@end
