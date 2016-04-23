//
//  CommentViewController.m
//  Boyi
//
//  Created by Shvier on 16/4/15.
//  Copyright © 2016年 Shvier. All rights reserved.
//

#import "CommentViewController.h"
#import "UIScrollView+JElasticPullToRefresh.h"

#import "NetWorkRequestManager.h"
#import "URLHeaderDefine.h"
#import "OAuthModel.h"
#import "CommentModel.h"

#define kReuseIdentifier @"reuseIdentifier"

@interface CommentViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) OAuthModel *oauthModel;
@property (nonatomic, strong) NSMutableArray *commentsArray;

@end

@implementation CommentViewController

- (NSMutableArray *)commentsArray {
    if (!_commentsArray) {
        self.commentsArray = [NSMutableArray array];
    }
    return _commentsArray;
}

- (OAuthModel *)oauthModel {
    if (!_oauthModel) {
        self.oauthModel = [[OAuthModel alloc] init];
    }
    return _oauthModel;
}

#pragma mark -TableView 代理方法-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.commentsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    return cell;
}

#pragma mark -TableView 初始化-
- (void)initTableView {
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kReuseIdentifier];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
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

- (void)requestDataWithAccessToken:(NSString *)accessToken {
    [NetWorkRequestManager requestWithType:GET urlString:[kCommentsToMeURL stringByAppendingString:[NSString stringWithFormat:@"?access_token=%@", accessToken]] parseDict:nil finish:^(NSData *data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *array = dict[@"comments"];
        for (NSDictionary *commentDict in array) {
            CommentModel *comment = [[CommentModel alloc] init];
            [comment setValuesForKeysWithDictionary:commentDict];
            NSLog(@"%@", comment.text);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    } error:^(NSError *error) {
        NSLog(@"error:%@", error);
    }];
}

#pragma mark -视图加载-
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"评论";
    
    [self initTableView];
    
    self.oauthModel = [NSKeyedUnarchiver unarchiveObjectWithFile:[documentationPath stringByAppendingPathComponent:@"oauth"]];
    [self requestDataWithAccessToken:self.oauthModel.access_token];
}

- (void)dealloc {
    [self.tableView removeJElasticPullToRefreshView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
