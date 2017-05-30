//
//  Country.h
//  Countries
//
//  Created by John Raymund Catahay on 20/05/2017.
//  Copyright © 2017 John Raymund Catahay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Country : NSObject

typedef enum {
    CountryCategoryRegion = 0,
    CountryCategorySubRegion,
    CountryCategoryRegionalBloc,
    CountryCategoryAll
}CountryCategory;

typedef enum {
    CountryDetailTypeNativeName = 0,
    CountryDetailTypeDemonym,
    CountryDetailTypeCapital,
    CountryDetailTypePopulation,
    CountryDetailTypeLanguages,
    CountryDetailTypeCurrencies,
    CountryDetailTypeTimezone,
    CountryDetailTypeRegion,
    CountryDetailTypeSubRegion,
    CountryDetailTypeBorders,
    CountryDetailTypeRegionalBlocs
}CountryDetailType;

@property (nonatomic, strong, readonly) NSString *alpha2Code;
@property (nonatomic, strong, readonly) NSString *alpha3Code;
@property (nonatomic, strong, readonly) NSString *numericCode;
@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSString *nativeName;
@property (nonatomic, strong, readonly) NSString *capital;
@property (nonatomic, strong, readonly) NSString *region;
@property (nonatomic, strong, readonly) NSString *subRegion;
@property (nonatomic, strong, readonly) NSString *flag;
@property (nonatomic, strong, readonly) NSString *demonym;
@property (nonatomic, strong, readonly) NSNumber *population;
@property (nonatomic, strong, readonly) NSMutableArray<NSString *> *otherNames;
@property (nonatomic, strong, readonly) NSMutableArray<NSString *> *regionalBlocs;
@property (nonatomic, strong, readonly) NSMutableArray<NSString *> *languages;
@property (nonatomic, strong, readonly) NSMutableArray<NSString *> *currencies;
@property (nonatomic, strong, readonly) NSMutableArray<NSString *> *timeZones;
@property (nonatomic, strong, readonly) NSMutableArray<NSString *> *borders;

+ (Country *)fromJSON: (NSDictionary *)json;

+ (NSString *)readableNameOfDetailType: (CountryDetailType)detailType;
- (NSArray<NSString *> *)valuesForDetail: (CountryDetailType)detailType;
- (NSArray<NSString *> *)valuesForCategory: (CountryCategory)category;

@end
