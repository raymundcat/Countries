//
//  CountriesSearchFlowController.m
//  Countries
//
//  Created by John Raymund Catahay on 22/05/2017.
//  Copyright © 2017 John Raymund Catahay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CountriesSearchFlowController.h"
#import "CountriesListViewController.h"
#import "CountriesSearchPresenter.h"
#import "CountriesSearchViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "CountryDetailsFlowController.h"
#import "CountriesListAPI.h"
@import Hero;

@interface CountriesSearchFlowController ()

@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) CountriesSearchViewController *viewController;
@property (strong, nonatomic) CountriesSearchPresenter *presenter;
@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) UITapGestureRecognizer *viewTapGesture;
@property (strong, nonatomic) CountryDetailsFlowController *countryDetailsFlowwController;

@end

@implementation CountriesSearchFlowController

#pragma mark - Private

- (CountriesSearchPresenter *)presenter {
    if (!_presenter) {
        _presenter = [[CountriesSearchPresenter alloc]
                      initWithCountriesAPI:[[CountriesListAPI alloc] init]];
        @weakify(self)
        [[_presenter.selectedCountrySubject throttle:0.5]
         subscribeNext:^(Country *country) {
            @strongify(self)
            [self.countryDetailsFlowwController startWithCountry:country];
        }];
    }
    return _presenter;
}

- (CountriesSearchViewController *)viewController {
    if (!_viewController) {
        _viewController = [[CountriesSearchViewController alloc] init];
        _viewController.input = self.presenter;
        _viewController.navigationItem.titleView = self.searchBar;
        _viewController.navigationItem.leftBarButtonItem = nil;
        _viewController.navigationItem.hidesBackButton = YES;
        [_viewController.view addGestureRecognizer: self.viewTapGesture];
        
        _viewController.isHeroEnabled = YES;
        _viewController.view.heroID = @"view";
    }
    return _viewController;
}

-(CountryDetailsFlowController *)countryDetailsFlowwController {
    if (!_countryDetailsFlowwController) {
        _countryDetailsFlowwController = [[CountryDetailsFlowController alloc] initWithNavigationController:self.navigationController];
    }
    return _countryDetailsFlowwController;
}

- (UITapGestureRecognizer *)viewTapGesture {
    if (!_viewTapGesture) {
        _viewTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapView)];
        _viewTapGesture.cancelsTouchesInView = NO;
    }
    return _viewTapGesture;
}

- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 120, 45)];
        _searchBar.showsCancelButton = YES;
        _searchBar.placeholder = @"Search countries";
        _searchBar.delegate = self;
    }
    return _searchBar;
}

#pragma mark - Lifecycle

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController {
    if (self = [self init]){
        self.navigationController = navigationController;
        [[self rac_signalForSelector:@selector(searchBar:textDidChange:)]
         subscribeNext:^(RACTuple *x) {
             NSString *searchText = x.last;
             [self.presenter.searchTextSubject sendNext:searchText];
         }];
    }
    return self;
}

- (void)start {
    [self.navigationController pushViewController: self.viewController animated: YES];
    [self.searchBar becomeFirstResponder];
}

- (void)didTapView{
    [self.searchBar endEditing: YES];
    
    //this enables the cancel button even
    //when the searchbar is not active
    for (UIView *view in self.searchBar.subviews) {
        for(id subview in [view subviews]) {
            if ([subview isKindOfClass:[UIButton class]]) {
                [subview setEnabled:YES];
            }
        }
    }
}

#pragma mark - Searchbar Delegate

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.searchBar resignFirstResponder];
    [self.navigationController popViewControllerAnimated: YES];
}

@end
