//
//  DLViewController.m
//  DLIDEKeyboard
//
//  Created by Denis Lebedev on 1/14/13.
//  Copyright (c) 2013 Denis Lebedev. All rights reserved.
//

#import "DLViewController.h"
#import "DLIDEKeyboardView.h"

@interface DLViewController ()

@end

@implementation DLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:self.view.bounds];
    [DLIDEKeyboardView attachToTextView:textView];

	[textView setText:@"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum purus magna, gravida non gravida nec, dapibus at lectus. Aliquam hendrerit lorem sed quam mattis posuere sit amet ac urna. Nam placerat dignissim ligula quis pretium. Vivamus laoreet sem et dolor suscipit mollis. Maecenas feugiat nisi a massa elementum vitae bibendum libero iaculis. Vivamus euismod eros a lectus vestibulum porttitor. Donec elementum arcu sit amet mi auctor molestie. Integer pulvinar orci a neque placerat congue. Integer id ultrices nisi. Nullam sit amet dolor ipsum, eget vehicula mauris. Nulla sollicitudin, orci quis pharetra laoreet, magna turpis cursus lacus, ac malesuada ipsum enim et est. Mauris non mi at leo condimentum malesuada. Donec a facilisis metus. Nullam dictum, ante non ultrices sagittis, mi elit bibendum ligula, in tincidunt mi turpis nec nisl. Nulla molestie viverra ipsum eu consequat. Sed mauris erat, vestibulum vel vulputate at, sagittis at nibh.\n\nMorbi tempus scelerisque lectus sit amet posuere. Morbi dictum ullamcorper scelerisque. Morbi eu condimentum felis. Donec rutrum feugiat dolor et bibendum. Mauris turpis sapien, molestie eu laoreet eget, tincidunt at sem. Sed interdum, erat at pharetra adipiscing, orci sem laoreet odio, sit amet fermentum eros urna egestas urna. Vivamus tortor enim, iaculis tristique pulvinar sed, molestie vel orci."];
	[self.view addSubview:textView];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 240, 400, 300)];
    textField.text = @"Lorem ipsum";
    textField.backgroundColor = [UIColor redColor];
    [self.view addSubview:textField];
    [DLIDEKeyboardView attachToTextView:textField];
	[textView becomeFirstResponder];
}


@end
