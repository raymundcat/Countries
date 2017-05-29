//
//  CountriesAPIProtocol.h
//  Countries
//
//  Created by John Raymund Catahay on 30/05/2017.
//  Copyright © 2017 John Raymund Catahay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Country.h"

@protocol CountriesAPIProtocol <NSObject>

- (void)fetchCountriesSummariesWithCompletion: (void (^)(NSArray<Country *> *countriesArray))completion;
- (void)searchCountriesWithName: (NSString *)searchText WithCompletion: (void (^)(NSArray<Country *> *countriesArray))completion;

@end
