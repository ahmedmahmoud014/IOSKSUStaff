//
//  SWUtilityButtonView.m
//  SWTableViewCell
//
//  Created by Matt Bowman on 11/27/13.
//  Copyright (c) 2013 Chris Wendel. All rights reserved.
//

#import "SWUtilityButtonView.h"
#import "SWUtilityButtonTapGestureRecognizer.h"
//#import "ApplicationAppDelegate.h"

@interface SWUtilityButtonView()

@property (nonatomic, strong) NSLayoutConstraint *widthConstraint;
@property (nonatomic, strong) NSMutableArray *buttonBackgroundColors;

@end

@implementation SWUtilityButtonView

#pragma mark - SWUtilityButonView initializers

- (id)initWithUtilityButtons:(NSArray *)utilityButtons parentCell:(SWTableViewCell *)parentCell utilityButtonSelector:(SEL)utilityButtonSelector
{
    self = [self initWithFrame:CGRectZero utilityButtons:utilityButtons parentCell:parentCell utilityButtonSelector:utilityButtonSelector];
    
    [self setBackgroundColor:[UIColor colorWithRed:(207/255.f) green:(207/255.f) blue:(207/255.f) alpha:1.0]];
    
    
    
    return self;
}

- (id)initWithFrame:(CGRect)frame utilityButtons:(NSArray *)utilityButtons parentCell:(SWTableViewCell *)parentCell utilityButtonSelector:(SEL)utilityButtonSelector
{
    self = [super initWithFrame:frame];
    
    
    if (self) {
        //self.translatesAutoresizingMaskIntoConstraints = NO;
        
        /* self.widthConstraint = [NSLayoutConstraint constraintWithItem:self
         attribute:NSLayoutAttributeWidth
         relatedBy:NSLayoutRelationEqual
         toItem:nil
         attribute:NSLayoutAttributeWidth
         multiplier:1.0
         constant:300.0]; // constant will be adjusted dynamically in -setUtilityButtons:.
         self.widthConstraint.priority = UILayoutPriorityDefaultHigh;
         [self addConstraint:self.widthConstraint];
         
         
         */
        
        
        
        _parentCell = parentCell;
        self.utilityButtonSelector = utilityButtonSelector;
        self.utilityButtons = utilityButtons;
        
        
    }
    
    
    
    
    
    CGRect frame2 = CGRectMake(0.0, 0.0, CellWidthSwipe, ((Cellheight / 2) +  ((Cellheight / 3) * 2)));
    self.frame = frame2;
    
    _parentCell = parentCell;
    self.utilityButtonSelector = utilityButtonSelector;
    self.utilityButtons = utilityButtons;
    
    
    return self;
}

#pragma mark Populating utility buttons

- (void)setUtilityButtons:(NSArray *)utilityButtons
{
    for (UIButton *button in _utilityButtons)
    {
        [button removeFromSuperview];
    }
    
    _utilityButtons = [utilityButtons copy];
    
    if (utilityButtons.count)
    {
        NSUInteger utilityButtonsCounter = 0;
        UIView *precedingView = nil;
        
        for (UIButton *button in _utilityButtons)
        {
            [self addSubview:button];
            button.translatesAutoresizingMaskIntoConstraints = NO;
            
           /* if (!precedingView)
            {
                // First button; pin it to the left edge.
                [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[button]"
                                                                             options:0L
                                                                             metrics:nil
                                                                               views:NSDictionaryOfVariableBindings(button)]];
            }
            else
            {
                
                [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[precedingView][button(==precedingView)]"
                                                                             options:0L
                                                                             metrics:nil
                                                                               views:NSDictionaryOfVariableBindings(precedingView, button)]];
                
            }
            */
            
            //button.frame = CGRectMake(100.0, 0.0, CellWidthSwipe, ((Cellheight / 2) +  ((Cellheight / 3) * 2)));
            //[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[button]|"
            //                                                           options:0L
            //                                                         metrics:nil
            //                                                         views:NSDictionaryOfVariableBindings(button)]];
            
            
            
            
            
            SWUtilityButtonTapGestureRecognizer *utilityButtonTapGestureRecognizer = [[SWUtilityButtonTapGestureRecognizer alloc] initWithTarget:_parentCell
                                                                                                                                        action:_utilityButtonSelector];
            utilityButtonTapGestureRecognizer.buttonIndex = utilityButtonsCounter;
            [button addGestureRecognizer:utilityButtonTapGestureRecognizer];
            
            utilityButtonsCounter++;
            precedingView = button;
            
            utilityButtonsCounter++;
            precedingView = button;
            
            
        }
        
        // Pin the last button to the right edge.
        //[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[precedingView]|"
                                                   //                  options:0L
                                                     //                metrics:nil
                                                       //                views:NSDictionaryOfVariableBindings(precedingView)]];
    }
    //self.widthConstraint.constant = (300);
    
    //self.widthConstraint.constant = (kUtilityButtonWidthDefault * utilityButtons.count);
    
    
    [self setNeedsLayout];
    
    return;
}

#pragma mark -

- (void)pushBackgroundColors
{
    self.buttonBackgroundColors = [[NSMutableArray alloc] init];
    
    for (UIButton *button in self.utilityButtons)
    {
        [self.buttonBackgroundColors addObject:button.backgroundColor];
    }
}

- (void)popBackgroundColors
{
    NSEnumerator *e = self.utilityButtons.objectEnumerator;
    
    for (UIColor *color in self.buttonBackgroundColors)
    {
        UIButton *button = [e nextObject];
        button.backgroundColor = color;
    }
    
    self.buttonBackgroundColors = nil;
}

@end

