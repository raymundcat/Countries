//
//  CountriesListViewController.h
//  Countries
//
//  Created by John Raymund Catahay on 20/05/2017.
//  Copyright © 2017 John Raymund Catahay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "CountriesListInput.h"

@interface CountriesListViewController : BaseViewController<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) id <CountriesListInput> input;

- (void)showSortOption;

@end
