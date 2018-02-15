//
//  TicketCollectionViewCell.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 11/17/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "TicketCollectionViewCell.h"
#import "LocalizedMessages.h"
#import "StaticFuntions.h"
#import "AppDelegate.h"


@implementation TicketCollectionViewCell
@synthesize bgImg,nameLbl,contactYearLbl,ticketTypeLbl;
@synthesize nameTextLbl,contactYearTextLbl,ticketTypeTextLbl;

-(void)initWithTicketObj:(TicketObj *)obj withRowId:(int)rowId{
    tObj=obj;
    int mod= rowId%5;
    switch (mod) {
        case ticketBlue:
            bgImg.image=[UIImage imageNamed:@"blue-t.png"];
            break;
        case ticketPurple:
            bgImg.image=[UIImage imageNamed:@"purple-t.png"];
            break;
        case ticketOrange:
            bgImg.image=[UIImage imageNamed:@"orange-t.png"];
            break;
        case ticketGreen:
            bgImg.image=[UIImage imageNamed:@"green-t.png"];
            break;
        case ticketRed:
            bgImg.image=[UIImage imageNamed:@"red-t.png"];
            break;
        default:
            break;
    }
    
    nameLbl.text=tObj.name;
    contactYearLbl.text=tObj.contactYear;
    ticketTypeLbl.text=tObj.ticketType;
    
    nameTextLbl.text=TicketNameText;
    contactYearTextLbl.text=TicketContYearText;
    ticketTypeTextLbl.text=TicketTypeText;
    
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
    contactYearLbl.textAlignment=align;
    ticketTypeLbl.textAlignment=align;
    
    nameTextLbl.textAlignment=align;
    contactYearTextLbl.textAlignment=align;
    ticketTypeTextLbl.textAlignment=align;
}

@end
