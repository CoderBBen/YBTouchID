//
//  WebViewController.m
//  TouchIDDemo
//
//  Created by Ben on 16/3/11.
//  Copyright © 2016年 https://github.com/CoderBBen/YBTouchID.git. All rights reserved.
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
    _webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://github.com"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    _webView.scalesPageToFit = YES;
    [self.view addSubview:_webView];
    
    UIButton *goForwardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    goForwardBtn.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
    goForwardBtn.frame = CGRectMake(kSCREEN_WIDTH-90, kSCREEN_HEIGHT-100, 90, 40);
    [goForwardBtn setTitle:@"goForward" forState:UIControlStateNormal];
    [goForwardBtn addTarget:self action:@selector(webViewWithGoforwardButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goForwardBtn];
    
    UIButton *goBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    goBackBtn.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
    goBackBtn.frame = CGRectMake(0, kSCREEN_HEIGHT-100, 90, 40);
    [goBackBtn setTitle:@"goBack" forState:UIControlStateNormal];
    [goBackBtn addTarget:self action:@selector(webViewWithGoBackButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goBackBtn];
}

- (void)webViewWithGoBackButton
{
    NSLog(@"goBack");
    [self.webView goBack];
}

- (void)webViewWithGoforwardButton
{
    NSLog(@"goForward");
    [self.webView goForward];
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
