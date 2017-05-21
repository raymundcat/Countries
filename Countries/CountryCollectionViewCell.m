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

@interface CountryCollectionViewCell ()

@property (nonatomic, strong) UIVisualEffectView *blurView;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation CountryCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.shadowRadius = 2;
        self.layer.shadowColor = UIColor.blackColor.CGColor;
        self.layer.shadowOpacity = 0.4;
        self.layer.shadowOffset = CGSizeZero;
        self.backgroundColor = UIColor.peachColor;
        
        [self addSubview: self.imageView];
        [self addSubview: self.blurView];
    }
    return self;
}

-(UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.backgroundColor = UIColor.grayColor;
        _imageView.image = [UIImage imageNamed:@"PuertoRico"];
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}

-(UIVisualEffectView *)blurView {
    if (!_blurView) {
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _blurView = [[UIVisualEffectView alloc] initWithEffect: effect];
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
        make.height.mas_equalTo(45);
    }];
}

@end
