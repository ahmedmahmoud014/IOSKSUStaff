//
//  TasksViewController.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 11/16/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "TasksViewController.h"
#import "AppDelegate.h"
#import "LocalizedMessages.h"
#import "TasksTableViewCell.h"
#import "StaticFuntions.h"

@interface TasksViewController ()

@end

@implementation TasksViewController
@synthesize tableView,titleLbl;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [self customizeNavigationBar:YES WithMenu:YES];
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
    [self damyData];
    [self expandTableSections];
    
}

-(void)locatizeLables{
    titleLbl.text=TaskTitleText;
}

-(void)switchToLeftLayout{
    
    titleLbl.textAlignment=NSTextAlignmentLeft;
}

-(void)switchToRightLayout{
    
    titleLbl.textAlignment=NSTextAlignmentRight;
    
}

#pragma mark - table delegate

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier=@"TasksTableViewCell";
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.currentLang==English)
        CellIdentifier=@"TasksTableViewCell_en";
    else
        CellIdentifier=@"TasksTableViewCell";
    
    TasksTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[TasksTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    TaskObj *obj=[tasksArr objectAtIndex:(int)indexPath.section];
    [cell initWithTaskObj:obj withRowId:(int)indexPath.row];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[sectionRowsCount objectAtIndex:(int)section] intValue];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [tasksArr count];
}

-(UIView*)tableView:(UITableView *)tableView_ viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
    int btn_x=0,title_x=0;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    // NSTextAlignment align;
    if(appDelegate.currentLang==English){
        btn_x=280;
        title_x=5;
        //align=NSTextAlignmentLeft;
    }else{
        btn_x=0;
        title_x=40;
        //align=NSTextAlignmentRight;
    }
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(title_x, 5, 275, 30)];
    label.textColor=[UIColor whiteColor];
    
    UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(btn_x, 0, 40, 40)];
    [btn addTarget:self action:@selector(sectionButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag=section;
    NSString *string =@"";
    UIImage *image=nil;
    
    TaskObj *obj= [tasksArr  objectAtIndex:section];
    string=obj.task;
    if([[sectionRowsCount objectAtIndex:section] intValue]==0)
        image=[UIImage imageNamed:@"arrow_down.png"];
    else
        image=[UIImage imageNamed:@"arrow_up.png"];
    
    label.textAlignment=NSTextAlignmentCenter;
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [label setText:string];
    [view addSubview:btn];
    [view addSubview:label];
    [view setBackgroundColor:[StaticFuntions getTableSectionBGColor]];
    return view;
    // return nil;
}
/*
 -(NSArray*) indexPathsForSection:(int)section withNumberOfRows:(int)numberOfRows {
 NSMutableArray* indexPaths = [NSMutableArray new];
 for (int i = 0; i < numberOfRows; i++) {
 NSIndexPath* indexPath = [NSIndexPath indexPathForRow:i inSection:section];
 [indexPaths addObject:indexPath];
 }
 return indexPaths;
 }*/

-(void)sectionButtonTouchUpInside:(UIButton*)sender {
    //[self.tableView beginUpdates];
    int section = (int)sender.tag;
    if([[sectionRowsCount objectAtIndex:(int)section] intValue]==0){
        int numOfRows = NumberTaskDetailsItems;
        // NSArray* indexPaths = [self indexPathsForSection:section withNumberOfRows:numOfRows];
        //  [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
        [sectionRowsCount replaceObjectAtIndex:section withObject:[NSNumber numberWithInt:numOfRows]];
    }else{
        // int numOfRows = [self.tableView numberOfRowsInSection:section];
        // NSArray* indexPaths = [self indexPathsForSection:section withNumberOfRows:numOfRows];
        // [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
        [sectionRowsCount replaceObjectAtIndex:section withObject:[NSNumber numberWithInt:0]];
    }
    //  [self.tableView endUpdates];
    [self.tableView reloadData];
}


-(UIView*)tableView:(UITableView *)tableView_ viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 3)];
    [view setBackgroundColor:[UIColor clearColor]];
    return view;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}
#pragma mark - methods

-(void)expandTableSections{
    if(sectionRowsCount==nil)
        sectionRowsCount=[[NSMutableArray alloc] init];
    else{
        [sectionRowsCount removeAllObjects];
    }
    for(int i=0;i< [tasksArr count];i++){
        [sectionRowsCount addObject:[NSNumber numberWithInt:NumberTaskDetailsItems]];
    }
}

-(void)damyData{
    tasksArr= [[NSMutableArray alloc] init];
    TaskObj *task=[[TaskObj alloc] init];
    task.task=@"تسليم الاوراق";
    task.department=@"المالية";
    task.date=@"11/4/1435";
    task.remarks=@"تسلم بمعرفة المدير";
    task.status=@"قيد التنفيذ";
    [tasksArr addObject:task];
    [tasksArr addObject:task];
    [tasksArr addObject:task];
    [tasksArr addObject:task];
    [tasksArr addObject:task];
    [tasksArr addObject:task];
}
@end
