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

@property (strong, nonatomic) NSArray<Country *> *countries;
@property (nonatomic) CountryCategory selectedCategory;
@property (strong, nonatomic) id<CountriesAPIProtocol> countriesAPI;

@property (nonatomic, strong, readwrite) RACSubject *countriesCategoriesSubject;
@property (nonatomic, strong, readwrite) RACSubject *countriesSubject;
@property (nonatomic, strong, readwrite) RACSubject *selectedCountrySubject;

@end

@implementation CountriesListPresenter

@synthesize countries = _countries;
@synthesize selectedCategory = _selectedCategory;

#pragma mark - Private

- (CountryCategory)selectedCategory {
    if (!_selectedCategory) {
        _selectedCategory = CountryCategorySubRegion;
    }
    return _selectedCategory;
}

- (NSArray<Country *> *)countries {
    if (!_countries) {
        _countries = [[NSArray alloc] init];
    }
    return _countries;
}

- (void)setCountries:(NSArray<Country *> *)countries {
    _countries = countries;
    [self updateDataWithCategory: self.selectedCategory];
}

#pragma mark - Public

- (void)viewDidLoad {
    [self fetchCountries];
}

- (void)requestRefreshData {
    [self fetchCountries];
}

- (void)setSelectedCategory:(CountryCategory)category {
    _selectedCategory = category;
    [self updateDataWithCategory: category];
}

- (void)didSelectCountry:(Country *)country {
    [self.selectedCountrySubject sendNext:country];
}

-(RACSubject *)selectedCountrySubject {
    if (!_selectedCountrySubject) {
        _selectedCountrySubject = [RACSubject subject];
    }
    return _selectedCountrySubject;
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

#pragma mark - Lifecycle

- (instancetype)initWithCountriesAPI: (id<CountriesAPIProtocol>)countriesAPI {
    self = [super init];
    if (self) {
        self.countriesAPI = countriesAPI;
    }
    return self;
}

#pragma mark - API calls

- (void)fetchCountries {
    @weakify(self)
    [self.countriesAPI fetchCountriesSummariesWithCompletion:^(NSArray<Country *> *countries) {
        @strongify(self)
        self.countries = [countries copy];
    }];
}


#pragma mark - Data Processing

//this function prepares two sets of objects
//1. A set of strings that represents all values
//available for the category
//2. A set of Countries that conforms to the created values

-(void)updateDataWithCategory: (CountryCategory)category {
    
    //depending on the category, combines all values
    //from the countries into a single set
    NSMutableArray<NSString *> *categories = [[NSMutableArray alloc] init];
    for (Country *country in self.countries) {
        [categories addObjectsFromArray: [country valuesForCategory:category]];
    }
    NSOrderedSet *orderedSet = [NSOrderedSet orderedSetWithArray:categories];
    [self.countriesCategoriesSubject sendNext:[orderedSet array]];
    
    //creates multiple sets of Countries depending on
    //the categories available
    NSMutableArray<NSArray<Country *> *> *countriesSet = [[NSMutableArray alloc] init];
    for (NSString *categoryValue in orderedSet) {
        [countriesSet addObject: [self.countries objectsAtIndexes: [self.countries indexesOfObjectsPassingTest:^BOOL(Country * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            return [[obj valuesForCategory:category] containsObject:categoryValue];
        }]]];
    }
    [self.countriesSubject sendNext:countriesSet];
}

@end
