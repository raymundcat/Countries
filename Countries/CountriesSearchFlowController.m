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

@interface CountriesSearchFlowController ()

@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, strong) CountriesListViewController *viewController;
@property (nonatomic, strong) CountriesListPresenter *presenter;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

@end

@implementation CountriesSearchFlowController

- (CountriesListPresenter *)presenter {
    if (!_presenter) {
        _presenter = [[CountriesListPresenter alloc] init];
    }
    return _presenter;
}

- (CountriesListViewController *)viewController {
    if (!_viewController) {
        _viewController = [[CountriesListViewController alloc] init];
        _viewController.presenter = self.presenter;
        _viewController.navigationItem.titleView = self.searchBar;
        _viewController.navigationItem.leftBarButtonItem = nil;
        _viewController.navigationItem.hidesBackButton = YES;
        [_viewController.view addGestureRecognizer: self.tapGesture];
    }
    return _viewController;
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
