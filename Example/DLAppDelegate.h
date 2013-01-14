//
//  DLAppDelegate.h
//  DLIDEKeyboard
//
//  Created by Denis Lebedev on 1/14/13.
//  Copyright (c) 2013 Denis Lebedev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DLViewController;

@interface DLAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) DLViewController *viewController;

@end
