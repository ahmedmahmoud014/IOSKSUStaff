//
//  TicketCollectionViewCell.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 11/17/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TicketObj.h"

@interface TicketCollectionViewCell : UICollectionViewCell{
    UIImageView *bgImg;
    UILabel *nameLbl;
    UILabel *contactYearLbl;
    UILabel *ticketTypeLbl;
    TicketObj *tObj;
    
    
    UILabel *nameTextLbl;
    UILabel *contactYearTextLbl;
    UILabel *ticketTypeTextLbl;
}

@property (nonatomic,retain) IBOutlet UIImageView *bgImg;
@property (nonatomic,retain) IBOutlet UILabel *nameLbl;
@property (nonatomic,retain) IBOutlet UILabel *contactYearLbl;
@property (nonatomic,retain) IBOutlet UILabel *ticketTypeLbl;

@property (nonatomic,retain) IBOutlet UILabel *nameTextLbl;
@property (nonatomic,retain) IBOutlet UILabel *contactYearTextLbl;
@property (nonatomic,retain) IBOutlet UILabel *ticketTypeTextLbl;

-(void)initWithTicketObj:(TicketObj *)obj withRowId:(int)rowId;



@end
