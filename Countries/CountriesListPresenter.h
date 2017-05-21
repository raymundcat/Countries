//
//  CountriesListPresenter.h
//  Countries
//
//  Created by John Raymund Catahay on 20/05/2017.
//  Copyright © 2017 John Raymund Catahay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface CountriesListPresenter : NSObject

- (void)viewDidLoad;

@property (nonatomic, strong, readonly) RACSubject *countriesSubject;

@end
