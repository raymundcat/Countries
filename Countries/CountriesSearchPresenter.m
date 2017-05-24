//
//  CountriesSerachPresenter.m
//  Countries
//
//  Created by John Raymund Catahay on 22/05/2017.
//  Copyright © 2017 John Raymund Catahay. All rights reserved.
//

#import "CountriesSearchPresenter.h"
#import "CountriesListAPI.h"

@interface CountriesSearchPresenter ()

@property (nonatomic, strong) CountriesListAPI *countriesAPI;

@end

@implementation CountriesSearchPresenter

@synthesize searchTextSubject = _searchTextSubject;
@synthesize countriesSubject = _countriesSubject;

-(void)viewDidLoad {
    
}

- (RACSubject *)searchTextSubject {
    if (!_searchTextSubject) {
        _searchTextSubject = [RACSubject subject];
    }
    return _searchTextSubject;
}

-(RACSubject *)countriesSubject {
    if (!_countriesSubject) {
        _countriesSubject = [RACSubject subject];
    }
    return _countriesSubject;
}

- (CountriesListAPI *)countriesAPI {
    if (!_countriesAPI) {
        _countriesAPI = [[CountriesListAPI alloc] init];
    }
    return _countriesAPI;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[self.searchTextSubject throttle:0.5]
         subscribeNext:^(NSString *x) {
             [self searchCountriesWithText:x];
        }];
    }
    return self;
}

- (void)searchCountriesWithText: (NSString *)searchText {
    [self.countriesAPI searchCountriesWithName: searchText
                                WithCompletion:^(NSArray<Country *> *countriesArray) {
                                    [self.countriesSubject sendNext:countriesArray];
                                }];
}

@end
