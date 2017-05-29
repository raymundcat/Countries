//
//  CountriesSearchViewController.h
//  Countries
//
//  Created by John Raymund Catahay on 25/05/2017.
//  Copyright © 2017 John Raymund Catahay. All rights reserved.
//

#import "BaseViewController.h"
#import "CountriesSearchInput.h"

@interface CountriesSearchViewController : BaseViewController<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) id <CountriesSearchInput> input;

@end
