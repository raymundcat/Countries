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
#import <ChameleonFramework/Chameleon.h>

@interface CountryDetailsViewController ()

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIImageView *mapView;
@property (strong, nonatomic) NSArray<NSNumber *> *detailTypes;

@end

@implementation CountryDetailsViewController

#pragma mark - Private

@synthesize country = _country;

-(Country *)country {
    if (!_country) {
        _country = [Country blankCountry];
    }
    return _country;
}

- (NSArray<NSNumber *> *)detailTypes {
    if (!_detailTypes) {
        NSMutableArray<NSNumber *> *detailTypesMutable = [[NSMutableArray<NSNumber *> alloc] init];
        for (int i = CountryDetailTypeNativeName; i<= CountryDetailTypeRegionalBlocs; i++) {
            [detailTypesMutable addObject: @(i)];
        }
        _detailTypes = [NSArray arrayWithArray:detailTypesMutable];
    }
    return _detailTypes;
}

#pragma mark - Private Subviews

static NSString *HeaderCellIdentifier = @"HeaderCellIdentifier";
static NSString *DetailCellIdentifier = @"DetailCellIdentifier";
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
        _tableView.contentInset = UIEdgeInsetsMake(58, 0, 24, 0);
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

#pragma mark - Public

- (RACSubject *)didPressFlagSubject {
    if (!_didPressFlagSubject) {
        _didPressFlagSubject = [RACSubject subject];
    }
    return _didPressFlagSubject;
}

#pragma mark - Lifecycle

-(void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.skyBlueColor;
    self.view.backgroundColor = [UIColor colorWithGradientStyle:UIGradientStyleTopToBottom
                                                      withFrame:self.view.frame
                                                      andColors:@[UIColor.skyBlueColor,
                                                                  UIColor.lightBlueGreenColor]];
    [self.view addSubview: self.mapView];
    [self.view addSubview: self.tableView];
    [self initLayout];
}

-(void)initLayout {
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}


-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

#pragma mark - Tableview Delegates

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
        [cell.didTapFlagSubject subscribe:self.didPressFlagSubject];
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
