//
//  CountriesListPresenter.h
//  Countries
//
//  Created by John Raymund Catahay on 20/05/2017.
//  Copyright © 2017 John Raymund Catahay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "Country.h"

@protocol CountriesListInput <NSObject>

- (void)viewDidLoad;
- (void)setSelectedCategory: (CountryCategory)category;
- (void)selectedCountry: (Country *) country;
- (void)requestRefreshData;

@property (nonatomic, strong, readonly) RACSubject *countriesCategoriesSubject;
@property (nonatomic, strong, readonly) RACSubject *countriesSubject;
@property (nonatomic, strong, readonly) RACSubject *selectedCountrySubject;

@end

@interface CountriesListPresenter : NSObject <CountriesListInput>

@end
