//
//  CountryTests.m
//  Countries
//
//  Created by John Raymund Catahay on 31/05/2017.
//  Copyright © 2017 John Raymund Catahay. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Country.h"
#import "MockCountries.h"

@interface CountryTests : XCTestCase

@end

@implementation CountryTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

//Tests the Dictionary -> Country
//decoding done in the Country.m
//using the mocked data from API
- (void)testDecodedColombia {
    Country *colombia = [MockCountries mockedColombia];
    XCTAssertTrue([colombia.name isEqualToString:@"Colombia"]);
    XCTAssertTrue([colombia.nativeName isEqualToString:@"Colombia"]);
    XCTAssertTrue([colombia.alpha2Code isEqualToString:@"CO"]);
    XCTAssertTrue([colombia.capital isEqualToString:@"Bogotá"]);
    XCTAssertTrue([colombia.region isEqualToString:@"Americas"]);
    XCTAssertTrue([colombia.subRegion isEqualToString:@"South America"]);
    XCTAssertTrue([colombia.demonym isEqualToString:@"Colombian"]);
    XCTAssertTrue([colombia.numericCode isEqualToString:@"170"]);
    XCTAssertTrue([colombia.flag isEqualToString:@"https://restcountries.eu/data/col.svg"]);
    
    XCTAssertTrue([colombia.borders containsObject:@"BRA"]);
    XCTAssertTrue([colombia.borders containsObject:@"ECU"]);
    XCTAssertTrue([colombia.borders containsObject:@"PAN"]);
    XCTAssertTrue([colombia.borders containsObject:@"PER"]);
    XCTAssertTrue([colombia.borders containsObject:@"VEN"]);
    
    XCTAssertTrue([colombia.regionalBlocs containsObject:@"Pacific Alliance"]);
    XCTAssertTrue([colombia.regionalBlocs containsObject:@"Union of South American Nations"]);
}

//Test the categories fetched
//from Colombia
- (void)testCategoriesOfColombia {
    Country *colombia = [MockCountries mockedColombia];
    XCTAssertTrue([[colombia valuesForCategory:CountryCategoryAll] isEqualToArray:@[@"All"]]);
    XCTAssertTrue([[colombia valuesForCategory:CountryCategoryRegion] containsObject:@"Americas"]);
    XCTAssertTrue([[colombia valuesForCategory:CountryCategorySubRegion] containsObject:@"South America"]);
    XCTAssertTrue([[colombia valuesForCategory:CountryCategoryRegionalBloc] containsObject:@"Pacific Alliance"]);
    XCTAssertTrue([[colombia valuesForCategory:CountryCategoryRegionalBloc] containsObject:@"Union of South American Nations"]);
}

@end
