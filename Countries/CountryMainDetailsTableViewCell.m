//
//  CountryMainDetailsTableViewCell.m
//  Countries
//
//  Created by John Raymund Catahay on 27/05/2017.
//  Copyright © 2017 John Raymund Catahay. All rights reserved.
//

#import "CountryMainDetailsTableViewCell.h"
#import "UIColor+Countries.h"
#import <Masonry/Masonry.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface CountryMainDetailsTableViewCell ()

@property (nonatomic, strong) UILabel *countryNameLabel;
@property (nonatomic, strong) UILabel *countryOtherNamesLabel;
@property (nonatomic, strong) UIWebView *flagView;
@property (nonatomic, strong) UIActivityIndicatorView *flagIndicatorView;

@end

@implementation CountryMainDetailsTableViewCell

@synthesize country = _country;

-(UILabel *)countryNameLabel {
    if (!_countryNameLabel) {
        _countryNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _countryNameLabel.numberOfLines = 0;
        _countryNameLabel.font = [UIFont boldSystemFontOfSize: 33];
        _countryNameLabel.textColor = UIColor.whiteColor;
        _countryNameLabel.layer.shadowColor = UIColor.grayColor.CGColor;
        _countryNameLabel.layer.shadowOpacity = 0.9;
        _countryNameLabel.layer.shadowOffset = CGSizeZero;
        _countryNameLabel.text = @"lorem lorem lorem";
    }
    return _countryNameLabel;
}

-(UILabel *)countryOtherNamesLabel {
    if (!_countryOtherNamesLabel) {
        _countryOtherNamesLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _countryOtherNamesLabel.numberOfLines = 0;
        _countryOtherNamesLabel.font = [UIFont systemFontOfSize: 20];
        _countryOtherNamesLabel.textColor = UIColor.whiteColor;
        _countryOtherNamesLabel.layer.shadowColor = UIColor.grayColor.CGColor;
        _countryOtherNamesLabel.layer.shadowOpacity = 0.9;
        _countryOtherNamesLabel.layer.shadowOffset = CGSizeZero;
        _countryOtherNamesLabel.text = @"lorem lorem lorem lorem lorem lorem lorem";
    }
    return _countryOtherNamesLabel;
}

-(UIWebView *)flagView {
    if (!_flagView) {
        _flagView = [[UIWebView alloc] initWithFrame:CGRectZero];
        _flagView.backgroundColor = UIColor.clearColor;
        _flagView.opaque = NO;
        _flagView.delegate = self;
        _flagView.layer.shadowColor = UIColor.grayColor.CGColor;
        _flagView.layer.shadowOpacity = 0.9;
        _flagView.layer.shadowOffset = CGSizeZero;
        _flagView.userInteractionEnabled = NO;
    }
    return _flagView;
}

-(UIActivityIndicatorView *)flagIndicatorView {
    if (!_flagIndicatorView) {
        _flagIndicatorView = [[UIActivityIndicatorView alloc] init];
    }
    return _flagIndicatorView;
}

- (void)setCountry:(Country *)country {
    _country = country;
    
    NSURL *url = [NSURL URLWithString:country.flag];
    NSMutableURLRequest *cacheRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:15.0];
    [self.flagView loadRequest: cacheRequest];
    
    self.countryNameLabel.text = country.name;
    self.countryOtherNamesLabel.text = [country.otherNames componentsJoinedByString:@", "];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = UIColor.clearColor;
        
        [self.contentView addSubview: self.flagView];
        [self.contentView addSubview: self.countryNameLabel];
        [self.contentView addSubview: self.countryOtherNamesLabel];
        [self.flagView addSubview: self.flagIndicatorView];
        
        @weakify(self)
        [[self rac_signalForSelector:@selector(webViewDidFinishLoad:)]
         subscribeNext:^(id x) {
             @strongify(self)
             [self relayOutFlagView];
             [self.flagIndicatorView stopAnimating];
         }];
        
        [[self rac_signalForSelector:@selector(webViewDidStartLoad:)]
         subscribeNext:^(id x) {
             @strongify(self)
             [self.flagIndicatorView startAnimating];
        }];
        
        [[self rac_signalForSelector:@selector(webView:didFailLoadWithError:)]
         subscribeNext:^(id x) {
             @strongify(self)
             [self.flagIndicatorView stopAnimating];
        }];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    [self.countryNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(8);
        make.left.mas_equalTo(self.contentView.mas_left).offset(24);
        make.width.mas_lessThanOrEqualTo(self.contentView).multipliedBy(0.7);
    }];
    [self.countryOtherNamesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.countryNameLabel.mas_bottom).offset(4);
        make.left.mas_equalTo(self.contentView.mas_left).offset(24);
        make.width.mas_lessThanOrEqualTo(self.contentView).multipliedBy(0.7);
    }];
    [self.flagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.countryOtherNamesLabel.mas_bottom).offset(16);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-16);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-16);
        make.width.mas_equalTo(self.contentView).multipliedBy(0.7);
        make.height.mas_equalTo(180);
    }];
    [self.flagIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.flagView);
    }];
}

- (void)relayOutFlagView {
    CGSize contentSize = self.flagView.scrollView.contentSize;
    CGSize webViewSize = self.flagView.bounds.size;
    CGFloat scaleFactor = webViewSize.width < webViewSize.height ? webViewSize.width / contentSize.width : webViewSize.height / contentSize.height;
    
    self.flagView.scrollView.minimumZoomScale = scaleFactor;
    self.flagView.scrollView.maximumZoomScale = scaleFactor;
    self.flagView.scrollView.zoomScale = scaleFactor;
    [self.flagView.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (void)dealloc {
    [self.flagView stopLoading];
    self.flagView.delegate = nil;
}

@end
