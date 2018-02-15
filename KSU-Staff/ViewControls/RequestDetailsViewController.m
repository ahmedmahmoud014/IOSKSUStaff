//
//  RequestActionsViewController.m
//  KSU_Students
//
//  Created by EJ-Mac book on 8/2/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "RequestDetailsViewController.h"
#import "AppDelegate.h"
#import "LocalizedMessages.h"
#import "StaticFuntions.h"
#import "RequestManager.h"

@interface RequestDetailsViewController ()

@end

@implementation RequestDetailsViewController


@synthesize titleLbl;
@synthesize controlsView;
@synthesize viewBackBtn;
@synthesize listOfPages;
@synthesize listOfPageSections;
@synthesize backgroundView;
@synthesize detailsView;
@synthesize rowDetailsTableView;
@synthesize listOfRowDetails;
@synthesize detaislBackBtn;
@synthesize selectedRequest;
@synthesize noDataImg;
@synthesize pageController;
@synthesize pageIndex;
@synthesize changePageView;
@synthesize previousPageBtn;
@synthesize currentPageLbl;
@synthesize nextPageBtn;


NSInteger defaultDetailsTableViewHeight;
NSInteger defaultDetailsPopupHeight;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customizeNavigationBar:YES WithMenu:YES];
    /*if(IS_IPAD){
     int x= (self.view.frame.size.width- controlsView.frame.size.width)/2;
     controlsView.frame=CGRectMake(x, controlsView.frame.origin.y, controlsView.frame.size.width, controlsView.frame.size.height);
     }*/
    
    rowDetailsTableView.layoutMargins = UIEdgeInsetsZero;
    if ([rowDetailsTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [rowDetailsTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    rowDetailsTableView.contentOffset = CGPointMake(0.0, 0.0);
    
    defaultDetailsTableViewHeight = rowDetailsTableView.frame.size.height;
    defaultDetailsPopupHeight = detailsView.frame.size.height;
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
    
    noDataLbl.hidden=YES;
    noDataImg.hidden=YES;
    
    listOfPages = [[NSMutableArray alloc] init];
    listOfPageSections = [[NSMutableArray alloc] init];
    //80 -> 1000   1.5% month
    if([self isNetworkAvailable] ==YES)
    {
        NSLog(@"Network Connection available");
        [self connect];
    }
    
    else{
        [StaticFuntions showAlertWithTitle:NetWorkTitle Message:NetWorkBody];
        
    }}

-(void)locatizeLables{
    
    titleLbl.text=RequestDetailsTitleText;
    noDataLbl.text=RequestDetailsNoDataFoundMsg;
    [viewBackBtn setTitle:BackButtonText forState:UIControlStateNormal];
    [detaislBackBtn setTitle:BackButtonText forState:UIControlStateNormal];
    
    
}

-(void)switchToLeftLayout{
    
    titleLbl.textAlignment=NSTextAlignmentLeft;
    
    CGRect frame = titleLbl.frame;
    frame.origin.x = 8;
    titleLbl.frame = frame;
}

-(void)switchToRightLayout{
    
    viewBackBtn.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    viewBackBtn.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    viewBackBtn.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    
    detaislBackBtn.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    detaislBackBtn.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    detaislBackBtn.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    
    titleLbl.textAlignment=NSTextAlignmentRight;
    
    CGRect frame = titleLbl.frame;
    frame.origin.x = 8;
    titleLbl.frame = frame;
}


#pragma mark - NewRequestDetailsViewController delegate -

- (void)loadDetailedList:(NSMutableArray *)list {
    
    listOfRowDetails = [[NSMutableArray alloc] init];
    listOfRowDetails = list;
    [rowDetailsTableView reloadData];
    detailsView.hidden = FALSE;
    rowDetailsTableView.contentOffset = CGPointMake(0.0, 0.0);
    backgroundView.hidden = FALSE;
    [self.view insertSubview:backgroundView aboveSubview:pageController.view];
    [self.view insertSubview:detailsView aboveSubview:backgroundView];
    
    CGRect frame;
    NSInteger tableHeight = defaultDetailsTableViewHeight;
    NSInteger viewHeight = defaultDetailsPopupHeight;
    if (rowDetailsTableView.contentSize.height < defaultDetailsTableViewHeight) {
        tableHeight = rowDetailsTableView.contentSize.height;
        viewHeight = viewHeight - (defaultDetailsTableViewHeight - rowDetailsTableView.contentSize.height);
    }//100 40
    
    frame = rowDetailsTableView.frame;
    frame.size.height = tableHeight;
    rowDetailsTableView.frame = frame;
    
    frame = detailsView.frame;
    frame.size.height = viewHeight;
    frame.origin.y = 68 + ((controlsView.frame.size.height - frame.size.height) / 2) - 20;
    detailsView.frame = frame;
    
    
    frame = detaislBackBtn.frame;
    frame.origin.y = rowDetailsTableView.frame.size.height + 10;
    detaislBackBtn.frame = frame;
    
    //defaultDetailsPopupHeight
    
    
}

#pragma mark - table delegate
-(UITableViewCell*) tableView:(UITableView *)tblview cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier=@"RequestPageDetailsTableViewCell";
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.currentLang==English)
        CellIdentifier=@"RequestPageDetailsTableViewCell_en";
    else
        CellIdentifier=@"RequestPageDetailsTableViewCell";
    
    RequestPageDetailsTableViewCell *cell = [self.rowDetailsTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[RequestPageDetailsTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    RPageSectionRowObj *obj=nil;
    
//    RPageSectionObj *sObj = [[RPageSectionObj alloc] init];
//    NSMutableArray *listOfSectionRows;
    
    obj=[listOfRowDetails objectAtIndex:(int)indexPath.row];
    
    CGRect frame = [tblview rectForRowAtIndexPath:indexPath];
    [cell initWithRequestSectionRowObj:obj withRowId:(int)indexPath.row withHeight:frame.size.height ];
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tblView numberOfRowsInSection:(NSInteger)section{
    
    return [listOfRowDetails count];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tblView {
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tblView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    RPageSectionObj *sObj = [[RPageSectionObj alloc] init];
//    NSMutableArray *listOfSectionRows;
    RPageSectionRowObj *rObj;
    
    
    rObj=[listOfRowDetails objectAtIndex:(int)indexPath.row];
    
    static NSString *CellIdentifier=@"RequestPageDetailsTableViewCell";
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.currentLang==English)
        CellIdentifier=@"RequestPageDetailsTableViewCell_en";
    else
        CellIdentifier=@"RequestPageDetailsTableViewCell";
    
    RequestPageDetailsTableViewCell *cell = [self.rowDetailsTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[RequestPageDetailsTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    
    cell.titleLbl.numberOfLines = 1000;
    cell.valueLbl.numberOfLines = 1000;
    
    cell.titleLbl.text=rObj.label;
    cell.valueLbl.text=rObj.singleValue;
    
    CGRect frame;
    
    if (![rObj.dataType isEqualToString:@"list"]) {
        
        if ([rObj.dataType isEqualToString:@"labeltext"]) {
            cell.titleLbl.hidden = YES;
            frame = cell.valueLbl.frame;
            frame.size.width += cell.titleLbl.frame.size.width + 3;
            cell.valueLbl.frame = frame;
        }
        
        CGRect newFrame = cell.titleLbl.frame;
        CGSize newSize = [cell.titleLbl sizeThatFits:CGSizeMake(cell.titleLbl.frame.size.width, MAXFLOAT)];
        newFrame.size = CGSizeMake(fmaxf(newSize.width, cell.titleLbl.frame.size.width), newSize.height);
        NSInteger difference1 = (newFrame.size.height) - cell.titleLbl.frame.size.height;
        
        newFrame = cell.valueLbl.frame;
        newSize = [cell.valueLbl sizeThatFits:CGSizeMake(cell.valueLbl.frame.size.width, MAXFLOAT)];
        newFrame.size = CGSizeMake(fmaxf(newSize.width, cell.valueLbl.frame.size.width), newSize.height);
        NSInteger difference2 = (newFrame.size.height) - cell.valueLbl.frame.size.height;
        
        NSInteger height = 0;
        
        if (difference1 > difference2)
            height = cell.valueLbl.frame.size.height + 15 + difference1;
        else
            height = cell.valueLbl.frame.size.height + 15 + difference2;
        
        
        return height;
    }
    return 1;
    
    
}

- (void)tableView:(UITableView *)tView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[self showDetails:indexPath.row];
    [tView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - methods

-(void)setNoDataRow{
    RPageObj *pObj = [[RPageObj alloc] init];
    
    RPageSectionObj *sObj = [[RPageSectionObj alloc] init];
    NSMutableArray *listOfSectionRows;
    RPageSectionRowObj *rObj=nil;
    
    for (int j=0; j<[listOfPages count]; j++) {
        pObj = [listOfPages objectAtIndex:j];
        listOfPageSections = pObj.sections;
        for (int i=0; i<[listOfPageSections count]; i++) {
            sObj = [listOfPageSections objectAtIndex:i];
            listOfSectionRows = [[NSMutableArray alloc] init];
            listOfSectionRows = sObj.rows;
            if ([listOfSectionRows count] == 0) {
                rObj = [[RPageSectionRowObj alloc] init];
                rObj.dataType = @"noData";
                rObj.label = @"";
                rObj.singleValue = NoDataFoundMsg;
                rObj.listValue = [[NSMutableArray alloc] init];
                [listOfSectionRows insertObject:rObj atIndex:0];
                sObj.rows = listOfSectionRows;
                [listOfPageSections replaceObjectAtIndex:i withObject:sObj];
                pObj.sections = listOfPageSections;
                [listOfPages replaceObjectAtIndex:j withObject:pObj];
            }
        }
    }
    
    
    
}

- (NewRequestDetailsViewController *)detailsViewControllerAtIndex:(NSUInteger)index
{
    if (([self.listOfPages count] <= 0) || (index >= [self.listOfPages count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    NewRequestDetailsViewController *NewRequestDetailsViewController = [[UIStoryboard storyboardWithName:@"NewMain" bundle:nil]instantiateViewControllerWithIdentifier:@"NewRequestDetailsViewController"];
    
    RPageObj *pObj = [[RPageObj alloc] init];
    pObj = [listOfPages objectAtIndex:index];
    listOfPageSections = pObj.sections;
    
    NewRequestDetailsViewController.delegation = self;
    NewRequestDetailsViewController.listOfPageSections = listOfPageSections;
    NewRequestDetailsViewController.pageIndex = index;
    
    return NewRequestDetailsViewController;
}


-(void)connect{
    
    noDataLbl.hidden=NO;
    noDataImg.hidden=NO;
//    [[RequestManager sharedInstance] readRequestDetailsFromJSONFile:self];
    [[RequestManager sharedInstance] getRequestDetails:self withRequestCode:selectedRequest];
    [self showActivityViewer];
}

#pragma mark - connection

- (void)processCompleted:(id)data error:(CustomError *)error withService:(NSNumber *)service{
    [self hideActivityViewer];
    if(data!=nil){
        
        NSMutableArray* pagesArr =(NSMutableArray*)data;
        for(int i=0;i<[pagesArr count];i++){
            
            RPageObj *pObj = [[RPageObj alloc] init];
            pObj = [pagesArr objectAtIndex:i];
            if(!listOfPages){
                listOfPages=[[NSMutableArray alloc] init];
            }
            [listOfPages addObject:pObj];
        }
        //24 , 32 ,42 , 64
        if ([listOfPages count] > 0) {
            
            noDataLbl.hidden=YES;
            noDataImg.hidden=YES;
            [self setNoDataRow];
            
            changePageView.hidden = FALSE;
            currentPageLbl.text = [NSString stringWithFormat:@"%i / %lu", 1, (unsigned long)[listOfPages count]];
            
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            if (appDelegate.currentLang == English) {
                previousPageBtn.enabled = FALSE;
                if ([listOfPages count] > 1)
                    nextPageBtn.enabled = YES;
                else
                    nextPageBtn.enabled = FALSE;
            } else {
                nextPageBtn.enabled = FALSE;
                if ([listOfPages count] > 1)
                    previousPageBtn.enabled = YES;
                else
                    previousPageBtn.enabled = FALSE;
            }
            
            
            
            self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
            self.pageController.delegate = self;
            self.pageController.dataSource = self;
            NewRequestDetailsViewController *startingViewController = [self detailsViewControllerAtIndex:0];
            NSArray *viewControllers = @[startingViewController];
            [self.pageController setViewControllers:viewControllers
                                              direction:UIPageViewControllerNavigationDirectionReverse
                                               animated:NO
                                             completion:nil];
            [self addChildViewController:self.pageController];
            [self.view addSubview:self.pageController.view];
            [self.pageController didMoveToParentViewController:self];
            CGRect pageViewRect = self.view.bounds;
            pageViewRect = CGRectMake(0, controlsView.frame.origin.y, self.view.frame.size.width, controlsView.frame.size.height - 90);
            self.pageController.view.frame = pageViewRect;
            self.view.gestureRecognizers = self.pageController.gestureRecognizers;
        }
        
    }else{
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:error.errorMessage];
    }
    
    
    
}

#pragma mark - UIPageViewControllerDelegate Methods

- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController
                   spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    
    
       //Set the array with only 1 view controller
    
    UIViewController *currentViewController = self.pageController.viewControllers[0];
    
    self.pageController.doubleSided = NO;
    NSArray *viewControllers = @[currentViewController];
    [self.pageController setViewControllers:viewControllers     direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:NULL];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.currentLang==English)
        return UIPageViewControllerSpineLocationMin;
    
    return UIPageViewControllerSpineLocationMax;

}

#pragma mark - Page View Controller Data Source
-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    nextPageBtn.enabled = FALSE;
    previousPageBtn.enabled = FALSE;
    
    NewRequestDetailsViewController *viewController = [self.pageController.viewControllers lastObject];
    NSInteger currentIndex = [viewController pageIndex];
    currentPageLbl.text = [NSString stringWithFormat:@"%lu / %lu",(unsigned long)(currentIndex+1),(unsigned long)[listOfPages count]];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDelegate.currentLang == English) {
        if (currentIndex == [listOfPages count] - 1) {
            nextPageBtn.enabled = FALSE;
            previousPageBtn.enabled = YES;
        } else {
            nextPageBtn.enabled = YES;
            if (currentIndex > 0)
                previousPageBtn.enabled = YES;
        }
    } else {
        if (currentIndex == [listOfPages count] - 1) {
            previousPageBtn.enabled = FALSE;
            nextPageBtn.enabled = YES;
        } else {
            previousPageBtn.enabled = YES;
            if (currentIndex > 0)
                nextPageBtn.enabled = YES;
        }
    }
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.currentLang==English){
        NSUInteger index = ((NewRequestDetailsViewController*) viewController).pageIndex;
        
        if ((index == 0) || (index == NSNotFound))
            return nil;
        index--;
        
        return [self detailsViewControllerAtIndex:index];
    }
    else
    {
        NSUInteger index = ((NewRequestDetailsViewController*) viewController).pageIndex;
        
        if (index == NSNotFound)
            return nil;
        index++;
        if (index == [self.listOfPages count])
            return nil;
        
        return [self detailsViewControllerAtIndex:index];
    }
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.currentLang==English){
        NSUInteger index = ((NewRequestDetailsViewController*) viewController).pageIndex;
        
        if (index == NSNotFound)
            return nil;
        index++;
        if (index == [self.listOfPages count])
            return nil;
        
        return [self detailsViewControllerAtIndex:index];
    }
    else{
        NSUInteger index = ((NewRequestDetailsViewController*) viewController).pageIndex;
        if ((index == 0) || (index == NSNotFound))
            return nil;
        index--;
        
        return [self detailsViewControllerAtIndex:index];
    }

    /**/
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    if ([listOfPages count] > 0) {
        return [listOfPages count];
    }
    return 1;
    
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

#pragma mark - events

-(IBAction)onChangePages:(id)sender
{
    NewRequestDetailsViewController *viewController = [self.pageController.viewControllers lastObject];
    NSInteger currentIndex = [viewController pageIndex];
    NSInteger newIndex = -1;
    if (sender == previousPageBtn) { // Previous
        
        
        [UIView animateWithDuration:1.0
                         animations:^{
                             CATransition  * animation = [CATransition animation];
                             [animation setDelegate:(id)self];
                             [animation setDuration:0.7f];
                             animation.startProgress = 0.0;
                             animation.endProgress   = 1;
                             [animation setTimingFunction:UIViewAnimationCurveEaseInOut];
                             [animation setType:@"pageCurl"];
                             [animation setSubtype:@"fromLeft"];
                             [animation setRemovedOnCompletion:NO];
                             [animation setFillMode: @"extended"];
                             [animation setRemovedOnCompletion: NO];
                             [[self.pageController.view layer] addAnimation:animation
                                                                     forKey:@"pageFlipAnimation"];
                             //[self.pageController.view addSubview:tempUIView];
                             
                             NewRequestDetailsViewController *currentViewController = [self detailsViewControllerAtIndex:currentIndex];
                             UIViewController *nextViewController = [self pageViewController:self.pageController viewControllerBeforeViewController:currentViewController];
                             
                             NSArray *viewControllers = @[nextViewController];
                             self.pageController.doubleSided = NO;
                             [self.pageController setViewControllers:viewControllers     direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:NULL];
                         }
         ];
      // Previous BTN
    } else if (sender == nextPageBtn) { // Next
        [UIView animateWithDuration:1.0
                         animations:^{
                             CATransition  * animation = [CATransition animation];
                             [animation setDelegate:(id)self];
                             [animation setDuration:0.7f];
                             animation.startProgress = 0.0;
                             animation.endProgress   = 1;
                             [animation setTimingFunction:UIViewAnimationCurveEaseInOut];
                             [animation setType:@"pageCurl"];
                             [animation setSubtype:@"fromRight"];
                             [animation setRemovedOnCompletion:NO];
                             [animation setFillMode: @"extended"];
                             [animation setRemovedOnCompletion: NO];
                             [[self.pageController.view layer] addAnimation:animation
                                                                     forKey:@"pageFlipAnimation"];
                             
                             NewRequestDetailsViewController *currentViewController = [self detailsViewControllerAtIndex:currentIndex];
                             UIViewController *nextViewController = [self pageViewController:self.pageController viewControllerAfterViewController:currentViewController];
                             
                             NSArray *viewControllers = @[nextViewController];
                             self.pageController.doubleSided = NO;
                             [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:NULL];
                         }
         ];
        // Next BTN
    }
   
    nextPageBtn.enabled = FALSE;
    previousPageBtn.enabled = FALSE;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDelegate.currentLang == English) {
        
        // FIXING Next & Prevoius Pagination
        
        if (sender == nextPageBtn) {
            // Next
            newIndex = currentIndex + 2;
        } else {
            // Previous
            newIndex = currentIndex;
        }
        
        if (newIndex == [listOfPages count]) {
            nextPageBtn.enabled = FALSE;
            previousPageBtn.enabled = YES;
        } else {
            nextPageBtn.enabled = YES;
            if (newIndex > 1)
                previousPageBtn.enabled = YES;
        }
    } else {
        // Arabic
        
        if (sender == nextPageBtn) {
            // Previous
            newIndex = currentIndex;
        } else {
            // Next
            newIndex = currentIndex + 2;
        }
        
        if (newIndex == [listOfPages count]) {
            previousPageBtn.enabled = FALSE;
            nextPageBtn.enabled = YES;
        } else {
            previousPageBtn.enabled = YES;
            if (newIndex > 1)
                nextPageBtn.enabled = YES;
        }
    }
    
    currentPageLbl.text = [NSString stringWithFormat:@"%lu / %lu",(unsigned long)(newIndex),(unsigned long)[listOfPages count]];
}

-(IBAction)onPressBack:(id)sender
{
    if (sender == viewBackBtn)
    {
        [self.navigationController popViewControllerAnimated:NO];
    }
    else if (sender == detaislBackBtn)
    {
        backgroundView.hidden = YES;
        detailsView.hidden = YES;
        
    }
}

@end
