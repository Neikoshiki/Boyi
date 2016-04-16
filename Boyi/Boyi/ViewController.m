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
#import "HotViewController.h"
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

@property (nonatomic, strong) __block BaseViewController *baseVC;
@property (nonatomic, strong) UINavigationController *naVC;
@property (nonatomic, strong) FlowingMenuTransitionManager *manager;
@property (nonatomic, strong) LeftMenuViewController *menuVC;

@end

@implementation ViewController

#pragma mark -弹性动画-
- (IBAction)close:(UIStoryboardSegue *)segue {
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kPresentSegueName]) {
        LeftMenuViewController *menuVC = segue.destinationViewController;
        menuVC.transitioningDelegate = self.manager;
        [self.manager setInteractiveDismissView:menuVC.view];
        self.menuVC = menuVC;
        self.menuVC.rootVC = self;
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

#pragma mark -视图初始化-
- (void)initRootView {
    self.view.backgroundColor = [UIColor colorWithRed:0.30 green:0.30 blue:0.30 alpha:1.00];
    self.manager = [[FlowingMenuTransitionManager alloc] init];
    [self.manager setInteractivePresentationView:self.view];
    self.manager.delegate = self;
    self.baseVC = [[HomeViewController alloc] init];
    self.naVC = [[UINavigationController alloc] initWithRootViewController:self.baseVC];
    [self.view addSubview:self.naVC.view];
    __weak __typeof(self)weakSelf = self;
    self.menuDidClick = ^(NSString *vcName) {
        [weakSelf update:vcName];
    };
}
    
- (void)update:(NSString *)vcName {
    if ([NSStringFromClass([self.baseVC class]) isEqualToString:vcName]) {
        [self.menuVC performSegueWithIdentifier:kDismissSegueName sender:self];
        return ;
    } else {
        [self.baseVC.view removeFromSuperview];
        [self.naVC.view removeFromSuperview];
        Class class = NSClassFromString(vcName);
        self.baseVC = [[class alloc] init];
        self.naVC = [[UINavigationController alloc] initWithRootViewController:self.baseVC];
        [self.view addSubview:self.naVC.view];
        [self.menuVC performSegueWithIdentifier:kDismissSegueName sender:self];
    }
};

#pragma mark -加载视图-
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initRootView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
