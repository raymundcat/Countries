//
//  CountriesListViewController.m
//  Countries
//
//  Created by John Raymund Catahay on 20/05/2017.
//  Copyright © 2017 John Raymund Catahay. All rights reserved.
//

#import "CountriesListViewController.h"
#import "Masonry.h"
#import "Country.h"
#import "CountryCollectionViewCell.h"
#import "CountriesCollectionHeaderView.h"

@interface CountriesListViewController ()

@property (nonatomic, strong) NSArray<NSString *> *categories;
@property (nonatomic, strong) NSArray<NSArray<Country *> *> *countries;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation CountriesListViewController

@synthesize categories = _categories;
@synthesize countries = _countries;

- (NSArray *)categories {
    if (!_categories) {
        _categories = @[];
    }
    return _categories;
}

-(NSArray<NSArray<Country *> *> *)countries {
    if (!_countries) {
        _countries = @[];
    }
    return _countries;
}

-(void)setCategories:(NSArray *)categories {
    _categories = categories;
    [self.collectionView reloadData];
}

-(void)setCountries:(NSArray<NSArray<Country *> *> *)countries {
    _countries = countries;
    [self.collectionView reloadData];
}

- (void)setInput:(id<CountriesListInput>)input {
    _input = input;
    @weakify(self)
    [self.viewDidLoadSignal subscribeNext:^(id x) {
        @strongify(self)
        [self.input viewDidLoad];
    }];
    [input.countriesCategoriesSubject subscribeNext:^(NSArray<NSString *> *categories) {
        @strongify(self)
        self.categories = categories;
    }];
    [input.countriesSubject subscribeNext:^(NSArray<NSArray<Country *> *> *countries) {
        @strongify(self)
        self.countries = countries;
    }];
}

static NSString *CellIdentifier = @"Cell";
static NSString *HeaderIdentifier = @"Cell";
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.headerReferenceSize = CGSizeMake(_collectionView.frame.size.width, 40);
        _collectionView = [[UICollectionView alloc] initWithFrame: CGRectZero
                                             collectionViewLayout: flowLayout];
        _collectionView.backgroundColor = UIColor.clearColor;
        _collectionView.alwaysBounceVertical = YES;
        [_collectionView registerClass:[CountriesCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderIdentifier];
        [_collectionView registerClass:[CountryCollectionViewCell class]
            forCellWithReuseIdentifier:CellIdentifier];
        _collectionView.contentInset = UIEdgeInsetsMake(8, 8, 8, 8);
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview: self.collectionView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.categories count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.countries[section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CountryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.country = self.countries[indexPath.section][indexPath.row];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    CountriesCollectionHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind: UICollectionElementKindSectionHeader withReuseIdentifier:HeaderIdentifier forIndexPath:indexPath];
    view.categoryName = self.categories[indexPath.section];
    return view;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = (collectionView.frame.size.width) - 6;
    return CGSizeMake(width, width);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 3;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 2;
}

@end
