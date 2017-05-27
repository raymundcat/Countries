//
//  CountryDetailTableViewCell.h
//  Countries
//
//  Created by John Raymund Catahay on 27/05/2017.
//  Copyright © 2017 John Raymund Catahay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Country.h"

@interface CountryDetailTableViewCell : UITableViewCell

@property (nonatomic, strong, readonly) UILabel *detailLabel;
@property (nonatomic, strong, readonly) UILabel *detailValueLabel;

@end
