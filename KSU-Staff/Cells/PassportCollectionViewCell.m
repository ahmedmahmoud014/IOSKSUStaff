//
//  PassportCollectionViewCell.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 11/16/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "PassportCollectionViewCell.h"
#import "LocalizedMessages.h"
#import "StaticFuntions.h"
#import "AppDelegate.h"

@implementation PassportCollectionViewCell
@synthesize bgImg,nameLbl,passportNoLbl,expireDateLbl;
@synthesize nameTextLbl,passportNoTextLbl,expireDateTextLbl;

-(void)initWithPassportObj:(PassportObj *)obj withRowId:(int)rowId{
    pObj=obj;
    int mod= rowId%5;
    switch (mod) {
        case passportBlue:
            bgImg.image=[UIImage imageNamed:@"blue.png"];
            break;
        case passportPurple:
            bgImg.image=[UIImage imageNamed:@"purple.png"];
            break;
        case passportOrange:
            bgImg.image=[UIImage imageNamed:@"orange.png"];
            break;
        case passportGreen:
            bgImg.image=[UIImage imageNamed:@"green.png"];
            break;
        case passportRed:
            bgImg.image=[UIImage imageNamed:@"red.png"];
            break;
        default:
            break;
    }
    
    nameLbl.text=pObj.name;
    passportNoLbl.text=pObj.passportNo;
    expireDateLbl.text=pObj.expireDate;
    BOOL passed= [StaticFuntions checkDatePassToday:pObj.expireDate];
    if(passed){
        expireDateLbl.textColor=[StaticFuntions getNegativeValueColor];
    }
    
    nameTextLbl.text=PassportNameText;
    passportNoTextLbl.text=PassportNoText;
    expireDateTextLbl.text=PassportExDateText;
    
    [self changeAlignment];
    
}

-(void)changeAlignment{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSTextAlignment align;
    if(appDelegate.currentLang==English){
        align=NSTextAlignmentLeft;
    }else{
        align=NSTextAlignmentRight;
    }
    
    nameLbl.textAlignment=align;
    passportNoLbl.textAlignment=align;
    expireDateLbl.textAlignment=align;
    
    nameTextLbl.textAlignment=align;
    passportNoTextLbl.textAlignment=align;
    expireDateTextLbl.textAlignment=align;
}
@end
