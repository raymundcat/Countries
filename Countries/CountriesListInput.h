//
//  CountriesListInput.h
//  Countries
//
//  Created by John Raymund Catahay on 30/05/2017.
//  Copyright © 2017 John Raymund Catahay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Country.h"

@protocol CountriesListInput <NSObject>

- (void)viewDidLoad;
- (void)setSelectedCategory: (CountryCategory)category;
- (void)didSelectCountry: (Country *) country;
- (void)requestRefreshData;

@property (nonatomic, strong, readonly) RACSubject *countriesCategoriesSubject;
@property (nonatomic, strong, readonly) RACSubject *countriesSubject;
@property (nonatomic, strong, readonly) RACSubject *selectedCountrySubject;

@end
