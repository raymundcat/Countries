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
#import <ChameleonFramework/Chameleon.h>

@interface CountriesListViewController ()

@property (strong, nonatomic) NSArray<NSString *> *categories;
@property (strong, nonatomic) NSArray<NSArray<Country *> *> *countries;
@property (strong, nonatomic) NSMutableArray<NSNumber *> *droppedSections;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (strong, nonatomic) SortOptionsViewController *sortOptionsAlertController;
@property (strong, nonatomic) UIImageView *mapView;

@end

@implementation CountriesListViewController

@synthesize categories = _categories;
@synthesize countries = _countries;

#pragma mark - Private

- (NSArray *)categories {
    if (!_categories) {
        _categories = @[];
    }
    return _categories;
}

-(void)setCategories:(NSArray *)categories {
    _categories = categories;
    [self.droppedSections removeAllObjects];
    [self.collectionView reloadData];
}

-(NSArray<NSArray<Country *> *> *)countries {
    if (!_countries) {
        _countries = @[];
    }
    return _countries;
}

-(void)setCountries:(NSArray<NSArray<Country *> *> *)countries {
    _countries = countries;
    [self.droppedSections removeAllObjects];
    [self.collectionView reloadData];
}

- (NSMutableArray<NSNumber *> *)droppedSections {
    if (!_droppedSections) {
        _droppedSections = [[NSMutableArray<NSNumber*> alloc] init];
    }
    return _droppedSections;
}

#pragma mark - Private Subviews

- (UIRefreshControl *)refreshControl {
    if (!_refreshControl) {
        _refreshControl = [[UIRefreshControl alloc] init];
        _refreshControl.tintColor = UIColor.whiteColor;
        NSAttributedString *title = [[NSAttributedString alloc] initWithString: @"Loading Countries.."
                                                                    attributes: @{NSForegroundColorAttributeName:UIColor.whiteColor}];
        _refreshControl.attributedTitle = title;
    }
    return _refreshControl;
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

static NSString *CellIdentifier = @"CellIdentifier";
static NSString *HeaderIdentifier = @"HeaderIdentifier";
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

- (SortOptionsViewController *)sortOptionsAlertController {
    if (!_sortOptionsAlertController) {
        _sortOptionsAlertController = [SortOptionsViewController alertControllerWithTitle: @"Countries's Categories"
                                                                                  message: @"select an option for sorting"
                                                                           preferredStyle: UIAlertControllerStyleActionSheet];
    }
    return _sortOptionsAlertController;
}

#pragma mark - Input Bindings

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
        [self hideProgress];
    }];
    [[self.refreshControl rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(id x) {
        @strongify(self)
        [self.input requestRefreshData];
        [self.refreshControl endRefreshing];
        [self showProgress];
    }];
    [self.sortOptionsAlertController.selectedCategorySubject subscribeNext:^(NSNumber *x) {
        @strongify(self)
        [self.input setSelectedCategory:(CountryCategory)([x intValue])];
    }];
    [[self rac_signalForSelector:@selector(collectionView:didSelectItemAtIndexPath:)] subscribeNext:^(RACTuple* x) {
        @strongify(self)
        if ([x[1] isKindOfClass: [NSIndexPath class]]){
            NSIndexPath *selectedIndexPath = (NSIndexPath *)x[1];
            [self.input didSelectCountry:self.countries[selectedIndexPath.section][selectedIndexPath.row]];
        }
    }];
}

- (void)showSortOption {
    [self presentViewController: self.sortOptionsAlertController
                       animated: YES
                     completion: nil];
}

#pragma mark - Lifecycle

-(void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.lightBlueGreenColor;
    [self.view addSubview: self.mapView];
    [self.view addSubview: self.collectionView];
    self.view.backgroundColor = [UIColor colorWithGradientStyle:UIGradientStyleTopToBottom
                                                      withFrame:self.view.frame
                                                      andColors:@[UIColor.darkBlueGreenColor, UIColor.lightBlueGreenColor]];
    [self initLayout];
}

- (void)initLayout {
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

#pragma mark - Collectionview Delegates

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.categories count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSNumber *sectionNumber = @(section);
    if ([self.droppedSections containsObject:sectionNumber] || self.categories.count == 1) {
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
    [view.dropDownButton setTitle:[self.droppedSections containsObject:@(indexPath.section)] ? @"▲" : @"▼"
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
    NSNumber *section = @(sender.tag);
    if ([self.droppedSections containsObject: section]) {
        [self.droppedSections removeObject:section];
    }else{
        [self.droppedSections addObject:section];
    }
    [self.collectionView reloadData];
}

@end
