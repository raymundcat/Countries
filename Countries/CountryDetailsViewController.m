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

@interface CountryDetailsViewController ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation CountryDetailsViewController

static NSString *CellIdentifier = @"Cell";
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.alwaysBounceHorizontal = NO;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.backgroundColor = UIColor.clearColor;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 20;
        [_tableView registerClass:[CountryDetailTableViewCell class]
           forCellReuseIdentifier:CellIdentifier];
        _tableView.contentInset = UIEdgeInsetsMake(24, 0, 24, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.lightBlueGreenColor;
    [self.view addSubview: self.tableView];
}

-(void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CountryDetailTableViewCell *cell = (CountryDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                                       forIndexPath:indexPath];
    return cell;
}

@end
