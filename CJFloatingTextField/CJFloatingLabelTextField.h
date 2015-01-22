// The MIT License (MIT)
//
// Copyright (c) 2015 CoinJar
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <UIKit/UIKit.h>

@interface CJFloatingLabelTextField : UIView

@property (nonatomic, strong) UIColor *inactiveColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *activeColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *activeBackgroundColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *inActiveBackgroundColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *borderColor UI_APPEARANCE_SELECTOR;

@property (nonatomic, strong) UIFont *textFieldFont UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont *labelFont UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont *secureShowHideButtonFont UI_APPEARANCE_SELECTOR;

@property (nonatomic, strong, readonly) UIView *topBorderView; //Hidden by default
@property (nonatomic, strong, readonly) UIView *bottomBorderView; //Hidden by default
@property (nonatomic, strong, readonly) UIImageView *textImageView;
@property (nonatomic, strong, readonly) UILabel *displayLabel;
@property (nonatomic, strong, readonly) UITextField *textField;

@property (nonatomic, strong, readonly) UIButton *secureShowHideButton;
@property (nonatomic, strong) NSString *localizedShowString;
@property (nonatomic, strong) NSString *localizedHideString;

@property (nonatomic, weak) id <UITextFieldDelegate> delegate;

@property (nonatomic, assign) BOOL secureTextEntry;

- (void)setActiveImage:(UIImage *)activeImage inactiveImage:(UIImage *)inactiveImage;
- (void)shouldShowTopBorder:(BOOL)showTopBorder showBottomBorder:(BOOL)showBottomBorder;

- (void)showContentsAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
- (void)hideContentsAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion;

@end
