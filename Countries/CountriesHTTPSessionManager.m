//
//  CountriesHTTPSessionManager.m
//  Countries
//
//  Created by John Raymund Catahay on 24/05/2017.
//  Copyright © 2017 John Raymund Catahay. All rights reserved.
//

#import "CountriesHTTPSessionManager.h"

@implementation CountriesHTTPSessionManager

- (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request
                            completionHandler:(void (^)(NSURLResponse * _Nonnull, id _Nullable, NSError * _Nullable))completionHandler {
    
    NSMutableURLRequest *modifiedRequest = request.mutableCopy;
    AFNetworkReachabilityManager *reachability = self.reachabilityManager;
    if (!reachability.isReachable)
    {
        modifiedRequest.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
    }
    return [super dataTaskWithRequest:modifiedRequest
                    completionHandler:completionHandler];
}

- (void)URLSession:(NSURLSession *)session
          dataTask:(NSURLSessionDataTask *)dataTask
 willCacheResponse:(NSCachedURLResponse *)proposedResponse
 completionHandler:(void (^)(NSCachedURLResponse * _Nullable))completionHandler {
    NSURLResponse *response = proposedResponse.response;
    NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse*)response;
    NSDictionary *headers = HTTPResponse.allHeaderFields;
    
    if (headers[@"Cache-Control"])
    {
        NSMutableDictionary *modifiedHeaders = headers.mutableCopy;
        modifiedHeaders[@"Cache-Control"] = @"max-age=60";
        NSHTTPURLResponse *modifiedHTTPResponse = [[NSHTTPURLResponse alloc]
                                                   initWithURL:HTTPResponse.URL
                                                   statusCode:HTTPResponse.statusCode
                                                   HTTPVersion:@"HTTP/1.1"
                                                   headerFields:modifiedHeaders];
        
        proposedResponse = [[NSCachedURLResponse alloc] initWithResponse:modifiedHTTPResponse
                                                                    data:proposedResponse.data
                                                                userInfo:proposedResponse.userInfo
                                                           storagePolicy:proposedResponse.storagePolicy];
    }
    
    [super URLSession:session dataTask:dataTask willCacheResponse:proposedResponse completionHandler:completionHandler];
}

@end
