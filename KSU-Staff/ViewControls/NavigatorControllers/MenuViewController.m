//
//  MenuViewController.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 9/17/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "MenuViewController.h"
#import "DocInfoViewController.h"
#import "AppDelegate.h"
#import "MenuCellObj.h"
#import "MenuCell.h"
#import "LocalizedMessages.h"
#import "CustomNavigationController.h"
#import "BaseViewController.h"
#import "RequestManager.h"
#import "ExternalDocumentUnitObj.h"
#import "StaticFuntions.h"
#import "DataTransfer.h"

@interface MenuViewController ()

@end

@implementation MenuViewController
@synthesize menuTitleLbl,imageView;

- (id)initWithCoder:(NSCoder *)aDecoder     {
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        //  [notificationsSwitch addTarget:self action:@selector(switchChangesState:) forControlEvents:UIControlEventValueChanged];
    }
    return self;
}



//-(void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

#pragma mark - table delegate

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    static NSString *CellIdentifier=@"MenuCell";
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.currentLang==English)
        CellIdentifier=@"MenuCell_en";
    else
        CellIdentifier=@"MenuCell";
    
    MenuCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[MenuCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    [cell initWithMenu:[MenuCellObj getMenuForindex:(int)indexPath.row]];
    
    return cell;
    //return nil;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return NumberMenuItems;
}
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    NSString * seagueName =[MenuCellObj getSeagueName:(int)indexPath.row];
    
    if([seagueName isEqualToString:@""]){
        
    }
    else if ([seagueName isEqualToString:SeagueDocInfoScreen])
    {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        CustomNavigationController *navigationController = (CustomNavigationController *)appDelegate.centerController;
        
        [((BaseViewController*)[navigationController getTopView]) hideMenuViewer];
        
        if([self isNetworkAvailable] ==YES)
        {
            UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:seagueName];
            if([[navigationController getTopView] class]!=[viewController class])
            {
                [((BaseViewController*)[navigationController getTopView]) showActivityViewer];
                
                [[RequestManager sharedInstance] GetExternalDocumentUnit:self];
            }
        }
        
        else{
            [StaticFuntions showAlertWithTitle:NetWorkTitle Message:NetWorkBody];
            
        }
        
        
        
        
    }
    else {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        CustomNavigationController *navigationController = (CustomNavigationController *)appDelegate.centerController;
        
        //[((BaseViewController*)[navigationController getTopView]) hideMenuViewer];
        
        UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:seagueName];
        
        if([[navigationController getTopView] class]!=[viewController class]){
            [navigationController pushViewController:viewController animated:NO];
        }
        
        //[navigationController.viewDeckController toggleLeftViewAnimated:YES];
        [((BaseViewController*)[navigationController getTopView]) onMenuButtonPressed:nil];
    }
    
}



- (BOOL)isNetworkAvailable
{
    CFNetDiagnosticRef dReference;
    dReference = CFNetDiagnosticCreateWithURL (NULL, (__bridge CFURLRef)[NSURL URLWithString:@"www.apple.com"]);
    
    CFNetDiagnosticStatus status;
    status = CFNetDiagnosticCopyNetworkStatusPassively (dReference, NULL);
    
    CFRelease (dReference);
    
    if ( status == kCFNetDiagnosticConnectionUp )
    {
        NSLog (@"Connection is Available");
        return YES;
    }
    else
    {
        NSLog (@"Connection is down");
        return NO;
    }
}
#pragma mark - connection

- (void)processCompleted:(id)data error:(CustomError *)error withService:(NSNumber *)service{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    CustomNavigationController *navigationController = (CustomNavigationController *)appDelegate.centerController;
    [((BaseViewController*)[navigationController getTopView]) hideActivityViewer];
    if(data!=nil){
        
        if([service intValue]==(int)GetExternalDocumentUnit_WS){
            NSMutableArray *obj=(NSMutableArray*)data;

            DocInfoViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:SeagueDocInfoScreen];
            
            viewController.parentName = @"Sidemenu";
            viewController.ListOfexternalDoctblView = obj;
            
            if([[navigationController getTopView] class]!=[viewController class]){
                [navigationController pushViewController:viewController animated:NO];
            }
        }
    }else{
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:error.errorMessage];
        return;
    }
    
}

#pragma mark - view

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:true animated:animated];

    [super viewWillAppear:animated];
    [self changeLocalization];

}
-(void) viewDidLoad{
    [super viewDidLoad];
}


- (void)setPanning:(BOOL)allow  {
    self.viewDeckController.panningMode = allow ? IIViewDeckFullViewPanning : IIViewDeckNoPanning ;
}

#pragma mark - methods

-(void)changeLocalization{
    menuTitleLbl.text=MenuTitleText;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.currentLang==Arabic){
        CGRect frame=menuTitleLbl.frame;
        if(IS_IPAD){
            frame.origin.x=MenuStartXIPad;

        }else
            frame.origin.x=MenuStartX;
        menuTitleLbl.frame=frame;
        
        frame=imageView.frame;
        if(IS_IPAD)
            frame.origin.x=MenuStartXIPad;
        else
            frame.origin.x=MenuStartX;
        imageView.frame=frame;
    }else{
        CGRect frame=menuTitleLbl.frame;
        frame.origin.x=0;
        menuTitleLbl.frame=frame;
        
        frame=imageView.frame;
        frame.origin.x=0;
        imageView.frame=frame;
    }
    [self.tableView reloadData];
}
@end
