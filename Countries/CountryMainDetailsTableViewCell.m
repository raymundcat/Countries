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
@import Hero;

@interface CountryMainDetailsTableViewCell ()

@property (strong, nonatomic) UILabel *countryNameLabel;
@property (strong, nonatomic) UILabel *countryOtherNamesLabel;
@property (strong, nonatomic) UIWebView *flagView;
@property (strong, nonatomic) UIActivityIndicatorView *flagIndicatorView;
@property (strong, nonatomic) UITapGestureRecognizer *flagTapRecognizer;
@property (strong, nonatomic, readwrite) RACSubject *didTapFlagSubject;

@end

@implementation CountryMainDetailsTableViewCell

#pragma mark - Private

@synthesize country = _country;

#pragma mark - Private Subviews

-(UILabel *)countryNameLabel {
    if (!_countryNameLabel) {
        _countryNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _countryNameLabel.numberOfLines = 0;
        _countryNameLabel.font = [UIFont boldSystemFontOfSize: 33];
        _countryNameLabel.textColor = UIColor.whiteColor;
        _countryNameLabel.layer.shadowColor = UIColor.grayColor.CGColor;
        _countryNameLabel.layer.shadowOpacity = 0.9;
        _countryNameLabel.layer.shadowOffset = CGSizeZero;
        _countryNameLabel.textAlignment = NSTextAlignmentRight;
        _countryNameLabel.text = @"";
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
        _countryOtherNamesLabel.textAlignment = NSTextAlignmentRight;
        _countryOtherNamesLabel.text = @"";
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
        _flagView.userInteractionEnabled = YES;
        _flagView.scrollView.scrollEnabled = NO;
        [_flagView addGestureRecognizer:self.flagTapRecognizer];
    }
    return _flagView;
}

-(UIActivityIndicatorView *)flagIndicatorView {
    if (!_flagIndicatorView) {
        _flagIndicatorView = [[UIActivityIndicatorView alloc] init];
    }
    return _flagIndicatorView;
}

- (UITapGestureRecognizer *)flagTapRecognizer {
    if (!_flagTapRecognizer) {
        _flagTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapFlagView)];
        _flagTapRecognizer.numberOfTapsRequired = 1;
        _flagTapRecognizer.delegate = self;
    }
    return _flagTapRecognizer;
}

#pragma mark - Public

- (void)setCountry:(Country *)country {
    _country = country;
    
    NSURL *url = [NSURL URLWithString:country.flag];
    NSMutableURLRequest *cacheRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:15.0];
    [self.flagView loadRequest: cacheRequest];
    
    self.countryNameLabel.text = country.name;
    self.countryOtherNamesLabel.text = [country.otherNames componentsJoinedByString:@", "];
}

- (RACSubject *)didTapFlagSubject {
    if (!_didTapFlagSubject) {
        _didTapFlagSubject = [RACSubject subject];
    }
    return _didTapFlagSubject;
}

#pragma mark - Lifecycle

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
             [self layoutFlagView];
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

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.countryNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(8);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-16);
        make.width.mas_lessThanOrEqualTo(self.contentView).multipliedBy(0.7);
    }];
    [self.countryOtherNamesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.countryNameLabel.mas_bottom).offset(4);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-16);
        make.width.mas_lessThanOrEqualTo(self.contentView).multipliedBy(0.7);
    }];
    [self.flagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.countryOtherNamesLabel.mas_bottom).offset(16);
        make.left.mas_equalTo(self.contentView.mas_left).offset(24);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-16);
        make.width.mas_equalTo(self.contentView).multipliedBy(0.7);
        make.height.mas_equalTo(180);
    }];
    [self.flagIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.flagView);
    }];
}

- (void)layoutFlagView {
    CGSize contentSize = self.flagView.scrollView.contentSize;
    CGSize webViewSize = self.flagView.bounds.size;
    CGFloat scaleFactor = webViewSize.width / contentSize.width;
    
    self.flagView.scrollView.minimumZoomScale = scaleFactor;
    self.flagView.scrollView.maximumZoomScale = scaleFactor;
    self.flagView.scrollView.zoomScale = scaleFactor;
    
    [self.flagView.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

#pragma mark - Gestures

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (void)didTapFlagView {
    [self.didTapFlagSubject sendNext:nil];
}

- (void)dealloc {
    [self.flagView stopLoading];
    self.flagView.delegate = nil;
}

@end
