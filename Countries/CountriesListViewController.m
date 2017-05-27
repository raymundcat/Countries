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
#import "UIColor+Countries.h"
#import "SortOptionsViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@import Hero;

@interface CountriesListViewController ()

@property (nonatomic, strong) NSArray<NSString *> *categories;
@property (nonatomic, strong) NSArray<NSArray<Country *> *> *countries;
@property (nonatomic, strong) NSMutableArray<NSNumber *> *droppedSections;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) SortOptionsViewController *sortOptionsAlertController;
@property (nonatomic, strong) UIImageView *mapView;

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

- (NSMutableArray<NSNumber *> *)droppedSections {
    if (!_droppedSections) {
        _droppedSections = [[NSMutableArray<NSNumber*> alloc] init];
    }
    return _droppedSections;
}

- (UIRefreshControl *)refreshControl {
    if (!_refreshControl) {
        _refreshControl = [[UIRefreshControl alloc] init];
        _refreshControl.tintColor = UIColor.darkBlueGreenColor;
        NSAttributedString *title = [[NSAttributedString alloc] initWithString: @"Loading Countries.."
                                                                    attributes: @{NSForegroundColorAttributeName:UIColor.darkBlueGreenColor}];
        _refreshControl.attributedTitle = title;
    }
    return _refreshControl;
}

- (SortOptionsViewController *)sortOptionsAlertController {
    if (!_sortOptionsAlertController) {
        _sortOptionsAlertController = [SortOptionsViewController alertControllerWithTitle: @"Countries's Categories"
                                                                          message: @"select an option for sorting"
                                                                   preferredStyle: UIAlertControllerStyleActionSheet];
    }
    return _sortOptionsAlertController;
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

-(void)setCategories:(NSArray *)categories {
    _categories = categories;
    [self.droppedSections removeAllObjects];
    [self.collectionView reloadData];
}

-(void)setCountries:(NSArray<NSArray<Country *> *> *)countries {
    _countries = countries;
    [self.droppedSections removeAllObjects];
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
        [self.refreshControl endRefreshing];
    }];
    [input.countriesSubject subscribeNext:^(NSArray<NSArray<Country *> *> *countries) {
        @strongify(self)
        self.countries = countries;
        [self.refreshControl endRefreshing];
    }];
    [[self.refreshControl rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(id x) {
        @strongify(self)
        [self.input requestRefreshData];
    }];
    [self.sortOptionsAlertController.selectedCategorySubject subscribeNext:^(NSNumber *x) {
        @strongify(self)
        [self.input setSelectedCategory:(CountryCategory)([x intValue])];
    }];
    [[self rac_signalForSelector:@selector(collectionView:didSelectItemAtIndexPath:)] subscribeNext:^(RACTuple* x) {
        @strongify(self)
        if ([x[1] isKindOfClass: [NSIndexPath class]]){
            NSIndexPath *selectedIndexPath = (NSIndexPath *)x[1];
            [self.input selectedCountry:self.countries[selectedIndexPath.section][selectedIndexPath.row]];
        }
    }];
}

static NSString *CellIdentifier = @"Cell";
static NSString *HeaderIdentifier = @"Cell";
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.headerReferenceSize = CGSizeMake(_collectionView.frame.size.width, 70);
        _collectionView = [[UICollectionView alloc] initWithFrame: CGRectZero
                                             collectionViewLayout: flowLayout];
        _collectionView.backgroundColor = UIColor.clearColor;
        _collectionView.alwaysBounceVertical = YES;
        [_collectionView registerClass:[CountriesCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderIdentifier];
        [_collectionView registerClass:[CountryCollectionViewCell class]
            forCellWithReuseIdentifier:CellIdentifier];
        _collectionView.contentInset = UIEdgeInsetsMake(58, 8, 8, 8);
        [_collectionView addSubview: self.refreshControl];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.lightGrayColor;
    [self.view addSubview: self.mapView];
    [self.view addSubview: self.collectionView];
}

-(void)viewWillAppear:(BOOL)animated {
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

- (void)showSortOption {
    [self presentViewController: self.sortOptionsAlertController
                       animated: YES
                     completion: nil];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.categories count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSNumber *sectionNumber = [NSNumber numberWithInteger:section];
    if ([self.droppedSections containsObject:sectionNumber]) {
        return [self.countries[section] count];
    }else{
        return MIN([self.countries[section] count], 3);
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CountryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.country = self.countries[indexPath.section][indexPath.row];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    CountriesCollectionHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind: UICollectionElementKindSectionHeader withReuseIdentifier:HeaderIdentifier forIndexPath:indexPath];
    view.categoryName = self.categories[indexPath.section];
    view.dropDownButton.tag = indexPath.section;
    [view.dropDownButton setTitle:[self.droppedSections containsObject:[NSNumber numberWithInteger:indexPath.section]] ? @"▲" : @"▼"
                         forState:UIControlStateNormal];
    [view.dropDownButton addTarget:self action:@selector(didTapHeaderButton:) forControlEvents:UIControlEventTouchUpInside];
    return view;
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

- (void)didTapHeaderButton: (UIButton *)sender {
    NSNumber *section = [NSNumber numberWithInteger: sender.tag];
    if ([self.droppedSections containsObject: section]) {
        [self.droppedSections removeObject:section];
    }else{
        [self.droppedSections addObject:section];
    }
    [self.collectionView reloadData];
}

@end
