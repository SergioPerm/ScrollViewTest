//
//  ViewController.h
//  ScrollViewTest
//
//  Created by kluv on 03/01/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textFieldA;
@property (weak, nonatomic) IBOutlet UITextField *textFieldB;
@property (weak, nonatomic) IBOutlet UITextField *textFieldC;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contstraintContentHeight;

@end

