//
//  BaseViewController.h
//  Countries
//
//  Created by John Raymund Catahay on 20/05/2017.
//  Copyright © 2017 John Raymund Catahay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface BaseViewController : UIViewController

@property (strong, nonatomic) RACSignal *viewDidLoadSignal;

- (void)showProgress;
- (void)hideProgress;

@end
