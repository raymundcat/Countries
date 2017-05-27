//
//  CountryDetailTableViewCell.m
//  Countries
//
//  Created by John Raymund Catahay on 27/05/2017.
//  Copyright © 2017 John Raymund Catahay. All rights reserved.
//

#import "CountryDetailTableViewCell.h"
#import "UIColor+Countries.h"
#import <Masonry/Masonry.h>

@interface CountryDetailTableViewCell()

@property (nonatomic, strong) UILabel *countryDetailLabel;
@property (nonatomic, strong) UILabel *detailValueLabel;

@end

@implementation CountryDetailTableViewCell

-(UILabel *)countryDetailLabel {
    if (!_countryDetailLabel) {
        _countryDetailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _countryDetailLabel.numberOfLines = 0;
        _countryDetailLabel.font = [UIFont systemFontOfSize:15];
        _countryDetailLabel.textColor = UIColor.whiteColor;
        _countryDetailLabel.layer.shadowRadius = 2;
        _countryDetailLabel.layer.shadowColor = UIColor.grayColor.CGColor;
        _countryDetailLabel.layer.shadowOpacity = 0.9;
        _countryDetailLabel.layer.shadowOffset = CGSizeZero;
        _countryDetailLabel.text = @"lorem lorem lorem";
        _countryDetailLabel.backgroundColor = UIColor.redColor;
    }
    return _countryDetailLabel;
}

-(UILabel *)detailValueLabel {
    if (!_detailValueLabel) {
        _detailValueLabel = [[UILabel alloc] init];
        _detailValueLabel.text = @"lorem lorem lorem lorem lorem lorem lorem";
        _detailValueLabel.numberOfLines = 0;
    }
    return _detailValueLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.layer.shadowRadius = 3;
        self.layer.shadowColor = UIColor.darkBlueGreenColor.CGColor;
        self.layer.shadowOpacity = 0.9;
        self.layer.shadowOffset = CGSizeZero;
        self.backgroundColor = UIColor.yellowColor;
        
        [self.contentView addSubview: self.countryDetailLabel];
        [self.contentView addSubview: self.detailValueLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.countryDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(16);
        make.left.mas_equalTo(self.contentView.mas_left).offset(16);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-16);
        make.width.mas_lessThanOrEqualTo(self.contentView).multipliedBy(0.4);
    }];
}

@end
