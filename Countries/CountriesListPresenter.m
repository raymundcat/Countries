//
//  CountriesListPresenter.m
//  Countries
//
//  Created by John Raymund Catahay on 20/05/2017.
//  Copyright © 2017 John Raymund Catahay. All rights reserved.
//

#import "CountriesListPresenter.h"
#import "CountriesListAPI.h"
#import "RACEXTScope.h"

@interface CountriesListPresenter ()

@property (nonatomic, strong, readwrite) RACSubject *countriesSubject;
@property (nonatomic, strong) CountriesListAPI *countriesAPI;

@end

@implementation CountriesListPresenter

- (void)viewDidLoad {
    [self fetchCountries];
}

- (CountriesListAPI *)countriesAPI {
    if (!_countriesAPI) {
        _countriesAPI = [[CountriesListAPI alloc] init];
    }
    return _countriesAPI;
}

- (RACSubject *)countriesSubject {
    if (!_countriesSubject) {
        _countriesSubject = [RACSubject subject];
    }
    return _countriesSubject;
}

- (void)fetchCountries {
    [self.countriesAPI fetchCountriesSummariesWithCompletion:^(NSArray<Country *> *countries) {
        [self.countriesSubject sendNext:countries];
    }];
}

@end
