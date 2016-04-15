//
//  ViewController.m
//  Boyi
//
//  Created by Shvier on 16/4/15.
//  Copyright © 2016年 Shvier. All rights reserved.
//

#import "ViewController.h"
#import "BaseViewController.h"
#import "HomeViewController.h"
#import "AtViewController.h"
#import "MessageViewController.h"
#import "CommentViewController.h"
#import "LikeViewController.h"
#import "LeftMenuViewController.h"
#import "FrameDefineHeader.h"
#import "Boyi-Swift.h"

#define kPresentSegueName @"PresentMenuSegue"
#define kDismissSegueName @"DismissMenuSegue"

@interface ViewController () <UIViewControllerTransitioningDelegate, FlowingMenuDelegate>

@property (nonatomic, strong) BaseViewController *baseVC;
@property (nonatomic, strong) UINavigationController *naVC;
@property (nonatomic, strong) FlowingMenuTransitionManager *manager;
@property (nonatomic, strong) LeftMenuViewController *menuVC;

@end

@implementation ViewController

- (IBAction)close:(UIStoryboardSegue *)segue {
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kPresentSegueName]) {
        LeftMenuViewController *menuVC = segue.destinationViewController;
        menuVC.transitioningDelegate = self.manager;
        [self.manager setInteractiveDismissView:menuVC.view];
        self.menuVC = menuVC;
    }
}

- (void)flowingMenuNeedsPresentMenu:(FlowingMenuTransitionManager *)flowingMenu {
    [self performSegueWithIdentifier:kPresentSegueName sender:self];
}

- (void)flowingMenuNeedsDismissMenu:(FlowingMenuTransitionManager *)flowingMenu {
    [self.menuVC performSegueWithIdentifier:kDismissSegueName sender:self];
}

- (UIColor *)colorOfElasticShapeInFlowingMenu:(FlowingMenuTransitionManager *)flowingMenu {
    return [UIColor colorWithRed:0.30 green:0.30 blue:0.30 alpha:1.00];
}

- (CGFloat)flowingMenu:(FlowingMenuTransitionManager *)flowingMenu widthOfMenuView:(UIView *)menuView {
    return kScreenWidth*2/3;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.30 green:0.30 blue:0.30 alpha:1.00];
    self.manager = [[FlowingMenuTransitionManager alloc] init];
    [self.manager setInteractivePresentationView:self.view];
    self.manager.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
