//
//  DLIDEKeyboardView.h
//  DLIDEKeyboard
//
//  Created by Denis Lebedev on 1/14/13.
//  Copyright (c) 2013 Denis Lebedev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLIDEKeyboardView : UIView

+ (void)attachToTextView:(id<UITextInput>)textView;

@end
