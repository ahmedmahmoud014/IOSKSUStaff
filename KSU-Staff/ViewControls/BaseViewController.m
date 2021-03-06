//
//  BaseViewController.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 9/17/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"
#import "CustomNavigationController.h"
#import "StaticVariables.h"
#import "LoginViewController.h"
#import "DashBoardViewController.h"
#import "StaticFuntions.h"
#import "Reachability.h"




@interface BaseViewController ()

@end

@implementation BaseViewController
@synthesize BGImage;
@synthesize noDataLbl;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - view events
- (void)viewDidLoad{
    [super viewDidLoad];
    BGImage.image=[UIImage imageNamed:@"bg.png"];
    self.view.backgroundColor=[ UIColor colorWithRed:248.0/255.0 green:248.0/255.0 blue:248.0/255.0 alpha:1];
    [self initalizeViews];
    
}


- (void)moveToNext:(UIViewController *)vcName{
    [self.navigationController pushViewController:vcName animated:NO];

}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];

    [self switchLayout];
    [self locatizeLables];
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(delegate.pased)
        [self refreshView];
    
    
    
}

- (void)customizeNavigationBar:(BOOL)withHome WithMenu:(BOOL)withMenu   {

    if ([self.navigationController respondsToSelector:@selector(setPanning:)]) {
        CustomNavigationController * navigation = (CustomNavigationController *)self.navigationController;
        [navigation setPanning:withMenu];
    }
    
//    self.navigationController.navigationBar.hidden = NO;
    
    self.navigationController.navigationBar.translucent = NO;
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeTop;
    
    self.navigationItem.hidesBackButton = YES;
    UINavigationBar *navBar = [[self navigationController] navigationBar];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UIImage *backgroundImage;
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
       // backgroundImage = [UIImage imageNamed:@"header_20.png"];
      backgroundImage=  [ [UIImage imageNamed:@"header_20.png"] resizableImageWithCapInsets:UIEdgeInsetsZero
    resizingMode:UIImageResizingModeStretch];
        
//        CGSize destinationSize = CGSizeMake(backgroundImage.size.width, backgroundImage.size.height);
//        UIGraphicsBeginImageContext(destinationSize);
//         [backgroundImage drawInRect:CGRectMake(0,0,destinationSize.width,destinationSize.height-8)];
//        backgroundImage = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
        
        [[UIBarButtonItem appearance] setTintColor:[BaseViewController getBackBtnColor]];
       
        
    }else {
        backgroundImage = [UIImage imageNamed:@"header_20"];
        [[UIBarButtonItem appearance] setTintColor:[UIColor whiteColor]];
        [[[self navigationController] navigationBar] setTintColor:[UIColor whiteColor]];
    }
    
    if (withMenu) {
        
        printf("ttttttttttttmenu",  self.view.frame.size.width - 46);
        UIButton *menubarButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 46, BUTTONS_Y, BUTTONS_SIZE, BUTTONS_SIZE)];
//        UIButton *menubarButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 46, 15, 36, 36)];
        [menubarButton setImage:[UIImage imageNamed:@"menu_btn"] forState:UIControlStateNormal];
        [menubarButton setImage:[UIImage imageNamed:@"menu_btn_pressed"] forState:UIControlStateHighlighted];
        UIBarButtonItem* barButton = [[UIBarButtonItem alloc]
                                      initWithCustomView:menubarButton];
        //if(SYSTEM_VERSION_LESS_THAN(@"9.0")&&(!IS_IPAD)){
            if(appDelegate.currentLang==Arabic)
                self.navigationItem.rightBarButtonItem = barButton;
            else
                self.navigationItem.leftBarButtonItem = barButton;

        /*}else{
            if(appDelegate.currentLang!=Arabic)
                self.navigationItem.rightBarButtonItem = barButton;
            else
                self.navigationItem.leftBarButtonItem = barButton;
        }*/
        
        
        [menubarButton addTarget:self action:@selector(onMenuButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    if (withHome) {
        UIButton *homebarButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 80, BUTTONS_Y, BUTTONS_SIZE, BUTTONS_SIZE)];
        printf("tttttttttttthhhh",  self.view.frame.size.width - 80);

//        UIButton *homebarButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 80, 15, 36, 36)];
        [homebarButton setImage:[UIImage imageNamed:@"home_btn"] forState:UIControlStateNormal];
       // [homebarButton setImage:[UIImage imageNamed:@"home_btn_pressed"] forState:UIControlStateHighlighted];
        UIBarButtonItem* barButtonHome = [[UIBarButtonItem alloc]
                                          initWithCustomView:homebarButton];
        //if(SYSTEM_VERSION_LESS_THAN(@"9.0")&&(!IS_IPAD)){
            if(appDelegate.currentLang==Arabic)
                self.navigationItem.leftBarButtonItem = barButtonHome;
            else
                self.navigationItem.rightBarButtonItem = barButtonHome;
        /*}else{
            if(appDelegate.currentLang!=Arabic)
                self.navigationItem.leftBarButtonItem = barButtonHome;
            else
                self.navigationItem.rightBarButtonItem = barButtonHome;
        }*/
        [homebarButton addTarget:self action:@selector(onHomePressed:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    self.navigationItem.hidesBackButton = YES;

    [navBar setBackgroundImage:backgroundImage forBarPosition:UIBarPositionTop barMetrics:UIBarMetricsDefault];
    navBar.barTintColor=[UIColor colorWithRed:248.0/255.0 green:248.0/255.0 blue:248.0/255.0 alpha:1];
    navBar.shadowImage = [[UIImage alloc] init];


    
}


- (BOOL)isNetworkAvailable

{
    Reachability  *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];

    NetworkStatus status = [reachability currentReachabilityStatus];

    if(status == NotReachable)
    {
        //No internet
        
        return NO;
    }
    else  
    {
        //WiFi
        return YES;
    }
   
    
}
    
//    CFNetDiagnosticRef dReference;
//    dReference = CFNetDiagnosticCreateWithURL (NULL, (__bridge CFURLRef)[NSURL URLWithString:@"www.apple.com"]);
//
//    CFNetDiagnosticStatus status;
//    status = CFNetDiagnosticCopyNetworkStatusPassively (dReference, NULL);
//
//    CFRelease (dReference);
//
//    if ( status == kCFNetDiagnosticConnectionUp )
//    {
//        NSLog (@"Connection is Available");
//        return YES;
//    }
//    else
//    {
//        NSLog (@"Connection is down");
//        return NO;
//    }
//}

- (IBAction)goBack:(id)sender   {
    [self.navigationController popViewControllerAnimated:NO];
}

-(IBAction)onHomePressed:(id)sender
{
    
    
    AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    ProfileObj * obj= [StaticFuntions getSavedData];
    
    if (!appdelegate.islogOut) {
        
        if (obj==nil || obj.userName == nil || [StaticFuntions isStringEmpty:obj.userName]) {
            // Check if User is stored or not
            LoginViewController *dash = [self.storyboard instantiateViewControllerWithIdentifier:SeagueLoginScreen];
            if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
                [self.navigationController pushViewController:dash animated:NO];
            } else {
                for (UIViewController *viewController in self.navigationController.viewControllers) {
                    if ([viewController class] == [LoginViewController class]) {
                        [self.navigationController popToViewController:viewController animated:NO];
                        break;
                    }
                }
            }
        } else {
            // Logged In
            DashBoardViewController *dash=[self.storyboard instantiateViewControllerWithIdentifier:SeagueDashBoardScreen];
            if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")){
                [self.navigationController pushViewController:dash animated:NO];
            }else{
                for (UIViewController *viewController in self.navigationController.viewControllers) {
                    if ([viewController class] == [DashBoardViewController class]) {
                        [self.navigationController popToViewController:viewController animated:NO];
                        break;
                        
                    }
                }
            }
        }
    }
    else
    {
        LoginViewController *dash=[self.storyboard instantiateViewControllerWithIdentifier:SeagueLoginScreen];
        if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")){
            [self.navigationController pushViewController:dash animated:NO];
        }else{
            for (UIViewController *viewController in self.navigationController.viewControllers) {
                if ([viewController class] == [LoginViewController class]) {
                    [self.navigationController popToViewController:viewController animated:NO];
                    break;
                    
                }
            }
        }
    }
    
    
    
}

- (IBAction)onMenuButtonPressed:(id)sender  {
    self.viewDeckController.panningCancelsTouchesInView=YES;
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    CustomNavigationController *nav = (    CustomNavigationController *)self.navigationController;
    if(delegate.currentLang==English){

        [nav.viewDeckController toggleLeftViewAnimated:YES];
    }else{

        [nav.viewDeckController toggleRightViewAnimated:YES];
    }
}

- (void) hideMenuViewer
{
    self.viewDeckController.panningCancelsTouchesInView=YES;
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    CustomNavigationController *nav = (    CustomNavigationController *)self.navigationController;
    if(delegate.currentLang==English){
        [nav.viewDeckController toggleLeftViewAnimated:FALSE];
    }else{
        [nav.viewDeckController toggleRightViewAnimated:FALSE];
    }
}

#pragma mark - touch methods


//The event handling method
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    [self onMenuButtonPressed:nil];
}
- (void)initalizeViews {
    
}

-(void)initRefreshControl:(UITableView*)tableView{
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl setTintColor:[UIColor whiteColor]];
    UIColor *color = [UIColor colorWithRed:236.0/255.0 green:236.0/255.0 blue:236.0/255.0 alpha:1];
    [refreshControl setBackgroundColor:color];
    refreshControl.layer.zPosition = tableView.backgroundView.layer.zPosition + 1;
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [tableView addSubview:refreshControl];
    
}


#pragma mark - localize lables

-(void)locatizeLables{
}

#pragma mark - layout funtions
-(void)switchLayout{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(delegate.currentLang==Arabic){
        [self switchToRightLayout];
    }else if(delegate.currentLang==English){
        [self switchToLeftLayout];
    }
}

-(void)switchToLeftLayout{
    
}

-(void)switchToRightLayout{
    
}
- (void)refresh:(UIRefreshControl *)refreshControl_ {
}
#pragma mark - refresh data
-(void) refreshView{
    
}

#pragma mark- activity funtions


-(void)showActivityViewer
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UIWindow *window = delegate.window;
    activityView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, window.bounds.size.width, window.bounds.size.height)];
    activityView.backgroundColor = [UIColor blackColor];
    activityView.alpha = 0.5;
    
    UIActivityIndicatorView *activityWheel = [[UIActivityIndicatorView alloc] initWithFrame: CGRectMake(window.bounds.size.width / 2 - 12, window.bounds.size.height / 2 - 12, 24, 24)];
    activityWheel.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    activityWheel.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin |
                                      UIViewAutoresizingFlexibleRightMargin |
                                      UIViewAutoresizingFlexibleTopMargin |
                                      UIViewAutoresizingFlexibleBottomMargin);
    [activityWheel setColor:[UIColor orangeColor]];
    [activityView addSubview:activityWheel];
    [window addSubview: activityView];
    
    [[[activityView subviews] objectAtIndex:0] startAnimating];
}
-(void)hideActivityViewer
{
    [[[activityView subviews] objectAtIndex:0] stopAnimating];
    [activityView removeFromSuperview];
    activityView = nil;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
#pragma mark - back button color

+ (UIColor*)getBackBtnColor{
    return [UIColor whiteColor];
}

#pragma mark - methods


-(void)logout{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    delegate.islogOut=YES;
    delegate.DB_data=nil;

    //fraz request
    [delegate deleteDeviceToken];
    /////
    
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")){
        //[self.navigationController popToRootViewControllerAnimated:NO];
    }else{
        for (UIViewController *viewController in self.navigationController.viewControllers) {
            if ([viewController class] == [LoginViewController class]) {
                [self.navigationController popToViewController:viewController animated:NO];
                break;
                
            }
        }
    }
    [StaticFuntions clearProfileData];
    UIViewController * viewController = [self.storyboard instantiateViewControllerWithIdentifier:SeagueLoginScreen];
    [self.navigationController pushViewController:viewController animated:NO];
}


//  custom  navigation  bar
- (void)showMenu{
    self.viewDeckController.panningCancelsTouchesInView=YES;
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    CustomNavigationController *nav = (    CustomNavigationController *)self.navigationController;
    if(delegate.currentLang==English){
        
        [nav.viewDeckController toggleLeftViewAnimated:YES];
    }else{
        
        [nav.viewDeckController toggleRightViewAnimated:YES];
    }
    
}
-(void)backHome{
    
    AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    ProfileObj * obj= [StaticFuntions getSavedData];
    
    if (!appdelegate.islogOut) {
        
        if (obj==nil || obj.userName == nil || [StaticFuntions isStringEmpty:obj.userName]) {
            // Check if User is stored or not
            LoginViewController *dash = [self.storyboard instantiateViewControllerWithIdentifier:SeagueLoginScreen];
            if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
                [self.navigationController pushViewController:dash animated:NO];
            } else {
                for (UIViewController *viewController in self.navigationController.viewControllers) {
                    if ([viewController class] == [LoginViewController class]) {
                        [self.navigationController popToViewController:viewController animated:NO];
                        break;
                    }
                }
            }
        } else {
            // Logged In
            DashBoardViewController *dash=[self.storyboard instantiateViewControllerWithIdentifier:SeagueDashBoardScreen];
            if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")){
                [self.navigationController pushViewController:dash animated:NO];
            }else{
                for (UIViewController *viewController in self.navigationController.viewControllers) {
                    if ([viewController class] == [DashBoardViewController class]) {
                        [self.navigationController popToViewController:viewController animated:NO];
                        break;
                        
                    }
                }
            }
        }
    }
    else
    {
        LoginViewController *dash=[self.storyboard instantiateViewControllerWithIdentifier:SeagueLoginScreen];
        if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")){
            [self.navigationController pushViewController:dash animated:NO];
        }else{
            for (UIViewController *viewController in self.navigationController.viewControllers) {
                if ([viewController class] == [LoginViewController class]) {
                    [self.navigationController popToViewController:viewController animated:NO];
                    break;
                    
                }
            }
        }
    }
    
    
    
    
}


- (void)replaceHomeAndMenu:(UIButton *)homeBtn :(UIButton *)menuBtn{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.currentLang==Arabic)
    {
        
        [homeBtn setImage:[UIImage imageNamed:@"home_btn.png"] forState:UIControlStateNormal];
        [menuBtn setImage:[UIImage imageNamed:@"menu_btn.png"] forState: UIControlStateNormal];
        
        
        
        
    }
    else {
        [menuBtn setImage:[UIImage imageNamed:@"home_btn.png"] forState:UIControlStateNormal];
        [homeBtn setImage:[UIImage imageNamed:@"menu_btn.png"] forState: UIControlStateNormal];
        
    }
    
}

@end
