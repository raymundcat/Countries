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
#import "CountriesHTTPSessionManager.h"

@interface CountriesListAPI ()

@property (strong, nonatomic) CountriesHTTPSessionManager *manager;

@end

@implementation CountriesListAPI

static NSString *CountriesBaseEndPoint = @"https://restcountries.eu/rest/v2";
static NSString *CountriesAllEndPoint = @"all";
static NSString *CountriesNameEndPoint = @"name";

- (CountriesHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [CountriesHTTPSessionManager manager];
    }
    return _manager;
}

- (void)fetchCountriesSummariesWithCompletion:(void (^)(NSArray<Country *> *))completion {
    [self.manager GET: [NSString stringWithFormat:@"%@/%@",
                        CountriesBaseEndPoint,
                        CountriesAllEndPoint]
           parameters:nil
             progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSArray class]]) {
            NSArray *responseArray = responseObject;
            completion([responseArray mapObjectsUsingBlock:^id(id obj, NSUInteger idx) {
                return [Country fromJSON:obj];
            }]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(@[]);
    }];
}

- (void)searchCountriesWithName: (NSString *)searchText WithCompletion: (void (^)(NSArray<Country *> *countriesArray))completion {
    [self.manager GET: [NSString stringWithFormat:@"%@/%@/%@",
                        CountriesBaseEndPoint,
                        CountriesNameEndPoint,
                        searchText]
           parameters:nil
    progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         if ([responseObject isKindOfClass:[NSArray class]]) {
             NSArray *responseArray = responseObject;
             completion([responseArray mapObjectsUsingBlock:^id(id obj, NSUInteger idx) {
                 return [Country fromJSON:obj];
             }]);
         }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         completion(@[]);
    }];
}

@end
