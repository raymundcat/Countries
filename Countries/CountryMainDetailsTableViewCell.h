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

@property (strong, nonatomic) Country *country;
@property (strong, nonatomic) RACSubject *didTapFlagSubject;

@end
