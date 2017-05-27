//
//  CountryDetailFlowController.m
//  Countries
//
//  Created by John Raymund Catahay on 27/05/2017.
//  Copyright © 2017 John Raymund Catahay. All rights reserved.
//

#import "CountryDetailsFlowController.h"
#import "CountryDetailsViewController.h"
@import Hero;

@interface CountryDetailsFlowController ()

@property (nonatomic, strong) UINavigationController *parentNavigationController;
@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, strong) CountryDetailsViewController *viewController;

@end

@implementation CountryDetailsFlowController

-(CountryDetailsViewController *)viewController {
    if (!_viewController) {
        _viewController = [[CountryDetailsViewController alloc] init];
        _viewController.title = @"Details";
//        _viewController.input = self.presenter;
    }
    return _viewController;
}

- (id)initWithNavigationController:(UINavigationController *)navigationController {
    if (self = [self init]){
        self.parentNavigationController = navigationController;
    }
    return self;
}

-(UINavigationController *)navigationController {
    if (!_navigationController) {
        _navigationController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
        _navigationController.view.backgroundColor = UIColor.whiteColor;
        _navigationController.isHeroEnabled = YES;
        _navigationController.view.heroID = @"cell";
    }
    return _navigationController;
}

- (void)start {
    [self.parentNavigationController presentViewController:self.navigationController
                                            animated:YES
                                          completion:nil];
}

@end
