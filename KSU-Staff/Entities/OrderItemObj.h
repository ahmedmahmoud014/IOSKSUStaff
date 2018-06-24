//
//  OrderItemObj.h
//  KSU-Staff
//
//  Created by iOSAccount on 11/13/17.
//  Copyright © 2017 E-Jawdah. All rights reserved.
//

#ifndef OrderItemObj_h
#define OrderItemObj_h


#endif /* OrderItemObj_h */

@interface OrderItemObj : NSObject{
    NSString *orderName;
    NSString *orderImageName;
    
    
}

@property(nonatomic,retain) NSString *orderName;
@property(nonatomic,retain) NSString *orderImageName;

-(void)initWithOderName:(NSString*)orderName orderImageName:(NSString*) orderImageName ;
@end
