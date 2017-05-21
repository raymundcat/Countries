//
//  BaseViewController.m
//  Countries
//
//  Created by John Raymund Catahay on 20/05/2017.
//  Copyright © 2017 John Raymund Catahay. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (RACSignal *)viewDidLoadSignal {
    if (!_viewDidLoadSignal) {
        _viewDidLoadSignal = [self rac_signalForSelector:@selector(viewDidLoad)];
    }
    return _viewDidLoadSignal;
}

@end
