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
@property (nonatomic, strong, readwrite) NSMutableArray<NSString *> *otherNames;
@property (nonatomic, strong, readwrite) NSString *capital;
@property (nonatomic, strong, readwrite) NSString *region;
@property (nonatomic, strong, readwrite) NSString *subRegion;
@property (nonatomic, strong, readwrite) NSString *flag;
@property (nonatomic, strong, readwrite) NSString *demonym;
@property (nonatomic, strong, readwrite) NSMutableArray<NSString *> *regionalBlocks;
@property (nonatomic, strong, readwrite) NSNumber *population;
@property (nonatomic, strong, readwrite) NSMutableArray<NSString *> *languages;
@property (nonatomic, strong, readwrite) NSMutableArray<NSString *> *currencies;
@property (nonatomic, strong, readwrite) NSMutableArray<NSString *> *timeZones;
@property (nonatomic, strong, readwrite) NSMutableArray<NSString *> *borders;

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
    country.nativeName = [json objectForKey:@"nativeName"];
    country.demonym = [json objectForKey:@"demonym"];
    country.capital = [json objectForKey:@"capital"];
    country.population = [NSNumber numberWithInteger:[[json objectForKey:@"population"] integerValue]];
    
    country.regionalBlocks = [[NSMutableArray alloc] init];
    if ([[json objectForKey:@"regionalBlocs"] isKindOfClass:[NSArray<NSDictionary *> class]]) {
        NSArray<NSDictionary *> *blocs = (NSArray<NSDictionary *> *)[json objectForKey:@"regionalBlocs"];
        for (NSDictionary *blocDict in blocs) {
            [country.regionalBlocks addObject:[blocDict objectForKey:@"name"]];
        }
    }
    
    country.otherNames = [[NSMutableArray alloc] init];
    if ([[json objectForKey:@"altSpellings"] isKindOfClass:[NSArray<NSString *> class]]) {
        NSArray<NSString *> *names = (NSArray<NSString *> *)[json objectForKey:@"altSpellings"];
        for (NSString *name in names) {
            [country.otherNames addObject:name];
        }
    }
    
    country.languages = [[NSMutableArray alloc] init];
    if ([[json objectForKey:@"languages"] isKindOfClass:[NSArray<NSDictionary *> class]]) {
        NSArray<NSDictionary *> *languages = (NSArray<NSDictionary *> *)[json objectForKey:@"languages"];
        for (NSDictionary *languageDict in languages) {
            [country.languages addObject:[languageDict objectForKey:@"name"]];
        }
    }
    
    country.currencies = [[NSMutableArray alloc] init];
    if ([[json objectForKey:@"currencies"] isKindOfClass:[NSArray<NSDictionary *> class]]) {
        NSArray<NSDictionary *> *currencies = (NSArray<NSDictionary *> *)[json objectForKey:@"currencies"];
        for (NSDictionary *currencyDict in currencies) {
            [country.currencies addObject:[currencyDict objectForKey:@"name"]];
        }
    }
    
    country.timeZones = [[NSMutableArray alloc] init];
    if ([[json objectForKey:@"timezones"] isKindOfClass:[NSArray<NSString *> class]]) {
        NSArray<NSString *> *timezones = (NSArray<NSString *> *)[json objectForKey:@"timezones"];
        for (NSString *timezone in timezones) {
            [country.timeZones addObject:timezone];
        }
    }
    
    country.borders = [[NSMutableArray alloc] init];
    if ([[json objectForKey:@"borders"] isKindOfClass:[NSArray<NSString *> class]]) {
        NSArray<NSString *> *borders = (NSArray<NSString *> *)[json objectForKey:@"borders"];
        for (NSString *border in borders) {
            [country.borders addObject:border];
        }
    }
    
    return country;
}

- (NSArray<NSString *> *)valuesForCategory: (CountryCategory)category {
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

+ (NSString *)readableNameOfDetailType: (CountryDetailType)detailType {
    switch (detailType) {
        case CountryDetailTypeNativeName:
            return @"Native Name";
        case CountryDetailTypeDemonym:
            return @"Demonym";
        case CountryDetailTypeCapital:
            return @"Capital";
        case CountryDetailTypePopulation:
            return @"Population";
        case CountryDetailTypeLanguages:
            return @"Languages";
        case CountryDetailTypeCurrencies:
            return @"Currencies";
        case CountryDetailTypeTimezone:
            return @"Timezones";
        case CountryDetailTypeRegion:
            return @"Region";
        case CountryDetailTypeSubRegion:
            return @"Subregion";
        case CountryDetailTypeBorders:
            return @"Borders";
        case CountryDetailTypeRegionalBlocks:
            return @"Regional Blocks";
    }
}

- (NSArray<NSString *> *)valuesForDetail: (CountryDetailType)detailType {
    switch (detailType) {
        case CountryDetailTypeNativeName:
            return [self.nativeName length] > 0 ? @[self.nativeName] : @[@"None"];
        case CountryDetailTypeDemonym:
            return [self.demonym length] > 0 ? @[self.demonym] : @[@"None"];
        case CountryDetailTypeCapital:
            return [self.capital length] > 0 ? @[self.capital] : @[@"None"];
        case CountryDetailTypePopulation:
            return [self.capital length] > 0 ? @[self.population] : @[@"None"];
        case CountryDetailTypeLanguages:
            return [self.languages count] > 0 ? self.languages : @[@"None"];
        case CountryDetailTypeCurrencies:
            return [self.currencies count] > 0 ? self.currencies : @[@"None"];
        case CountryDetailTypeTimezone:
            return [self.timeZones count] > 0 ? self.timeZones : @[@"None"];
        case CountryDetailTypeRegion:
            return [self.region length] > 0 ? @[self.region] : @[@"None"];
        case CountryDetailTypeSubRegion:
            return [self.subRegion length] > 0 ? @[self.subRegion] : @[@"None"];
        case CountryDetailTypeBorders:
            return [self.borders count] > 0 ? self.borders : @[@"None"];
        case CountryDetailTypeRegionalBlocks:
            return [self.regionalBlocks count] > 0 ? self.regionalBlocks : @[@"None"];
    }
}

@end
