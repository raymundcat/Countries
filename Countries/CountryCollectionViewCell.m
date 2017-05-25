//
//  CountryCollectionViewCell.m
//  Countries
//
//  Created by John Raymund Catahay on 21/05/2017.
//  Copyright © 2017 John Raymund Catahay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CountryCollectionViewCell.h"
#import "UIColor+Countries.h"
#import "Masonry.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Geognos.h"
#import <SVGgh/SVGgh.h>

@interface CountryCollectionViewCell ()

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIVisualEffectView *blurView;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation CountryCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.shadowRadius = 2;
        self.layer.shadowColor = UIColor.darkGrayColor.CGColor;
        self.layer.shadowOpacity = 0.4;
        self.layer.shadowOffset = CGSizeZero;
        self.backgroundColor = UIColor.peachColor;
        
        [self addSubview: self.imageView];
        [self addSubview: self.blurView];
        [self.blurView addSubview: self.title];
    }
    return self;
}

- (void)setCountry:(Country *)country {
    _country = country;
    self.title.text = country.name;
    [self.imageView sd_setImageWithURL: [Geognos flagURLfor: country.alpha2Code]
                      placeholderImage: [UIImage imageNamed:@"avatar-placeholder.png"]
                               options: SDWebImageRefreshCached];
}

- (UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] initWithFrame:CGRectZero];
        _title.textColor = UIColor.whiteColor;
        _title.numberOfLines = 0;
        _title.font = [UIFont systemFontOfSize:15];
    }
    return _title;
}

-(UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.backgroundColor = UIColor.grayColor;
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}

-(UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.delegate = self;
        _webView.scalesPageToFit = NO;
        _webView.scrollView.scrollEnabled = NO;
        _webView.suppressesIncrementalRendering = YES;
    }
    return _webView;
}

-(UIVisualEffectView *)blurView {
    if (!_blurView) {
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _blurView = [[UIVisualEffectView alloc] initWithEffect: effect];
        _blurView.clipsToBounds = YES;
    }
    return _blurView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    [self.blurView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.height.mas_lessThanOrEqualTo(self.mas_height);
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.blurView.mas_top).offset(8);
        make.left.mas_equalTo(self.blurView.mas_left).offset(8);
        make.bottom.mas_equalTo(self.blurView.mas_bottom).offset(-8);
        make.right.mas_equalTo(self.blurView.mas_right).offset(-8);
    }];
}

@end
