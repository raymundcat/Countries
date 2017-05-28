//
//  WebViewController.m
//  Countries
//
//  Created by John Raymund Catahay on 28/05/2017.
//  Copyright © 2017 John Raymund Catahay. All rights reserved.
//

#import "FlagWebViewController.h"
#import <Masonry/Masonry.h>

@interface FlagWebViewController ()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation FlagWebViewController

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.scalesPageToFit = YES;
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
}

-(void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (void)loadCountry: (Country *)country {
    NSURL *url = [NSURL URLWithString: country.flag];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest: request];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    CGSize contentSize = self.webView.scrollView.contentSize;
    CGSize webViewSize = self.webView.bounds.size;
    CGFloat scaleFactor = webViewSize.width < webViewSize.height ? webViewSize.width / contentSize.width : webViewSize.height / contentSize.height;
    
    self.webView.scrollView.minimumZoomScale = scaleFactor;
    self.webView.scrollView.maximumZoomScale = scaleFactor;
    self.webView.scrollView.zoomScale = scaleFactor;
    
    [self.webView.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (void)dealloc {
    [self.webView stopLoading];
    self.webView.delegate = nil;
}

@end
