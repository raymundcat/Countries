//
//  CountryDetailFlowController.m
//  Countries
//
//  Created by John Raymund Catahay on 27/05/2017.
//  Copyright © 2017 John Raymund Catahay. All rights reserved.
//

#import "CountryDetailsFlowController.h"
#import "CountryDetailsViewController.h"
#import "UIColor+Countries.h"
#import "Country.h"
@import Hero;

@interface CountryDetailsFlowController ()

@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, strong) CountryDetailsViewController *viewController;
@property (nonatomic, strong) UIButton *closeButton;

@end

@implementation CountryDetailsFlowController

-(CountryDetailsViewController *)viewController {
    if (!_viewController) {
        _viewController = [[CountryDetailsViewController alloc] init];
        
        _viewController.isHeroEnabled = YES;
        _viewController.view.heroID = @"view";
    }
    return _viewController;
}

- (id)initWithNavigationController:(UINavigationController *)navigationController {
    if (self = [self init]){
        self.navigationController = navigationController;
    }
    return self;
}

- (void)startWithCountry: (Country *)country {
    self.viewController.country = country;
    [self.navigationController pushViewController: self.viewController animated: YES];
}

- (void)start {
    [self.navigationController pushViewController:self.viewController animated:YES];
}

@end
