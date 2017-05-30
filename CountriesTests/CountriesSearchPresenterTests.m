//
//  CountriesSearchPresenterTests.m
//  Countries
//
//  Created by John Raymund Catahay on 31/05/2017.
//  Copyright © 2017 John Raymund Catahay. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MockCountries.h"
#import "MockCountriesAPI.h"
#import "CountriesSearchPresenter.h"

@interface CountriesSearchPresenterTests : XCTestCase

@property (strong, nonatomic) CountriesSearchPresenter *presenter;
@property (strong, nonatomic) MockCountriesAPI *countriesAPI;

@end

@implementation CountriesSearchPresenterTests

-(CountriesSearchPresenter *)presenter {
    if (!_presenter) {
        _presenter = [[CountriesSearchPresenter alloc]
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

//Tests whether or not the presenter
//actually reflects the actual response
//of the api
- (void)testPresenterSearchResponse {
    XCTestExpectation *expectation = [self expectationWithDescription:@"asynchronous request"];
    [self.presenter.countriesSubject subscribeNext:^(NSArray<Country *> *countries) {
        XCTAssertEqual(countries.count, 3);
        [expectation fulfill];
    }];
    [self.presenter.searchTextSubject sendNext:@"mock search"];
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
    [self.presenter.searchTextSubject sendNext:@"mock search"];
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

@end
