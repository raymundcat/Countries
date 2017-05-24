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

@interface CountriesListFlowController()

@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, strong) CountriesListViewController *viewController;
@property (nonatomic, strong) CountriesListPresenter *presenter;
@property (nonatomic, strong) CountriesSearchFlowController *searchFlowController;

@end

@implementation CountriesListFlowController

- (CountriesListPresenter *)presenter {
    if (!_presenter) {
        _presenter = [[CountriesListPresenter alloc] init];
    }
    return _presenter;
}

- (CountriesListViewController *)viewController {
    if (!_viewController) {
        _viewController = [[CountriesListViewController alloc] init];
        _viewController.title = @"Countries";
        _viewController.input = self.presenter;
    }
    return _viewController;
}

- (CountriesSearchFlowController *)searchFlowController {
    if (!_searchFlowController) {
        _searchFlowController = [[CountriesSearchFlowController alloc] initWithNavigationController:self.navigationController];
    }
    return _searchFlowController;
}

- (id)initWithNavigationController:(UINavigationController *)navigationController {
    if (self = [self init]){
        self.navigationController = navigationController;
        UIBarButtonItem *sortButton = [[UIBarButtonItem alloc] initWithTitle:@"sort" style:UIBarButtonItemStylePlain target:self action:@selector(sort)];
        UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithTitle:@"search" style:UIBarButtonItemStylePlain target:self action:@selector(showSearch)];
        self.viewController.navigationItem.rightBarButtonItems = @[searchButton, sortButton];
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
