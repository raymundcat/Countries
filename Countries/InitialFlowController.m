//
//  InitialFlowController.m
//  Countries
//
//  Created by John Raymund Catahay on 20/05/2017.
//  Copyright © 2017 John Raymund Catahay. All rights reserved.
//

#import "InitialFlowController.h"
#import "CountriesListFlowController.h"
#import "UIColor+Countries.h"
@import Hero;

@interface InitialFlowController()

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, strong) CountriesListFlowController *countriesListFlowController;

@end

@implementation InitialFlowController

- (UINavigationController *)navigationController {
    if (!_navigationController) {
        _navigationController = [[UINavigationController alloc] init];
        _navigationController.navigationBar.barTintColor = UIColor.skyBlueColor;
        _navigationController.navigationBar.tintColor = UIColor.whiteColor;
        _navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : UIColor.whiteColor};
        _navigationController.isHeroEnabled = YES;
    }
    return _navigationController;
}

-(CountriesListFlowController *)countriesListFlowController {
    if (!_countriesListFlowController) {
        _countriesListFlowController = [[CountriesListFlowController alloc] initWithNavigationController: self.navigationController];
    }
    return _countriesListFlowController;
}

- (id)initWithWindow:(UIWindow *)window {
    if (self = [self init]){
        self.window = window;
    }
    return self;
}

- (void)start {
    [self.countriesListFlowController start];
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
}

@end
