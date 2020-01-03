//
//  ViewController.m
//  ScrollViewTest
//
//  Created by kluv on 03/01/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) UITextField* activeField;
@property (assign, nonatomic) CGPoint lastOffset;

@property (assign, nonatomic) CGFloat keyboardHeight;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textFieldA.delegate = self;
    self.textFieldB.delegate = self;
    self.textFieldC.delegate = self;
    
    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [nc addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    self.activeField = textField;
    
    self.lastOffset = self.scrollView.contentOffset;
    
    return YES;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self.activeField resignFirstResponder];
    self.activeField = nil;
    
    return YES;
    
}

- (void) keyboardWillShow:(NSNotification*) notification {
    
    if (self.keyboardHeight != 0) {
        return;
    }
    
    NSDictionary* info = [notification userInfo];
    
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    self.keyboardHeight = keyboardSize.height;
    
    NSLog(@"%f", self.keyboardHeight);
    
    CGFloat distanceToBottom = self.scrollView.frame.size.height - self.activeField.frame.origin.y - self.activeField.frame.size.height;
    
    CGFloat collapseSpace = self.keyboardHeight - distanceToBottom;
    
    if (collapseSpace < 0) {
        return;
    }
    
    [UIView animateWithDuration:0.3f
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
        
        self.contstraintContentHeight.constant += self.keyboardHeight;
        
    } completion:^(BOOL finished) {
    }];
    
    
    [UIView animateWithDuration:0.3f
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
        
        self.scrollView.contentOffset = CGPointMake(self.lastOffset.x, collapseSpace + 10);
        
    } completion:^(BOOL finished) {
    }];
    
}

- (void) keyboardWillHide:(NSNotification*) notofication {
    
    [UIView animateWithDuration:0.3f
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
        
        self.contstraintContentHeight.constant -=  self.keyboardHeight;
        self.scrollView.contentOffset = self.lastOffset;
        
    } completion:^(BOOL finished) {
    }];
    
    self.keyboardHeight = 0;
    
}


@end
