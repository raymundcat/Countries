//
//  CountriesListAPI.m
//  Countries
//
//  Created by John Raymund Catahay on 20/05/2017.
//  Copyright © 2017 John Raymund Catahay. All rights reserved.
//

#import "CountriesListAPI.h"
#import "AFNetworking.h"
#import "NSArray+Map.h"
#import "Country.h"

@interface CountriesListAPI ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation CountriesListAPI

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)fetchCountriesSummariesWithCompletion:(void (^)(NSArray<Country *> *))completion {
    [self.manager GET:@"https://restcountries.eu/rest/v2/all" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"processing");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSArray class]]) {
            NSArray *responseArray = responseObject;
            completion([responseArray mapObjectsUsingBlock:^id(id obj, NSUInteger idx) {
                return [Country fromJSON:obj];
            }]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failed");
    }];
}

- (void)wat{
    
}

@end
