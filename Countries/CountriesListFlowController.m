//
//  CountriesListFlowController.m
//  Countries
//
//  Created by John Raymund Catahay on 20/05/2017.
//  Copyright © 2017 John Raymund Catahay. All rights reserved.
//

#import "CountriesListFlowController.h"
#import "CountriesListViewController.h"
#import "CountriesSearchFlowController.h"
#import "CountryDetailsFlowController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@import Hero;

@interface CountriesListFlowController()

@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) CountriesListViewController *viewController;
@property (strong, nonatomic) CountriesListPresenter *presenter;
@property (strong, nonatomic) CountriesSearchFlowController *searchFlowController;
@property (strong, nonatomic) UIButton *sortButton;
@property (strong, nonatomic) UIButton *searchButton;
@property (strong, nonatomic) CountryDetailsFlowController *countryDetailsFlowwController;

@end

@implementation CountriesListFlowController

#pragma mark - Private

- (CountriesListPresenter *)presenter {
    if (!_presenter) {
        _presenter = [[CountriesListPresenter alloc] init];
        @weakify(self)
        [[_presenter.selectedCountrySubject throttle:0.5]
         subscribeNext:^(Country *country) {
            @strongify(self)
            [self.countryDetailsFlowwController startWithCountry: country];
        }];
    }
    return _presenter;
}

- (CountriesListViewController *)viewController {
    if (!_viewController) {
        _viewController = [[CountriesListViewController alloc] init];
        _viewController.title = @"Countries";
        _viewController.input = self.presenter;
        UIBarButtonItem *sortButton = [[UIBarButtonItem alloc] initWithCustomView:self.sortButton];
        UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithCustomView:self.searchButton];
        _viewController.navigationItem.rightBarButtonItems = @[searchButton, sortButton];
        
        _viewController.isHeroEnabled = YES;
        _viewController.view.heroID = @"view";
    }
    return _viewController;
}

- (CountriesSearchFlowController *)searchFlowController {
    if (!_searchFlowController) {
        _searchFlowController = [[CountriesSearchFlowController alloc] initWithNavigationController:self.navigationController];
    }
    return _searchFlowController;
}

- (CountryDetailsFlowController *)countryDetailsFlowwController {
    if (!_countryDetailsFlowwController) {
        _countryDetailsFlowwController = [[CountryDetailsFlowController alloc] initWithNavigationController:self.navigationController];
    }
    return _countryDetailsFlowwController;
}

- (UIButton *)searchButton {
    if (!_searchButton) {
        _searchButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_searchButton setImage:[[UIImage imageNamed:@"search"]
                                 imageWithRenderingMode: UIImageRenderingModeAlwaysTemplate]
                       forState: UIControlStateNormal];
        _searchButton.imageView.tintColor = UIColor.whiteColor;
        _searchButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _searchButton.frame = CGRectMake(0, 0, 40, 20);
        [_searchButton addTarget:self
                          action:@selector(showSearch)
                forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchButton;
}

- (UIButton *)sortButton {
    if (!_sortButton) {
        _sortButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_sortButton setImage:[[UIImage imageNamed:@"sort"]
                                 imageWithRenderingMode: UIImageRenderingModeAlwaysTemplate]
                       forState: UIControlStateNormal];
        _sortButton.imageView.tintColor = UIColor.whiteColor;
        _sortButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _sortButton.frame = CGRectMake(0, 0, 40, 20);
        [_sortButton addTarget:self
                          action:@selector(sort)
                forControlEvents:UIControlEventTouchUpInside];
    }
    return _sortButton;
}

#pragma mark - Lifecycle

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController {
    if (self = [self init]){
        self.navigationController = navigationController;
    }
    return self;
}

- (void)start {
    [self.navigationController pushViewController: self.viewController animated: YES];
}

- (void)sort {
    [self.viewController showSortOption];
}

- (void)showSearch {
    [self.searchFlowController start];
}

@end
