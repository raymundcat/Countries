//
//  Country.m
//  Countries
//
//  Created by John Raymund Catahay on 20/05/2017.
//  Copyright © 2017 John Raymund Catahay. All rights reserved.
//

#import "Country.h"

@interface Country ()

@property (nonatomic, strong, readwrite) NSString *numericCode;
@property (nonatomic, strong, readwrite) NSString *name;
@property (nonatomic, strong, readwrite) NSString *nativeName;
@property (nonatomic, strong, readwrite) NSString *capital;
@property (nonatomic, strong, readwrite) NSString *region;
@property (nonatomic, strong, readwrite) NSString *subRegion;
@property (nonatomic, strong, readwrite) NSString *flag;

@end

@implementation Country

+ (Country *)fromJSON: (NSDictionary *)json {
    Country *country = [[Country alloc] init];
    country.name = [json objectForKey:@"name"];
    country.numericCode = [json objectForKey:@"numericCode"];
    country.region = [json objectForKey:@"region"];
    country.subRegion = [json objectForKey:@"subregion"];
    country.flag = [json objectForKey:@"flag"];
    return country;
}

@end
