//
//  Geognos.m
//  Countries
//
//  Created by John Raymund Catahay on 24/05/2017.
//  Copyright © 2017 John Raymund Catahay. All rights reserved.
//

#import "Geognos.h"

@implementation Geognos

static NSString *GeognosBaseEndPoint = @"http://www.geognos.com/api/en/countries";
static NSString *GeognosFlagServiceName = @"flag";

+ (NSURL *)flagURLfor: (NSString *)countryAlphaCode {
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@/%@.png",
                                 GeognosBaseEndPoint,
                                 GeognosFlagServiceName,
                                 countryAlphaCode]];
}

@end
