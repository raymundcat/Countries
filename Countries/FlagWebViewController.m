//
//  WebViewController.m
//  Countries
//
//  Created by John Raymund Catahay on 28/05/2017.
//  Copyright © 2017 John Raymund Catahay. All rights reserved.
//

#import "FlagWebViewController.h"
#import <Masonry/Masonry.h>
#import "UIColor+Countries.h"
#import <ChameleonFramework/Chameleon.h>

@interface FlagWebViewController ()

@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) UIImageView *mapView;

@end

@implementation FlagWebViewController

#pragma mark - Private Subviews

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.scalesPageToFit = YES;
        _webView.backgroundColor = UIColor.clearColor;
        _webView.opaque = NO;
        _webView.scrollView.contentInset = UIEdgeInsetsMake(70, 0, 0, 20);
    }
    return _webView;
}

- (UIImageView *)mapView {
    if (!_mapView) {
        _mapView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _mapView.image = [UIImage imageNamed:@"worldmap"];
        _mapView.contentMode = UIViewContentModeScaleAspectFill;
        _mapView.alpha = 0.3;
    }
    return _mapView;
}

#pragma mark - Public

- (void)loadCountry: (Country *)country {
    NSURL *url = [NSURL URLWithString: country.flag];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest: request];
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview: self.mapView];
    [self.view addSubview:self.webView];
    self.view.backgroundColor = [UIColor colorWithGradientStyle:UIGradientStyleTopToBottom
                                                      withFrame:self.view.frame
                                                      andColors:@[UIColor.skyBlueColor,
                                                                  UIColor.lightBlueGreenColor]];
}

-(void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (void)dealloc {
    [self.webView stopLoading];
    self.webView.delegate = nil;
}

@end
