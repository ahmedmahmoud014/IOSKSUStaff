//
//  DataTransfer.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 12/10/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomError.h"
#import "StaticVariables.h"

@protocol DataTransferDelegate <NSObject>
@required
- (void) processCompleted:(id)data error:(CustomError *)error withService:(NSNumber *)service;
@end
// Protocol Definition ends here

@interface DataTransfer : NSObject

{
    id <DataTransferDelegate> _delegate;
    
}
@property (nonatomic,strong) id delegate;

- (void)dataLoaded:(id)data error:(CustomError *)error withService:(Service) service;

@end
