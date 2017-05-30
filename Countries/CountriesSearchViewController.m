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
#import <ChameleonFramework/Chameleon.h>

@interface CountriesSearchViewController ()

@property (strong, nonatomic) NSArray<Country *> *countries;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UIImageView *mapView;
@property (strong, nonatomic) UILabel *searchInstructionsLabel;

@end

@implementation CountriesSearchViewController

@synthesize countries = _countries;

#pragma mark - Private

-(NSArray<Country *> *)countries {
    if (!_countries) {
        _countries = @[];
    }
    return _countries;
}

-(void)setCountries:(NSArray<Country*> *)countries {
    _countries = countries;
    [self.collectionView reloadData];
    self.collectionView.hidden = _countries.count == 0;
    self.searchInstructionsLabel.hidden = _countries.count != 0;
}

#pragma mark - Private Subviews

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
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame: CGRectZero
                                             collectionViewLayout: flowLayout];
        _collectionView.backgroundColor = UIColor.clearColor;
        _collectionView.alwaysBounceVertical = YES;
        [_collectionView registerClass:[CountryCollectionViewCell class]
            forCellWithReuseIdentifier:CellIdentifier];
        _collectionView.contentInset = UIEdgeInsetsMake(78, 8, 8, 8);
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
        _collectionView.hidden = YES;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

-(UILabel *)searchInstructionsLabel {
    if (!_searchInstructionsLabel) {
        _searchInstructionsLabel = [[UILabel alloc] init];
        _searchInstructionsLabel.textAlignment = NSTextAlignmentCenter;
        _searchInstructionsLabel.numberOfLines = 0;
        _searchInstructionsLabel.textColor = UIColor.darkGrayColor;
        _searchInstructionsLabel.text = @"Search for a Country.";
        _searchInstructionsLabel.textColor = UIColor.whiteColor;
    }
    return _searchInstructionsLabel;
}

#pragma mark - Input Binding

- (void)setInput:(id<CountriesSearchInput>)input {
    _input = input;
    @weakify(self)
    [input.countriesSubject subscribeNext:^(NSArray<Country *> *countries) {
        @strongify(self)
        self.countries = countries;
        [self hideProgress];
    }];
    [input.searchTextSubject subscribeNext:^(id x) {
        @strongify(self)
        [self showProgress];
    }];
    [[self rac_signalForSelector:@selector(collectionView:didSelectItemAtIndexPath:)] subscribeNext:^(RACTuple* x) {
        @strongify(self)
        if ([x[1] isKindOfClass: [NSIndexPath class]]){
            NSIndexPath *selectedIndexPath = (NSIndexPath *)x[1];
            [self.input didSelectCountry: self.countries[selectedIndexPath.row]];
        }
    }];
}

#pragma mark - Lifecycle

-(void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.view.backgroundColor = [UIColor colorWithGradientStyle:UIGradientStyleTopToBottom
                                                      withFrame:self.view.frame
                                                      andColors:@[UIColor.darkGrayColor,
                                                                  UIColor.whiteColor]];
    [self.view addSubview: self.mapView];
    [self.view addSubview: self.searchInstructionsLabel];
    [self.view addSubview: self.collectionView];
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
    [self.searchInstructionsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.centerY.mas_equalTo(self.view).mas_offset(-0.8);
        make.width.mas_equalTo(self.view).multipliedBy(0.8);
    }];
}

#pragma mark - Collectionview Delegates

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
