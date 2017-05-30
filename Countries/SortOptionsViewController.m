//
//  SortOptionsViewController.m
//  Countries
//
//  Created by John Raymund Catahay on 25/05/2017.
//  Copyright © 2017 John Raymund Catahay. All rights reserved.
//

#import "SortOptionsViewController.h"
#import "Country.h"

@interface SortOptionsViewController ()

@property (nonatomic, strong, readwrite) RACSubject *selectedCategorySubject;
@property (strong, nonatomic) UIAlertAction *regionOption;
@property (strong, nonatomic) UIAlertAction *subRegionOption;
@property (strong, nonatomic) UIAlertAction *regionalBlocOption;
@property (strong, nonatomic) UIAlertAction *allOption;
@property (strong, nonatomic) UIAlertAction *cancelnOption;

@end

@implementation SortOptionsViewController

#pragma mark - Private

- (UIAlertAction *)allOption {
    if (!_allOption) {
        @weakify(self)
        _allOption = [UIAlertAction actionWithTitle:@"All"
                                                    style: UIAlertActionStyleDefault
                                                  handler:^(UIAlertAction * _Nonnull action) {
                                                      @strongify(self)
                                                      [self.selectedCategorySubject sendNext: @(CountryCategoryAll)];
                                                  }];
    }
    return _allOption;
}

- (UIAlertAction *)regionOption {
    if (!_regionOption) {
        @weakify(self)
        _regionOption = [UIAlertAction actionWithTitle:@"Region"
                                                 style: UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * _Nonnull action) {
                                                   @strongify(self)
                                                   [self.selectedCategorySubject sendNext: @(CountryCategoryRegion)];
                                               }];
    }
    return _regionOption;
}

- (UIAlertAction *)subRegionOption {
    if (!_subRegionOption) {
        @weakify(self)
        _subRegionOption = [UIAlertAction actionWithTitle:@"Sub Region"
                                                 style: UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * _Nonnull action) {
                                                   @strongify(self)
                                                   [self.selectedCategorySubject sendNext: @(CountryCategorySubRegion)];
                                               }];
    }
    return _subRegionOption;
}

- (UIAlertAction *)regionalBlocOption {
    if (!_regionalBlocOption) {
        @weakify(self)
        _regionalBlocOption = [UIAlertAction actionWithTitle:@"Region Blocks"
                                                    style: UIAlertActionStyleDefault
                                                  handler:^(UIAlertAction * _Nonnull action) {
                                                      @strongify(self)
                                                      [self.selectedCategorySubject sendNext: @(CountryCategoryRegionalBloc)];
                                                  }];
    }
    return _regionalBlocOption;
}

-(UIAlertAction *)cancelnOption {
    if (!_cancelnOption) {
        _cancelnOption = [UIAlertAction actionWithTitle:@"Cancel"
                                                  style:UIAlertActionStyleDestructive
                                                handler:nil];
    }
    return _cancelnOption;
}

#pragma mark - Public

-(RACSubject *)selectedCategorySubject {
    if (!_selectedCategorySubject) {
        _selectedCategorySubject = [RACSubject subject];
    }
    return _selectedCategorySubject;
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addAction:self.allOption];
    [self addAction:self.regionOption];
    [self addAction:self.subRegionOption];
    [self addAction:self.regionalBlocOption];
    [self addAction:self.cancelnOption];
}

@end
