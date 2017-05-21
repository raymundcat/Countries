//
//  Country.h
//  Countries
//
//  Created by John Raymund Catahay on 20/05/2017.
//  Copyright © 2017 John Raymund Catahay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Country : NSObject

@property (nonatomic, strong, readonly) NSString *numericCode;
@property (nonatomic, strong, readonly) NSString *Name;
@property (nonatomic, strong, readonly) NSString *NativeName;
@property (nonatomic, strong, readonly) NSString *Capital;
@property (nonatomic, strong, readonly) NSString *Region;
@property (nonatomic, strong, readonly) NSString *SubRegion;

+ (Country *)fromJSON: (NSDictionary *)json;

@end
