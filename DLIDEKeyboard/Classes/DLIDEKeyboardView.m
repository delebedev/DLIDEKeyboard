//
//  DLIDEKeyboardView.m
//  DLIDEKeyboard
//
//  Created by Denis Lebedev on 1/14/13.
//  Copyright (c) 2013 Denis Lebedev. All rights reserved.
//

#import "DLIDEKeyboardView.h"

#define IS_IPAD UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad

NSString *const kHideKeyBoardKey = @"k";
NSString *const kTabKey = @"\u279D";
NSString *const kFirstRowKey = @"\u25D0";
NSString *const kSecondRowKey = @"\u25D1";

@interface DLIDEKeyboardView () <UIInputViewAudioFeedback> {
    NSArray *_keys;
    NSInteger _kKeysInRow;
}

@property (nonatomic, strong) id<UITextInput> textView;
@property (nonatomic, strong) NSArray *keys;
@property (nonatomic, assign) NSInteger selectedRow;
@end

@implementation DLIDEKeyboardView

#pragma mark - Public

+ (void)attachToTextView:(UIResponder<UITextInput> *)textView {
    DLIDEKeyboardView *view = [[DLIDEKeyboardView alloc] init];
    if (![textView respondsToSelector:@selector(setInputAccessoryView:)]) {
        [NSException raise:@"Keyboard can be attached only to text inputs" format:nil];
    }
    view.textView = textView;
    [(id)textView setInputAccessoryView:view];
}

#pragma mark - NSObject

- (id)init {
    if (self = [super init]) {
        CGFloat kKeyboardWidth = IS_IPAD ? 768.f : 320.f;
        CGFloat kKeyboardHeight = IS_IPAD ? 104.f : 34.f;
        self.frame = CGRectMake(0, 0, kKeyboardWidth, kKeyboardHeight);

        UIView *border1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kKeyboardWidth, 1)];
        border1.backgroundColor = [UIColor colorWithRed:51/255. green:51/255. blue:51/255. alpha:1.];
        border1.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addSubview:border1];
        
        UIView *border2 = [[UIView alloc] initWithFrame:CGRectMake(0, 1, kKeyboardWidth, 1)];
        border2.backgroundColor = [UIColor colorWithRed:191/255. green:191/255. blue:191/255. alpha:1.];
        border2.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addSubview:border2];
        
        self.backgroundColor = IS_IPAD ? [UIColor colorWithRed:156/255. green:155/255. blue:166/255. alpha:1.] :
        [UIColor colorWithRed:125/255.f green:132/255.f blue:146/255.f alpha:1.f];
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        NSInteger kRows = IS_IPAD ? 2 : 1;
        _kKeysInRow = IS_IPAD ? 14 : 10;
        CGFloat kLeftPadding = 3.f;
        CGFloat kTopPadding = 4.f;
        CGFloat kSpacing =  IS_IPAD ? 5.f : 2.f;
        NSInteger kButtonWidth = (kKeyboardWidth - 2 * kLeftPadding - (_kKeysInRow - 1) * kSpacing) / _kKeysInRow;
        kLeftPadding = (kKeyboardWidth - kButtonWidth * _kKeysInRow - kSpacing * (_kKeysInRow - 1)) / 2;
                
        if (IS_IPAD) {
            _keys = @[
            @[kTabKey, @"{", @"}", @"[", @"]", @"(", @")", @">",@"<", @"@", @"'", @"\"", @":", @"_"],
            @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0", @"+", @"-", @"/", @"*"]];
        } else {
            _keys = @[
            @[kHideKeyBoardKey, @"+", @"-", @"/", @"*",@"=", @"@", @"\"", @":", kFirstRowKey],
            @[@"{", @"}", @"[", @"]", @"(", @")", @">",@"<", @"_", kSecondRowKey]];
        }
        
        for (int i = 0; i < kRows; i++) {
            for (int j = 0; j < _kKeysInRow; j++) {
                UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
                b.tag = j + 100;
                b.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
                b.frame = CGRectMake(kLeftPadding + j*(kButtonWidth + kSpacing), kTopPadding + i*kButtonWidth, kButtonWidth, kButtonWidth);
                [b addTarget:self action:@selector(handleTap:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:b];
                
                [b setTitle:_keys[i][j] forState:UIControlStateNormal];
                [b setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                if (_keys[i][j] == kSecondRowKey || _keys[i][j] == kFirstRowKey) {
                    [b setBackgroundImage:[UIImage imageNamed:@"key-blue"] forState:UIControlStateNormal];
                } else {
                    [b setBackgroundImage:[UIImage imageNamed:@"key"] forState:UIControlStateNormal];
                }
                [b setImage:_keys[i][j] == kHideKeyBoardKey ? [UIImage imageNamed:@"keyboard"] : nil forState:UIControlStateNormal];
                [b setBackgroundImage:[UIImage imageNamed:@"key-pressed"] forState:UIControlStateHighlighted];
            }
        }
        [self refreshButtons];
    }
    return self;
}

#pragma mark - Private

- (void)handleTap:(UIButton *)button {
    [[UIDevice currentDevice] playInputClick];
    NSString *input = button.titleLabel.text;
    if ([input isEqualToString:kHideKeyBoardKey]) {
        [(id)self.textView resignFirstResponder];
    } else if ([input isEqualToString:kTabKey]) {
        [self.textView insertText:@"  "];
        return;
    } else if ([input isEqualToString:kFirstRowKey] || [input isEqualToString:kSecondRowKey]) {
        self.selectedRow = self.selectedRow == 1 ? 0 : 1;
        [self refreshButtons];
        return;
    } else {
        [self.textView insertText:input];
    }
}

- (void)refreshButtons {
    for (int j = 0; j < _kKeysInRow; j++) {
        UIButton *b = (UIButton *)[self viewWithTag:j + 100];
        [b setImage:_keys[self.selectedRow][j] == kHideKeyBoardKey ? [UIImage imageNamed:@"keyboard"] : nil forState:UIControlStateNormal];
        [b setTitle:_keys[self.selectedRow][j] forState:UIControlStateNormal];
    }
}

#pragma mark - UIInputViewAudioFeedback

- (BOOL)enableInputClicksWhenVisible {
    return YES;
}


@end
