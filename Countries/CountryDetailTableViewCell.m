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

@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UILabel *detailValueLabel;
@property (nonatomic, strong) UIView *containerView;

@end

@implementation CountryDetailTableViewCell

@synthesize country = _country;

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = UIColor.whiteColor;
        _containerView.layer.cornerRadius = 3;
        _containerView.layer.shadowColor = UIColor.grayColor.CGColor;
        _containerView.layer.shadowOpacity = 0.9;
        _containerView.layer.shadowOffset = CGSizeZero;
    }
    return _containerView;
}

-(UILabel *)countryDetailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _detailLabel.numberOfLines = 0;
        _detailLabel.font = [UIFont systemFontOfSize:17];
        _detailLabel.textColor = UIColor.darkBlueGreenColor;
        _detailLabel.text = @"lorem lorem lorem";
    }
    return _detailLabel;
}

-(UILabel *)detailValueLabel {
    if (!_detailValueLabel) {
        _detailValueLabel = [[UILabel alloc] init];
        _detailValueLabel.numberOfLines = 0;
        _detailValueLabel.font = [UIFont systemFontOfSize:17];
        _detailValueLabel.textColor = UIColor.darkBlueGreenColor;
        _detailValueLabel.textAlignment = NSTextAlignmentRight;
        _detailValueLabel.text = @"lorem lorem lorem lorem lorem lorem lorem";
    }
    return _detailValueLabel;
}

-(void)setCountry:(Country *)country {
    _country = country;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = UIColor.clearColor;
        
        [self.contentView addSubview:self.containerView];
        [self.contentView addSubview: self.countryDetailLabel];
        [self.contentView addSubview: self.detailValueLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(4);
        make.left.mas_equalTo(self.contentView.mas_left).offset(8);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-4);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-8);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(16);
        make.left.mas_equalTo(self.contentView.mas_left).offset(24);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-16);
        make.width.mas_lessThanOrEqualTo(self.contentView).multipliedBy(0.4);
    }];
    [self.detailValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(16);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-24);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-16);
        make.width.mas_lessThanOrEqualTo(self.contentView).multipliedBy(0.4);
    }];
}

@end
