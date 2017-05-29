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

#pragma mark - Lifecycle

- (RACSignal *)viewDidLoadSignal {
    if (!_viewDidLoadSignal) {
        _viewDidLoadSignal = [self rac_signalForSelector:@selector(viewDidLoad)];
    }
    return _viewDidLoadSignal;
}

#pragma mark - Progress Indicators

- (void)showProgress {
    dispatch_after(0, dispatch_get_main_queue(), ^(void){
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    });
}

- (void)hideProgress {
    dispatch_after(0.5, dispatch_get_main_queue(), ^(void){
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
}

@end
