//
//  SortOptionsViewController.h
//  Countries
//
//  Created by John Raymund Catahay on 25/05/2017.
//  Copyright © 2017 John Raymund Catahay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface SortOptionsViewController : UIAlertController

@property (nonatomic, strong, readonly) RACSubject *selectedCategorySubject;

@end
