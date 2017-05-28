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
@import Hero;

@interface CountriesSearchFlowController ()

@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, strong) CountriesSearchViewController *viewController;
@property (nonatomic, strong) CountriesSearchPresenter *presenter;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic, strong) CountryDetailsFlowController *countryDetailsFlowwController;

@end

@implementation CountriesSearchFlowController

- (CountriesSearchPresenter *)presenter {
    if (!_presenter) {
        _presenter = [[CountriesSearchPresenter alloc] init];
        @weakify(self)
        [_presenter.selectedCountrySubject subscribeNext:^(Country *country) {
            @strongify(self)
            if ([self.searchBar isFirstResponder]) {
                [self.searchBar endEditing: YES];
            }else{
                [self.countryDetailsFlowwController startWithCountry:country];
            }
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
        [_viewController.view addGestureRecognizer: self.tapGesture];
    }
    return _viewController;
}

-(CountryDetailsFlowController *)countryDetailsFlowwController {
    if (!_countryDetailsFlowwController) {
        _countryDetailsFlowwController = [[CountryDetailsFlowController alloc] initWithNavigationController:self.navigationController];
    }
    return _countryDetailsFlowwController;
}

- (UITapGestureRecognizer *)tapGesture {
    if (!_tapGesture) {
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap)];
        _tapGesture.cancelsTouchesInView = NO;
    }
    return _tapGesture;
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

- (id)initWithNavigationController:(UINavigationController *)navigationController {
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

- (void) didTap{
    [self.searchBar endEditing: YES];
    for (UIView *view in self.searchBar.subviews) {
        for(id subview in [view subviews]) {
            if ([subview isKindOfClass:[UIButton class]]) {
                [subview setEnabled:YES];
            }
        }
    }
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.searchBar resignFirstResponder];
    [self.navigationController popViewControllerAnimated: YES];
}

@end
