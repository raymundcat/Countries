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
#import "FlagWebViewController.h"
#import "Constants.h"
@import Hero;

@interface CountryDetailsFlowController ()

@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) CountryDetailsViewController *viewController;
@property (strong, nonatomic) FlagWebViewController *flagViewController;
@property (strong, nonatomic) Country *country;

@end

@implementation CountryDetailsFlowController

#pragma mark - Private

-(CountryDetailsViewController *)viewController {
    if (!_viewController) {
        _viewController = [[CountryDetailsViewController alloc] init];
        
        _viewController.isHeroEnabled = YES;
        _viewController.view.heroID = HeroViewID;
        
        [[_viewController.didPressFlagSubject throttle:0.5]
         subscribeNext:^(id x) {
            [self.flagViewController loadCountry:self. country];
            [self.navigationController setNavigationBarHidden:NO animated:YES];
            [self.navigationController pushViewController:self.flagViewController animated:YES];
        }];
    }
    return _viewController;
}

-(FlagWebViewController *)flagViewController {
    if (!_flagViewController) {
        _flagViewController = [[FlagWebViewController alloc] init];
        _flagViewController.isHeroEnabled = YES;
        _flagViewController.view.heroID = HeroViewID;
    }
    return _flagViewController;
}

#pragma mark - Lifecycle

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController {
    if (self = [self init]){
        self.navigationController = navigationController;
    }
    return self;
}

- (void)startWithCountry: (Country *)country {
    self.country = country;
    self.viewController.country = country;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController pushViewController: self.viewController animated: YES];
}

@end
