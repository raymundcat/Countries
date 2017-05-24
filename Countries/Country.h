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
    CountryCategoryRegion = 1,
    CountryCategorySubRegion,
    CountryCategoryAll
}CountryCategory;

@property (nonatomic, strong, readonly) NSString *alpha2Code;
@property (nonatomic, strong, readonly) NSString *alpha3Code;
@property (nonatomic, strong, readonly) NSString *numericCode;
@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSString *nativeName;
@property (nonatomic, strong, readonly) NSString *capital;
@property (nonatomic, strong, readonly) NSString *region;
@property (nonatomic, strong, readonly) NSString *subRegion;
@property (nonatomic, strong, readonly) NSString *flag;

+ (Country *)fromJSON: (NSDictionary *)json;
- (NSString *)valueForCategory: (CountryCategory)category;

@end
