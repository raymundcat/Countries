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
#import "NSArray+Map.h"

@interface CountriesListPresenter ()

@property (nonatomic, strong) NSArray<Country *> *countries;
@property (nonatomic) CountryCategory selectedCategory;
@property (nonatomic, strong, readwrite) RACSubject *countriesCategoriesSubject;
@property (nonatomic, strong, readwrite) RACSubject *countriesSubject;
@property (nonatomic, strong) CountriesListAPI *countriesAPI;

@end

@implementation CountriesListPresenter

@synthesize countries = _countries;
@synthesize selectedCategory = _selectedCategory;

- (void)viewDidLoad {
    [self fetchCountries];
}

- (void)requestRefreshData {
    [self fetchCountries];
}

-(CountryCategory)selectedCategory {
    if (!_selectedCategory) {
        _selectedCategory = CountryCategorySubRegion;
    }
    return _selectedCategory;
}

- (void)setSelectedCategory:(CountryCategory)category {
    _selectedCategory = category;
    [self updateDataWithCategory: category];
}

-(NSArray<Country *> *)countries {
    if (!_countries) {
        _countries = [[NSArray alloc] init];
    }
    return _countries;
}

-(void)setCountries:(NSArray<Country *> *)countries {
    _countries = countries;
    [self updateDataWithCategory: self.selectedCategory];
}

-(void)updateDataWithCategory: (CountryCategory)category {
    
    NSArray<NSString *> *categories = [self.countries mapObjectsUsingBlock:^NSString *(Country *country, NSUInteger idx) {
        return [country valueForCategory:category];
    }];
    NSOrderedSet *orderedSet = [NSOrderedSet orderedSetWithArray:categories];
    [self.countriesCategoriesSubject sendNext:[orderedSet array]];
    
    NSMutableArray<NSArray<Country *> *> *countriesSet = [[NSMutableArray alloc] init];
    for (NSString *categoryValue in orderedSet) {
        [countriesSet addObject: [self.countries objectsAtIndexes: [self.countries indexesOfObjectsPassingTest:^BOOL(Country * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            return [[obj valueForCategory:category] isEqualToString:categoryValue];
        }]]];
    }
    [self.countriesSubject sendNext:countriesSet];
}

- (CountriesListAPI *)countriesAPI {
    if (!_countriesAPI) {
        _countriesAPI = [[CountriesListAPI alloc] init];
    }
    return _countriesAPI;
}

- (RACSubject *)countriesCategoriesSubject {
    if (!_countriesCategoriesSubject) {
        _countriesCategoriesSubject = [RACSubject subject];
    }
    return _countriesCategoriesSubject;
}

- (RACSubject *)countriesSubject {
    if (!_countriesSubject) {
        _countriesSubject = [RACSubject subject];
    }
    return _countriesSubject;
}

- (void)fetchCountries {
    @weakify(self)
    [self.countriesAPI fetchCountriesSummariesWithCompletion:^(NSArray<Country *> *countries) {
        @strongify(self)
        self.countries = [countries copy];
    }];
}

@end
