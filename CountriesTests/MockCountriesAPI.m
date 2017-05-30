//
//  MockCountriesAPI.m
//  Countries
//
//  Created by John Raymund Catahay on 31/05/2017.
//  Copyright © 2017 John Raymund Catahay. All rights reserved.
//

#import "MockCountriesAPI.h"
#import "Country.h"
#import "MockCountries.h"

@interface MockCountriesAPI ()

@property (strong, nonatomic) NSArray<Country *> *mockCountries;

@end

@implementation MockCountriesAPI

-(NSArray<Country *> *)mockCountries {
    if (!_mockCountries) {
        _mockCountries = @[[MockCountries mockedColombia],
                           [MockCountries mockedPhilippines],
                           [MockCountries mockedSweden]];
    }
    return _mockCountries;
}


- (void)fetchCountriesSummariesWithCompletion: (void (^)(NSArray<Country *> *countriesArray))completion {
    completion(self.mockCountries);
}

- (void)searchCountriesWithName: (NSString *)searchText WithCompletion: (void (^)(NSArray<Country *> *countriesArray))completion {
     completion(self.mockCountries);
}

@end
