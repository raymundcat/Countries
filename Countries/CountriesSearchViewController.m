//
//  CountriesSearchViewController.m
//  Countries
//
//  Created by John Raymund Catahay on 25/05/2017.
//  Copyright © 2017 John Raymund Catahay. All rights reserved.
//

#import "CountriesSearchViewController.h"
#import "Country.h"
#import "UIColor+Countries.h"
#import "CountryCollectionViewCell.h"
#import <Masonry/Masonry.h>

@interface CountriesSearchViewController ()

@property (nonatomic, strong) NSArray<Country *> *countries;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIImageView *mapView;

@end

@implementation CountriesSearchViewController

@synthesize countries = _countries;

-(NSArray<Country *> *)countries {
    if (!_countries) {
        _countries = @[];
    }
    return _countries;
}

-(void)setCountries:(NSArray<Country*> *)countries {
    _countries = countries;
    [self.collectionView reloadData];
}

- (void)setInput:(id<CountriesSearchInput>)input {
    _input = input;
    @weakify(self)
    [self.viewDidLoadSignal subscribeNext:^(id x) {
        @strongify(self)
        [self.input viewDidLoad];
    }];
    [input.countriesSubject subscribeNext:^(NSArray<Country *> *countries) {
        @strongify(self)
        self.countries = countries;
    }];
}

-(UIImageView *)mapView {
    if (!_mapView) {
        _mapView = [[UIImageView alloc] init];
        _mapView.image = [UIImage imageNamed:@"worldmap"];
        _mapView.contentMode = UIViewContentModeScaleAspectFill;
        _mapView.alpha = 0.3;
    }
    return _mapView;
}

static NSString *CellIdentifier = @"Cell";
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame: CGRectZero
                                             collectionViewLayout: flowLayout];
        _collectionView.backgroundColor = UIColor.clearColor;
        _collectionView.alwaysBounceVertical = YES;
        [_collectionView registerClass:[CountryCollectionViewCell class]
            forCellWithReuseIdentifier:CellIdentifier];
        _collectionView.contentInset = UIEdgeInsetsMake(58, 8, 8, 8);
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview: self.mapView];
    [self.view addSubview: self.collectionView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    CAGradientLayer *gradient = [UIColor gradientWithColors:@[(id)UIColor.blueGreenColor.CGColor,
                                                              (id)UIColor.lightBlueGreenColor.CGColor]
                                                    forRect:self.view.bounds];
    [self.view.layer insertSublayer:gradient atIndex:0];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
}

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [self.collectionView.collectionViewLayout invalidateLayout];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.countries count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CountryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.country = self.countries[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = (collectionView.frame.size.width * 0.33) - 6;
    return CGSizeMake(width, width);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 3;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 2;
}

@end
