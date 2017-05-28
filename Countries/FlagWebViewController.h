//
//  WebViewController.h
//  Countries
//
//  Created by John Raymund Catahay on 28/05/2017.
//  Copyright © 2017 John Raymund Catahay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "Country.h"

@interface FlagWebViewController : BaseViewController<UIWebViewDelegate>

- (void)loadCountry: (Country *)country;

@end
