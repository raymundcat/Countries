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

@property (nonatomic, strong, readwrite) UILabel *detailLabel;
@property (nonatomic, strong, readwrite) UILabel *detailValueLabel;
@property (strong, nonatomic) UIView *containerView;

@end

@implementation CountryDetailTableViewCell

#pragma mark - Private Subviews

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:CGRectZero];
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
        _detailLabel.text = @"";
    }
    return _detailLabel;
}

-(UILabel *)detailValueLabel {
    if (!_detailValueLabel) {
        _detailValueLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _detailValueLabel.numberOfLines = 0;
        _detailValueLabel.font = [UIFont systemFontOfSize:17];
        _detailValueLabel.textColor = UIColor.darkBlueGreenColor;
        _detailValueLabel.textAlignment = NSTextAlignmentRight;
        _detailValueLabel.text = @"";
    }
    return _detailValueLabel;
}

#pragma mark - Lifecycle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = UIColor.clearColor;
        
        [self.contentView addSubview:self.containerView];
        [self.contentView addSubview: self.countryDetailLabel];
        [self.contentView addSubview: self.detailValueLabel];
        [self initLayout];
    }
    return self;
}

- (void)initLayout {
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
        make.width.mas_lessThanOrEqualTo(self.contentView).multipliedBy(0.45);
    }];
    [self.detailValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(16);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-24);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-16);
        make.width.mas_lessThanOrEqualTo(self.contentView).multipliedBy(0.45);
    }];
}

@end
