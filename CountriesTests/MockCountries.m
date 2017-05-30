//
//  MockCountries.m
//  Countries
//
//  Created by John Raymund Catahay on 31/05/2017.
//  Copyright © 2017 John Raymund Catahay. All rights reserved.
//

#import "MockCountries.h"
#import "Country.h"

@implementation MockCountries

+ (Country *)mockedColombia {
    return [Country fromJSON: [MockCountries getJSONFromFile:@"colombia"]];
}

+(Country *)mockedPhilippines {
    return [Country fromJSON: [MockCountries getJSONFromFile:@"philippines"]];
}

+(Country *)mockedSweden {
    return [Country fromJSON: [MockCountries getJSONFromFile:@"sweden"]];
}

+ (NSDictionary *)getJSONFromFile: (NSString *)fileName {
    NSString *filePath = [[NSBundle bundleForClass: self] pathForResource:fileName ofType:@"json"];
    NSString *myJSON = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    NSError *error =  nil;
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:[myJSON dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    return jsonDictionary;
}

@end
