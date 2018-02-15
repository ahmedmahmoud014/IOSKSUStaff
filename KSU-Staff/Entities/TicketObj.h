//
//  TicketObj.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 11/17/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum ticketColor{
    ticketBlue=0,
    ticketPurple,
    ticketOrange,
    ticketGreen,
    ticketRed
    
}TicketColor;
@interface TicketObj : NSObject{
    NSString *name;
    NSString *contactYear;
    NSString *ticketType;
}

@property (nonatomic,retain) NSString *name;
@property (nonatomic,retain) NSString *contactYear;
@property (nonatomic,retain) NSString *ticketType;

@end
