//
//  CountriesListPresenterTests.m
//  Countries
//
//  Created by John Raymund Catahay on 31/05/2017.
//  Copyright © 2017 John Raymund Catahay. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CountriesListPresenter.h"
#import "MockCountries.h"
#import "MockCountriesAPI.h"

@interface CountriesListPresenterTests : XCTestCase

@property (strong, nonatomic) CountriesListPresenter *presenter;
@property (strong, nonatomic) MockCountriesAPI *countriesAPI;

@end

@implementation CountriesListPresenterTests

-(CountriesListPresenter *)presenter {
    if (!_presenter) {
        _presenter = [[CountriesListPresenter alloc]
                      initWithCountriesAPI:self.countriesAPI];
    }
    return _presenter;
}

-(MockCountriesAPI *)countriesAPI {
    if (!_countriesAPI) {
        _countriesAPI = [[MockCountriesAPI alloc] init];
    }
    return _countriesAPI;
}

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

//Test that the list presenter returns
//the expected set of countries.
- (void)testCountriesReturned {
    XCTestExpectation *expectation = [self expectationWithDescription:@"asynchronous request"];
    [self.presenter.countriesSubject subscribeNext:^(NSArray<Country *> *countries) {
        XCTAssertEqual(countries.count, 3);
        [expectation fulfill];
    }];
    [self.presenter viewDidLoad];
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

//Test that the list presenter returns
//the expected set of categories.
- (void)testCategoriesReturned {
    XCTestExpectation *expectation = [self expectationWithDescription:@"asynchronous request"];
    [self.presenter viewDidLoad];
    [self.presenter.countriesCategoriesSubject subscribeNext:^(NSArray<NSString *> *categories) {
        XCTAssertEqual(categories.count, 3);
        XCTAssertTrue([categories containsObject:@"Northern Europe"]);
        XCTAssertTrue([categories containsObject:@"South-Eastern Asia"]);
        XCTAssertTrue([categories containsObject:@"South America"]);
        [expectation fulfill];
    }];
    [self.presenter setSelectedCategory:CountryCategorySubRegion];
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

//Tests to see of presenter responds
//to tap inputs
- (void)testPresenterTapResponse {
    __block Country *selectedCountry = nil;
    XCTestExpectation *expectation = [self expectationWithDescription:@"asynchronous request"];
    [self.presenter.selectedCountrySubject subscribeNext:^(Country *country) {
        XCTAssertNotNil(selectedCountry);
        XCTAssertEqual(country, selectedCountry);
        [expectation fulfill];
    }];
    [self.presenter.countriesSubject subscribeNext:^(NSArray<Country *> *countries) {
        selectedCountry = countries[0];
        [self.presenter didSelectCountry: selectedCountry];
    }];
    [self.presenter viewDidLoad];
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

@end
