//
//  Contact.h
//  KSU-Staff
//
//  Created by iOSAccount on 11/8/17.
//  Copyright © 2017 E-Jawdah. All rights reserved.
//

#ifndef Contact_h
#define Contact_h


#endif /* Contact_h */



//"phone":"",
//"mobile":"",
//"email":"enquiries@nozomisaudi.com",
//"website":"http://www.nozomisaudi.com/",
//"location":"https://www.google.com.sa/maps/place/Nozomi+Riyadh/@24.7001384,46.7047755,15z/data=!4m5!3m4!1s0x0:0x74edaa5821a6451!8m2!3d24.7001384!4d46.7047755"


@interface Contact : NSObject{
    NSString *phone;
    NSString *mobile;
    NSString *email;
    NSString *website;
    NSString *location;

    
}

@property(nonatomic,retain) NSString *phone;
@property(nonatomic,retain) NSString *mobile;
@property(nonatomic,retain) NSString *email;
@property(nonatomic,retain) NSString *website;
@property(nonatomic,retain) NSString *location;

-(void)initWithContact:(NSString*)phone mobile:(NSString*)mobile email:(NSString*)email website:(NSString*)website location:(NSString*)location;

@end
