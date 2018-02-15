//
//  DataTransfer.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 12/10/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "DataTransfer.h"

@implementation DataTransfer

- (void)dataLoaded:(id)data error:(CustomError *)error withService:(Service)service{
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    //    objc_msgSend(self.delegate, @selector(processCompleted:error:withService:), data, error, [NSNumber numberWithInt:service]);
    
    //   [self.delegate performSelector:@selector(processCompleted:error:withService:) withObject:data    withObject:error withObject:[NSNumber numberWithInt:service]];
    [self.delegate processCompleted:data error:error withService:[NSNumber numberWithInt:service]];
}


@end
