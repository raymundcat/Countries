//
//  CountryDetailsViewController.m
//  Countries
//
//  Created by John Raymund Catahay on 27/05/2017.
//  Copyright © 2017 John Raymund Catahay. All rights reserved.
//

#import "CountryDetailsViewController.h"
#import "UIColor+Countries.h"
#import <Masonry/Masonry.h>
#import "CountryDetailTableViewCell.h"
#import "CountryMainDetailsTableViewCell.h"

@interface CountryDetailsViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *mapView;
@property (nonatomic, strong) NSArray<NSNumber *> *detailTypes;

@end

@implementation CountryDetailsViewController

@synthesize country = _country;

- (NSArray<NSNumber *> *)detailTypes {
    if (!_detailTypes) {
        NSMutableArray<NSNumber *> *detailTypesMutable = [[NSMutableArray<NSNumber *> alloc] init];
        for (int i = CountryDetailTypeNativeName; i<= CountryDetailTypeRegionalBlocks; i++) {
            [detailTypesMutable addObject: [NSNumber numberWithInt:i]];
        }
        _detailTypes = [NSArray arrayWithArray:detailTypesMutable];
    }
    return _detailTypes;
}

static NSString *HeaderCellIdentifier = @"HeaderCell";
static NSString *DetailCellIdentifier = @"DetailCell";
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.alwaysBounceHorizontal = NO;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.backgroundColor = UIColor.clearColor;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 20;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[CountryDetailTableViewCell class]
           forCellReuseIdentifier:DetailCellIdentifier];
        [_tableView registerClass:[CountryMainDetailsTableViewCell class]
           forCellReuseIdentifier:HeaderCellIdentifier];
        _tableView.contentInset = UIEdgeInsetsMake(68, 0, 24, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(UIImageView *)mapView {
    if (!_mapView) {
        _mapView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _mapView.image = [UIImage imageNamed:@"worldmap"];
        _mapView.contentMode = UIViewContentModeScaleAspectFill;
        _mapView.alpha = 0.3;
    }
    return _mapView;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.lightBlueGreenColor;
    [self.view addSubview: self.mapView];
    [self.view addSubview: self.tableView];
}

-(void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    CAGradientLayer *gradient = [UIColor gradientWithColors:@[(id)UIColor.skyBlueColor.CGColor,
                                                              (id)UIColor.lightBlueGreenColor.CGColor]
                                                    forRect:self.view.bounds];
    [self.view.layer insertSublayer:gradient atIndex:0];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else{
        return [self.detailTypes count];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        CountryMainDetailsTableViewCell *cell = (CountryMainDetailsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:HeaderCellIdentifier
                                                                                                                   forIndexPath:indexPath];
        cell.country = self.country;
        return cell;
    }else{
        CountryDetailTableViewCell *cell = (CountryDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:DetailCellIdentifier
                                                                                                         forIndexPath:indexPath];
        cell.detailLabel.text = [Country readableNameOfDetailType:(CountryDetailType)[self.detailTypes[indexPath.row] intValue]];
        cell.detailValueLabel.text = [[self.country valuesForDetail: (CountryDetailType)[self.detailTypes[indexPath.row] intValue]] componentsJoinedByString:@", "];
        return cell;
    }
}

@end
