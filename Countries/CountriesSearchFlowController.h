//
//  CountriesSearchFlowController.h
//  Countries
//
//  Created by John Raymund Catahay on 22/05/2017.
//  Copyright © 2017 John Raymund Catahay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FlowController.h"

@interface CountriesSearchFlowController : NSObject <FlowController, UISearchBarDelegate>

- (id)initWithNavigationController: (UINavigationController *) navigationController;

@end
