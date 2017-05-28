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
@import Hero;

@interface CountryDetailsFlowController ()

@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, strong) CountryDetailsViewController *viewController;
@property (nonatomic, strong) FlagWebViewController *flagViewController;
@property (nonatomic, strong) Country *country;

@end

@implementation CountryDetailsFlowController

-(CountryDetailsViewController *)viewController {
    if (!_viewController) {
        _viewController = [[CountryDetailsViewController alloc] init];
        
        _viewController.isHeroEnabled = YES;
        _viewController.view.heroID = @"view";
        
        [[_viewController.didPressFlagSubject throttle:0.5]
         subscribeNext:^(id x) {
            [self.flagViewController loadCountry:self. country];
            [self.navigationController pushViewController:self.flagViewController animated:YES];
        }];
    }
    return _viewController;
}

-(FlagWebViewController *)flagViewController {
    if (!_flagViewController) {
        _flagViewController = [[FlagWebViewController alloc] init];
    }
    return _flagViewController;
}

- (id)initWithNavigationController:(UINavigationController *)navigationController {
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

-(void)start {
    
}

@end
