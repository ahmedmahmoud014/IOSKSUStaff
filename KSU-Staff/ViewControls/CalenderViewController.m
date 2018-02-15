//
//  CalenderViewController.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 11/13/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "CalenderViewController.h"
#import "LocalizedMessages.h"
#import "CalendarTableViewCell.h"
#import "CalendarObj.h"
#import "AppDelegate.h"

@interface CalenderViewController ()

@end

@implementation CalenderViewController

@synthesize tableView;
@synthesize titleLbl;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customizeNavigationBar:YES WithMenu:YES];
    if(IS_IPAD){
        int x= (self.view.frame.size.width- tableView.frame.size.width)/2;
        tableView.frame=CGRectMake(x, tableView.frame.origin.y, tableView.frame.size.width, tableView.frame.size.height);
        noDataLbl.frame=CGRectMake(x, noDataLbl.frame.origin.y, noDataLbl.frame.size.width, noDataLbl.frame.size.height);
    }


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - base methods

-(void)initalizeViews{
    self.BGImage.image= [UIImage imageNamed:@"bg.png"];
    /*AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
     if(appDelegate.currentLang==Arabic){
     
     }*/
    /// testing
    //[self damyData];
    //live
    
    [self getData];
}

-(void)locatizeLables{
    if(isVacationView)
        titleLbl.text=VacationTitleText;
    else
        titleLbl.text=CalenderTitleText;
    
}

-(void)switchToLeftLayout{
    
    titleLbl.textAlignment=NSTextAlignmentLeft;
}

-(void)switchToRightLayout{
    
    titleLbl.textAlignment=NSTextAlignmentRight;
    
}

#pragma mark - table delegate

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier=@"CalendarTableViewCell";
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.currentLang==English)
        CellIdentifier=@"CalendarTableViewCell_en";
    else
        CellIdentifier=@"CalendarTableViewCell";
    
    CalendarTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[CalendarTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    CalendarObj *cObj=[calenderArr objectAtIndex:(int)indexPath.row];
    [cell initWithCalendarObj:cObj withRowIndex:(int)indexPath.row];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [calenderArr count];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

#pragma mark - methods
-(void)damyData{
    calenderArr=[[NSMutableArray alloc] init];
    CalendarObj *calender0=[[CalendarObj alloc] init];
     AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.currentLang==Arabic){
        calender0.event=@"العيد القومي";
    }else
        calender0.event=@"National day Holiday";
    calender0.hijriDate=@"28/11/1435 - 23/4/2014";
    calender0.georgDate=@"30/11/1435 - 25/4/2014";
    [calenderArr addObject:calender0];
    [calenderArr addObject:calender0];
    [calenderArr addObject:calender0];
    [calenderArr addObject:calender0];
    [calenderArr addObject:calender0];
    
}

-(void)getData{
    calenderArr=[CalendarObj getCalendarData:isVacationView];
    [tableView reloadData];
}

-(void)changeToVacationCalender{
    isVacationView=YES;
    [self getData];
    [self locatizeLables];
}
@end
