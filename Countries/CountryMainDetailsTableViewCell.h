//
//  CountryMainDetailsTableViewCell.h
//  Countries
//
//  Created by John Raymund Catahay on 27/05/2017.
//  Copyright © 2017 John Raymund Catahay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Country.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface CountryMainDetailsTableViewCell : UITableViewCell<UIWebViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) Country *country;
@property (nonatomic, strong) RACSubject *didTapFlagSubject;

@end
