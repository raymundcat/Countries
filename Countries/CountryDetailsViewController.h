//
//  CountryDetailsViewController.h
//  Countries
//
//  Created by John Raymund Catahay on 27/05/2017.
//  Copyright © 2017 John Raymund Catahay. All rights reserved.
//

#import "BaseViewController.h"
#import "Country.h"

@interface CountryDetailsViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) Country *country;
@property (strong, nonatomic) RACSubject *didPressFlagSubject;

@end
