//
//  Country.m
//  Countries
//
//  Created by John Raymund Catahay on 20/05/2017.
//  Copyright © 2017 John Raymund Catahay. All rights reserved.
//

#import "Country.h"

@interface Country ()

@property (nonatomic, strong, readwrite) NSString *alpha2Code;
@property (nonatomic, strong, readwrite) NSString *alpha3Code;
@property (nonatomic, strong, readwrite) NSString *numericCode;
@property (nonatomic, strong, readwrite) NSString *name;
@property (nonatomic, strong, readwrite) NSString *nativeName;
@property (nonatomic, strong, readwrite) NSString *capital;
@property (nonatomic, strong, readwrite) NSString *region;
@property (nonatomic, strong, readwrite) NSString *subRegion;
@property (nonatomic, strong, readwrite) NSString *flag;
@property (nonatomic, strong, readwrite) NSMutableArray<NSString *> *regionalBlocks;

@end

@implementation Country

+ (Country *)fromJSON: (NSDictionary *)json {
    Country *country = [[Country alloc] init];
    country.alpha2Code = [json objectForKey:@"alpha2Code"];
    country.alpha3Code = [json objectForKey:@"alpha3Code"];
    country.name = [json objectForKey:@"name"];
    country.numericCode = [json objectForKey:@"numericCode"];
    country.region = [json objectForKey:@"region"];
    country.subRegion = [json objectForKey:@"subregion"];
    country.flag = [json objectForKey:@"flag"];
    
    country.regionalBlocks = [[NSMutableArray alloc] init];
    if ([[json objectForKey:@"regionalBlocs"] isKindOfClass:[NSArray<NSDictionary *> class]]) {
        NSArray<NSDictionary *> *blocs = (NSArray<NSDictionary *> *)[json objectForKey:@"regionalBlocs"];
        for (NSDictionary *blocDict in blocs) {
            [country.regionalBlocks addObject:[blocDict objectForKey:@"name"]];
        }
    }
    
    return country;
}

- (NSArray<NSString *> *)valuesForCategory: (CountryCategory)category{
    switch (category) {
        case CountryCategoryAll:
            return @[@"All"];
        case CountryCategoryRegion:
            return [self.region length] > 0 ? @[self.region] : @[@"None"];
        case CountryCategorySubRegion:
            return [self.subRegion length] > 0 ? @[self.subRegion] : @[@"None"];
        case CountryCategoryRegionalBlock:
            return [self.regionalBlocks count] > 0 ? self.regionalBlocks : @[@"None"];
    }
}

@end
