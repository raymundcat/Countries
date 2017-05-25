//
//  BaseViewController.m
//  Countries
//
//  Created by John Raymund Catahay on 20/05/2017.
//  Copyright © 2017 John Raymund Catahay. All rights reserved.
//

#import "BaseViewController.h"
@import Hero;

@interface BaseViewController ()

@end

@implementation BaseViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    self.isHeroEnabled = YES;
}

- (RACSignal *)viewDidLoadSignal {
    if (!_viewDidLoadSignal) {
        _viewDidLoadSignal = [self rac_signalForSelector:@selector(viewDidLoad)];
    }
    return _viewDidLoadSignal;
}

@end
