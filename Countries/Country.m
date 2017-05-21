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
@property (nonatomic, strong, readwrite) NSString *Name;
@property (nonatomic, strong, readwrite) NSString *NativeName;
@property (nonatomic, strong, readwrite) NSString *Capital;
@property (nonatomic, strong, readwrite) NSString *Region;
@property (nonatomic, strong, readwrite) NSString *SubRegion;

@end

@implementation Country

+ (Country *)fromJSON: (NSDictionary *)json {
    
    Country *country = [[Country alloc] init];
    country.numericCode = [json objectForKey:@"numericCode"];
    
    return country;
}

@end
