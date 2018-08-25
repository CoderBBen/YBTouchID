//
//  WebViewController.m
//  YBTouchIDToolDemo
//
//  Created by idbeny on 16/3/11.
//  Copyright © 2016年 https://github.com/idbeny/YBTouchID.git. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"WEB PAGE";
    self.navigationController.navigationItem.hidesBackButton = YES;
    [self addSubViews];
}

#pragma mark - Private Method
- (void)addSubViews {
    [self.view addSubview:self.webView];
    
    UIButton *goForwardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    goForwardBtn.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
    goForwardBtn.frame = CGRectMake(kSCREEN_WIDTH-90, kSCREEN_HEIGHT-100, 90, 40);
    [goForwardBtn setTitle:@"goForward" forState:UIControlStateNormal];
    [goForwardBtn addTarget:self action:@selector(webViewForGoforward) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goForwardBtn];
    
    UIButton *goBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    goBackBtn.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
    goBackBtn.frame = CGRectMake(0, kSCREEN_HEIGHT-100, 90, 40);
    [goBackBtn setTitle:@"goBack" forState:UIControlStateNormal];
    [goBackBtn addTarget:self action:@selector(webViewForBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goBackBtn];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.webView.frame = self.view.bounds;
}

//goBack
- (void)webViewForBack {
    [self.webView goBack];
}

//goForward
- (void)webViewForGoforward {
    [self.webView goForward];
}

#pragma mark - Setter and Getter
- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.scalesPageToFit = YES;
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://idbeny.com"]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:request];
    }
    return _webView;
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

@end
