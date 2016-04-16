//
//  CommentViewController.m
//  Boyi
//
//  Created by Shvier on 16/4/15.
//  Copyright © 2016年 Shvier. All rights reserved.
//

#import "CommentViewController.h"
#import "UIScrollView+JElasticPullToRefresh.h"

#define kReuseIdentifier @"reuseIdentifier"

@interface CommentViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation CommentViewController

#pragma mark -TableView 代理方法-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifier forIndexPath:indexPath];
    return cell;
}

#pragma mark -TableView 初始化-
- (void)initTableView {
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kReuseIdentifier];
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    JElasticPullToRefreshLoadingViewCircle *loadingViewCircle = [[JElasticPullToRefreshLoadingViewCircle alloc] init];
    loadingViewCircle.tintColor = [UIColor whiteColor];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kReuseIdentifier];
    __weak __typeof(self)weakSelf = self;
    [self.tableView addJElasticPullToRefreshViewWithActionHandler:^{
        [weakSelf.tableView stopLoading];
    } LoadingView:loadingViewCircle];
    [self.tableView setJElasticPullToRefreshFillColor:[UIColor colorWithRed:0.0431 green:0.7569 blue:0.9412 alpha:1.0]];
    [self.tableView setJElasticPullToRefreshBackgroundColor:self.tableView.backgroundColor];
}

#pragma mark -视图加载-
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"评论";
    
    [self initTableView];
}

- (void)dealloc {
    [self.tableView removeJElasticPullToRefreshView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
