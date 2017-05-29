//
//  CountriesCollectionHeaderView.m
//  Countries
//
//  Created by John Raymund Catahay on 23/05/2017.
//  Copyright © 2017 John Raymund Catahay. All rights reserved.
//

#import "CountriesCollectionHeaderView.h"
#import "UIColor+Countries.h"
#import "Masonry.h"

@interface CountriesCollectionHeaderView ()

@property (nonatomic, strong, readwrite) UILabel *titleLabel;
@property (nonatomic, strong, readwrite) UIButton *dropDownButton;

@end

@implementation CountriesCollectionHeaderView

#pragma mark - Private Subviews

-(UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = UIColor.whiteColor;
        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _titleLabel.numberOfLines = 0;
        _titleLabel.text = @"Title";
    }
    return _titleLabel;
}

#pragma mark - Public

- (UIButton *)dropDownButton {
    if (!_dropDownButton) {
        _dropDownButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_dropDownButton setTitle:@"▼" forState:UIControlStateNormal];
        [_dropDownButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    }
    return _dropDownButton;
}

- (void)setCategoryName:(NSString *)categoryName {
    _categoryName = categoryName;
    self.titleLabel.text = categoryName;
}

#pragma mark - Lifecycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.shadowRadius = 2;
        self.layer.shadowColor = UIColor.grayColor.CGColor;
        self.layer.shadowOpacity = 0.9;
        self.layer.shadowOffset = CGSizeZero;
        [self addSubview:self.titleLabel];
        [self addSubview:self.dropDownButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).mas_offset(12);
        make.centerY.mas_equalTo(self);
    }];
    [self.dropDownButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_right);
        make.right.mas_lessThanOrEqualTo(self.mas_right).mas_offset(12);
        make.width.mas_equalTo(50);
        make.centerY.mas_equalTo(self.titleLabel);
    }];
}

@end
