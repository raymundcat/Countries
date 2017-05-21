//
//  AppDelegate.m
//  Countries
//
//  Created by John Raymund Catahay on 18/05/2017.
//  Copyright © 2017 John Raymund Catahay. All rights reserved.
//

#import "AppDelegate.h"
#import "InitialFlowController.h"

@interface AppDelegate ()

@property (strong, nonatomic) InitialFlowController *initialFlowController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.initialFlowController = [[InitialFlowController alloc] initWithWindow:self.window];
    [self.initialFlowController start];
    
    return YES;
}

@end
