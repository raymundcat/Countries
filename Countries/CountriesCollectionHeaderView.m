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

@property (nonatomic, strong) UILabel *title;

@end

@implementation CountriesCollectionHeaderView

-(UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.textColor = UIColor.peachColor;
        _title.font = [UIFont boldSystemFontOfSize:18];
        _title.text = @"Title";
    }
    return _title;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.title];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).mas_offset(12);
        make.centerY.mas_equalTo(self);
    }];
}

- (void)setCategoryName:(NSString *)categoryName {
    _categoryName = categoryName;
    self.title.text = categoryName;
}

@end
