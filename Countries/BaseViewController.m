//
//  BaseViewController.m
//  Countries
//
//  Created by John Raymund Catahay on 20/05/2017.
//  Copyright © 2017 John Raymund Catahay. All rights reserved.
//

#import "BaseViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface BaseViewController ()

@end

@implementation BaseViewController

- (RACSignal *)viewDidLoadSignal {
    if (!_viewDidLoadSignal) {
        _viewDidLoadSignal = [self rac_signalForSelector:@selector(viewDidLoad)];
    }
    return _viewDidLoadSignal;
}

- (void)showProgress {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.0 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    });
}

- (void)hideProgress {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
}

@end
