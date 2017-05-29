//
//  CountriesSearchInput.h
//  Countries
//
//  Created by John Raymund Catahay on 30/05/2017.
//  Copyright © 2017 John Raymund Catahay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Country.h"
#import "CountriesAPIProtocol.h"

@protocol CountriesSearchInput <NSObject>

@property (nonatomic, strong, readonly) RACSubject *searchTextSubject;
@property (nonatomic, strong, readonly) RACSubject *countriesSubject;
@property (nonatomic, strong, readonly) RACSubject *selectedCountrySubject;

- (instancetype)initWithCountriesAPI: (id<CountriesAPIProtocol>)countriesAPI;
- (void)didSelectCountry: (Country *)country;

@end
