//
//  CountriesCollectionHeaderView.h
//  Countries
//
//  Created by John Raymund Catahay on 23/05/2017.
//  Copyright © 2017 John Raymund Catahay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountriesCollectionHeaderView : UICollectionReusableView

@property (nonatomic, strong) NSString *categoryName;
@property (nonatomic, strong, readonly) UIButton *dropDownButton;

@end
