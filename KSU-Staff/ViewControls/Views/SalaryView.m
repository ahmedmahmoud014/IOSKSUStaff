//
//  SalaryView.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 1/11/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "SalaryView.h"

@implementation SalaryView
@synthesize tableView;
@synthesize monthLbl;
@synthesize yearLbl;

@synthesize dateView;
@synthesize bgForDate;

@synthesize totalDeserveValLbl;
@synthesize totalDiscountValLbl;
@synthesize totalNetValLbl;

@synthesize totalDeserveLbl;
@synthesize totalDiscountLbl;
@synthesize totalNetLbl;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - methods

-(void)initControls{
    
}

-(void)locatizeLables{
    
}

-(void)switchToLeftLayout{
}

-(void)switchToRightLayout{
    
}

#pragma mark - events

-(IBAction)onLeftPressed:(id)sender{
    
}

-(IBAction)onRightPressed:(id)sender{
    
}
#pragma mark - table delegate

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return 0;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}


@end
