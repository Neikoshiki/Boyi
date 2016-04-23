//
//  HomeViewController.m
//  Boyi
//
//  Created by Shvier on 16/4/15.
//  Copyright © 2016年 Shvier. All rights reserved.
//

#import "HomeViewController.h"
#import "UIScrollView+JElasticPullToRefresh.h"

#import "OAuthModel.h"
#import "URLHeaderDefine.h"

#define kReuseIdentifier @"reuseIdentifier"

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource, UIWebViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSString *weiboCode;
@property (nonatomic, copy) NSString *accessToken;
@property (nonatomic, strong) OAuthModel *oauthModel;

@end

@implementation HomeViewController

- (OAuthModel *)oauthModel {
    if (!_oauthModel) {
        self.oauthModel = [[OAuthModel alloc] init];
    }
    return _oauthModel;
}

#pragma mark -权限获取-
- (void)initOAuth {
    UIWebView *webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:webView];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kAuthorizeURL]];
    request.HTTPMethod = @"POST";
    NSString *parameter = [NSString stringWithFormat:@"client_id=%@&redirect_uri=%@", AppKey, kRedirectURL];
    NSData *requestBody = [parameter dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = requestBody;
    [webView loadRequest:request];
    webView.delegate = self;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *url = webView.request.URL.absoluteString;
    NSLog(@"%@", url);
    if ([url hasPrefix:kRedirectURL]) {
        NSArray *urlArray = [url componentsSeparatedByString:@"?"];
        self.weiboCode = [urlArray[1] substringFromIndex:5];
        NSLog(@"code:%@", self.weiboCode);
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kAccessTokenURL]];
        request.HTTPMethod = @"POST";
        NSString *parameter = [NSString stringWithFormat:@"client_id=%@&client_secret=%@&grant_type=authorization_code&redirect_uri=%@&code=%@", AppKey, AppSecret, kRedirectURL, self.weiboCode];
        NSData *requestBody = [parameter dataUsingEncoding:NSUTF8StringEncoding];
        request.HTTPBody = requestBody;
        [webView loadRequest:request];
    } else if ([url hasPrefix:kAccessTokenURL]) {
        NSString *jsToGetHTMLSource = @"document.getElementsByTagName('html')[0].innerHTML";
        NSString *HTMLSource = [webView stringByEvaluatingJavaScriptFromString:jsToGetHTMLSource];
        NSArray *htmlArray = [HTMLSource componentsSeparatedByString:@"{"];
        NSArray *array1 = [htmlArray[1] componentsSeparatedByString:@"}"];
        NSString *result = [[@"{" stringByAppendingString:array1[0]] stringByAppendingString:@"}"];
        NSData *data = [result dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        [self.oauthModel setValuesForKeysWithDictionary:dict];
        NSLog(@"%@", self.oauthModel);
        NSLog(@"filePath:%@", documentationPath);
        if (! [[NSFileManager defaultManager] fileExistsAtPath:documentationPath]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:documentationPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        NSString *filePath = [documentationPath stringByAppendingPathComponent:@"oauth"];
        [NSKeyedArchiver archiveRootObject:self.oauthModel toFile:filePath];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&uid=%@", kUserInfoURL, self.oauthModel.access_token, self.oauthModel.uid]]];
        NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@", dict);
        }];
        [task resume];
        [webView removeFromSuperview];
    }
}

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
    self.navigationItem.title = @"首页";
    
    [self initTableView];
//    if ([[NSFileManager defaultManager] fileExistsAtPath:[documentationPath stringByAppendingPathComponent:@"oauth"]]) {
//        self.oauthModel = [NSKeyedUnarchiver unarchiveObjectWithFile:[documentationPath stringByAppendingPathComponent:@"oauth"]];
//        NSLog(@"%@", self.oauthModel);
//    } else
//    {
        [self initOAuth];
//    }
}

- (void)dealloc {
    [self.tableView removeJElasticPullToRefreshView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
