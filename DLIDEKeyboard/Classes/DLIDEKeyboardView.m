//
//  DLIDEKeyboardView.m
//  DLIDEKeyboard
//
//  Created by Denis Lebedev on 1/14/13.
//  Copyright (c) 2013 Denis Lebedev. All rights reserved.
//

#import "DLIDEKeyboardView.h"

#define IS_IPAD UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad

@interface DLIDEKeyboardView () {
    NSArray *_keys;
}

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) NSArray *keys;
@property (nonatomic, assign) NSInteger selectedRow;
@end

@implementation DLIDEKeyboardView

+ (void)attachToTextView:(UITextView *)textView {    
    DLIDEKeyboardView *view = [[DLIDEKeyboardView alloc] init];
    view.textView = textView;
    textView.inputAccessoryView = view;
}

- (id)init {
    if (self = [super init]) {
        CGFloat kKeyboardWidth = IS_IPAD ? 768.f : 320.f;
        CGFloat kKeyboardHeight = IS_IPAD ? 104.f : 34.f;
        self.frame = CGRectMake(0, 0, kKeyboardWidth, kKeyboardHeight);

        self.backgroundColor = IS_IPAD ? [UIColor colorWithRed:156/255. green:155/255. blue:166/255. alpha:1.] :
        [UIColor colorWithRed:125/255.f green:132/255.f blue:146/255.f alpha:1.f];
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        NSInteger kRows = IS_IPAD ? 2 : 1;
        NSInteger kKeysInRow = IS_IPAD ? 14 : 10;
        CGFloat kLeftPadding = 3.f;
        CGFloat kTopPadding = 3.f;
        CGFloat kSpacing =  IS_IPAD ? 5.f : 2.f;
        NSInteger kButtonWidth = (kKeyboardWidth - 2 * kLeftPadding - (kKeysInRow - 1) * kSpacing) / kKeysInRow;
        kLeftPadding = (kKeyboardWidth - kButtonWidth * kKeysInRow - kSpacing * (kKeysInRow - 1)) / 2;
                
        if (IS_IPAD) {
            _keys = @[
            @[@"->", @"{", @"}", @"[", @"]", @"(", @")", @">",@"<", @"@", @"'", @"\"", @":", @"_"],
            @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0", @"+", @"-", @"/", @"*"]];
        } else {
            _keys = @[
            @[@"k", @"{", @"}", @"[", @"]", @"(", @")", @">",@"<", @".."],
            @[@"+", @"-", @"/", @"*",@"=", @"@", @"\"", @":", @"_", @".."]];
        }
        
        for (int i = 0; i < kRows; i++) {
            for (int j = 0; j < kKeysInRow; j++) {
                UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
                b.tag = j + 100;
                [b addTarget:self action:@selector(handleTap:) forControlEvents:UIControlEventTouchUpInside];
                [b setTitle:_keys[i][j] forState:UIControlStateNormal];
                [b setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [b setBackgroundImage:[UIImage imageNamed:@"key"] forState:UIControlStateNormal];
                [b setBackgroundImage:[UIImage imageNamed:@"key-pressed"] forState:UIControlStateHighlighted];
                b.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
                b.frame = CGRectMake(kLeftPadding + j*(kButtonWidth + kSpacing), kTopPadding + i*kButtonWidth, kButtonWidth, kButtonWidth);
                [self addSubview:b];
            }
        }
    }
    return self;
}

- (void)handleTap:(UIButton *)button {
    NSString *input = button.titleLabel.text;
    if ([input isEqualToString:@"k"]) {
        [self.textView resignFirstResponder];
        return;
    }
    if ([input isEqualToString:@".."]) {
        self.selectedRow = self.selectedRow == 1 ? 0 : 1;
        [self refreshButtons];
        return;
    }
    [self.textView insertText:input];
}

- (void)refreshButtons {
    for (int j = 0; j < 10; j++) {
        UIButton *b = (UIButton *)[self viewWithTag:j + 100];
        [b setTitle:_keys[self.selectedRow][j] forState:UIControlStateNormal];
    }
}


@end
