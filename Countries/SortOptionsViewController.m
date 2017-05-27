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
@property (nonatomic, strong) UIAlertAction *regionOption;
@property (nonatomic, strong) UIAlertAction *subRegionOption;
@property (nonatomic, strong) UIAlertAction *regionalBlockOption;
@property (nonatomic, strong) UIAlertAction *allOption;
@property (nonatomic, strong) UIAlertAction *cancelnOption;

@end

@implementation SortOptionsViewController

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

- (UIAlertAction *)regionalBlockOption {
    if (!_regionalBlockOption) {
        @weakify(self)
        _regionalBlockOption = [UIAlertAction actionWithTitle:@"Region Blocks"
                                                    style: UIAlertActionStyleDefault
                                                  handler:^(UIAlertAction * _Nonnull action) {
                                                      @strongify(self)
                                                      [self.selectedCategorySubject sendNext: @(CountryCategoryRegionalBlock)];
                                                  }];
    }
    return _regionalBlockOption;
}

-(UIAlertAction *)cancelnOption {
    if (!_cancelnOption) {
        _cancelnOption = [UIAlertAction actionWithTitle:@"Cancel"
                                                  style:UIAlertActionStyleDestructive
                                                handler:nil];
    }
    return _cancelnOption;
}


-(RACSubject *)selectedCategorySubject {
    if (!_selectedCategorySubject) {
        _selectedCategorySubject = [RACSubject subject];
    }
    return _selectedCategorySubject;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addAction:self.allOption];
    [self addAction:self.regionOption];
    [self addAction:self.subRegionOption];
    [self addAction:self.regionalBlockOption];
    [self addAction:self.cancelnOption];
}

@end
