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

#import "CJFloatingLabelTextField.h"
#import <Masonry/Masonry.h>

@implementation NSString (CJExtensions)

- (BOOL)isEmpty
{
    return ![self length];
}


- (BOOL)isEmptyOrWhitespace
{
    return [self isEmpty] || ![[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length];
}

@end

@interface CJFloatingLabelTextField() <UITextFieldDelegate>

@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;

@property (nonatomic, assign) BOOL textFieldActive;
@property (nonatomic, assign) BOOL displayLabelShouldShrink;

@property (nonatomic, strong) UIImage *activeImage;
@property (nonatomic, strong) UIImage *inactiveImage;

- (void)setDefaultColors;

@end

@implementation CJFloatingLabelTextField
@synthesize textImageView = _textImageView;
@synthesize displayLabel = _displayLabel;
@synthesize textField = _textField;
@synthesize secureShowHideButton = _secureShowHideButton;
@synthesize bottomBorderView = _bottomBorderView;
@synthesize topBorderView = _topBorderView;

#pragma mark -
#pragma mark - Init Methods
- (id)init
{
    self = [super init];
    if (self)
    {
        [self performSetup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        [self performSetup];
    }
    return self;
}

- (void)performSetup
{
    self.textFieldActive = NO;
    self.displayLabelShouldShrink = NO;
    _secureTextEntry = NO;
    [self setDefaultColors];
    [self setDefaultFonts];
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:self.textImageView];
    [self addSubview:self.displayLabel];
    [self addSubview:self.textField];
    [self addSubview:self.secureShowHideButton];
    [self addSubview:self.topBorderView];
    [self addSubview:self.bottomBorderView];
    
    self.localizedShowString = NSLocalizedString(@"Show", @"");
    self.localizedHideString = NSLocalizedString(@"Hide", @"");
    
    self.backgroundColor = self.inActiveBackgroundColor;
    
    _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [self addGestureRecognizer:self.tapGestureRecognizer];
}

- (void)setDefaultColors
{
    self.inactiveColor = [UIColor grayColor];
    self.activeColor = [UIColor blackColor];
    self.activeBackgroundColor = [UIColor clearColor];
    self.inActiveBackgroundColor = [UIColor clearColor];
    self.borderColor = [UIColor blackColor];
}

- (void)setDefaultFonts
{
    self.textFieldFont = [UIFont boldSystemFontOfSize:14];
    self.labelFont = [UIFont systemFontOfSize:14];
    self.secureShowHideButtonFont = [UIFont systemFontOfSize:14];
}

#pragma mark -
#pragma mark - Secure Show Hide Button Methods
- (void)updateShowHideButtonText:(NSString *)text
{
    NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:text];
    [titleString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [titleString length])];
    [_secureShowHideButton setAttributedTitle:titleString forState:UIControlStateNormal];
}

- (void)showHideButtonSelected:(id)sender
{
    BOOL textShouldShow = !self.textField.secureTextEntry;
    self.textField.secureTextEntry = textShouldShow;
    NSString *text = (textShouldShow) ? self.localizedShowString : self.localizedHideString;
    [self updateShowHideButtonText:text];
}

- (void)setSecureTextEntry:(BOOL)secureTextEntry
{
    _secureTextEntry = secureTextEntry;
    self.textField.secureTextEntry = secureTextEntry;
    NSString *correctString = (self.textField.secureTextEntry) ? self.localizedShowString : self.localizedHideString;
    [self updateShowHideButtonText:correctString];
}

#pragma mark -
#pragma mark - UIView Lifecycle Methods
- (void)updateConstraints
{
    if (self.secureTextEntry)
    {       
        [self.secureShowHideButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(self.mas_right).offset(-40);
        }];
    }
    
    [self.textImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(10);
        
        CGFloat imageWidth = (self.textImageView.image) ? 20 : 0;
        make.width.equalTo(@(imageWidth));
        make.height.equalTo(@(imageWidth));
    }];
    
    [self.topBorderView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@0.5);
    }];
    
    [self.bottomBorderView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@0.5);
    }];
    
    [self.displayLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (self.displayLabelShouldShrink) {
            make.top.equalTo(self.mas_top).offset(10);
            make.left.equalTo(self.textImageView.mas_right).offset(-(self.displayLabel.frame.size.width * 0.195)+10);
        } else {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self.textImageView.mas_right).offset(10);
        }
        
        make.height.equalTo(@20);
    }];
    
    [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-5);
        make.left.equalTo(self.textImageView.mas_right).offset(10);
        if (self.displayLabelShouldShrink) {
            MASViewAttribute *rightSide = (self.secureTextEntry) ? self.secureShowHideButton.mas_left : self.mas_right;
            make.right.equalTo(rightSide);
            make.height.equalTo(self.mas_height).offset(-20);
        } else {
            make.right.equalTo(self.textImageView.mas_right).offset(10);
            make.height.equalTo(@0);
        }
    }];
    
    [super updateConstraints];
}

#pragma mark -
#pragma mark - Getter Setter Overides Methods
- (NSString *)text
{
    return self.textField.text;
}

- (void)setText:(NSString *)text
{
    self.textField.text = text;
}

- (NSString *)labelText
{
    return self.displayLabel.text;
}

- (void)setLabelText:(NSString *)labelText
{
    self.displayLabel.text = labelText;
}

- (NSString *)placeholder
{
    return self.textField.placeholder;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    self.textField.placeholder = placeholder;
}

- (void)setActiveColor:(UIColor *)activeColor
{
    _activeColor = activeColor;
    self.textField.textColor = _activeColor;
}

- (void)setInActiveBackgroundColor:(UIColor *)inActiveBackgroundColor
{
    _inActiveBackgroundColor = inActiveBackgroundColor;
    if (!self.textFieldActive) {
        self.backgroundColor = inActiveBackgroundColor;
    }
}

- (void)setActiveBackgroundColor:(UIColor *)activeBackgroundColor
{
    _activeBackgroundColor = activeBackgroundColor;
    if (self.textFieldActive) {
        self.backgroundColor = activeBackgroundColor;
    }
}

- (void)setBorderColor:(UIColor *)borderColor
{
    _borderColor = borderColor;
    self.topBorderView.backgroundColor = borderColor;
    self.bottomBorderView.backgroundColor = borderColor;
}

- (void)setTextFieldFont:(UIFont *)textFieldFont
{
    _textFieldFont = textFieldFont;
    self.textField.font = textFieldFont;
}

- (void)setLabelFont:(UIFont *)labelFont
{
    _labelFont = labelFont;
    self.displayLabel.font = labelFont;
}

- (void)setSecureShowHideButtonFont:(UIFont *)secureShowHideButtonFont
{
    _secureShowHideButtonFont = secureShowHideButtonFont;
    self.secureShowHideButton.titleLabel.font = secureShowHideButtonFont;
}

#pragma mark -
#pragma mark - Lazy Loaded properties
- (UILabel *)displayLabel
{
    if (!_displayLabel)
    {
        _displayLabel = [[UILabel alloc] init];
        _displayLabel.textColor = self.inactiveColor;
        _displayLabel.font = self.labelFont;
    }
    
    return _displayLabel;
}

- (UITextField *)textField
{
    if (!_textField)
    {
        _textField = [[UITextField alloc] init];
        _textField.delegate = self;
        _textField.font = self.textFieldFont;
    }
    
    return _textField;
}

- (UIImageView *)textImageView
{
    if (!_textImageView)
    {
        _textImageView = [[UIImageView alloc] initWithImage:self.inactiveImage];
        _textImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _textImageView;
}

- (UIButton *)secureShowHideButton
{
    if (!_secureShowHideButton)
    {
        _secureShowHideButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _secureShowHideButton.tintColor = [UIColor blackColor];
        _secureShowHideButton.backgroundColor = [UIColor clearColor];
        _secureShowHideButton.titleLabel.font = self.secureShowHideButtonFont;
        [_secureShowHideButton addTarget:self action:@selector(showHideButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _secureShowHideButton;
}

- (UIView *)bottomBorderView
{
    if (!_bottomBorderView)
    {
        _bottomBorderView = [[UIView alloc] init];
        _bottomBorderView.hidden = YES;
        _bottomBorderView.backgroundColor = self.borderColor;
    }
    return _bottomBorderView;
}

- (UIView *)topBorderView
{
    if (!_topBorderView)
    {
        _topBorderView = [[UIView alloc] init];
        _topBorderView.hidden = YES;
        _topBorderView.backgroundColor = self.borderColor;
    }
    return _topBorderView;
}

#pragma mark -
#pragma mark - UIGestureRecognizer methods
- (void)tapped:(id)sender
{
    if (self.textFieldActive) return;
    self.textFieldActive = YES;
    self.displayLabelShouldShrink = YES;
    [self.textField becomeFirstResponder];
}

- (void)animateChangeAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion
{
    CGFloat size = (self.displayLabelShouldShrink) ? 0.6 : 1;
    
    [self setNeedsUpdateConstraints];
    
    [self updateConstraintsIfNeeded];
    
    UIImage *image = (self.textFieldActive) ? self.activeImage : self.inactiveImage;
    
    [UIView transitionWithView:self.textImageView
                      duration:0.1
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        self.textImageView.image = image;
                    } completion:nil];
    
    CABasicAnimation *ba = [CABasicAnimation animationWithKeyPath:@"transform"];
    ba.duration = 0.2;
    ba.fillMode = kCAFillModeForwards;
    ba.removedOnCompletion = NO;
    ba.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    ba.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(size, size, 1)];
    [self.displayLabel.layer addAnimation:ba forKey:nil];
    
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut animations:^{
                            [self layoutIfNeeded];
                            [self changeColors];
                        } completion:^(BOOL finished) {
                            if (self.textFieldActive) [self.textField becomeFirstResponder];
                            if (completion) { completion(finished); }
                        }];
}

- (void)setActiveImage:(UIImage *)activeImage inactiveImage:(UIImage *)inactiveImage
{
    self.activeImage = activeImage;
    self.inactiveImage = inactiveImage;
    
    UIImage *image = (self.textFieldActive) ? self.activeImage : self.inactiveImage;
    
    self.textImageView.image = image;
}

- (void)shouldShowTopBorder:(BOOL)showTopBorder showBottomBorder:(BOOL)showBottomBorder
{
    self.topBorderView.hidden = !showTopBorder;
    self.bottomBorderView.hidden = !showBottomBorder;
}

- (void)changeColors
{
    self.backgroundColor = (self.textFieldActive) ? self.activeBackgroundColor : self.inActiveBackgroundColor;
    self.textField.textColor = (self.textFieldActive) ? self.activeColor : self.inactiveColor;
    self.displayLabel.textColor = (self.textFieldActive) ? self.activeColor : self.inactiveColor;
}

#pragma mark -
#pragma mark - Animation Methods
- (void)showContentsAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion
{
    self.textFieldActive = YES;
    self.displayLabelShouldShrink = YES;
    [self animateChangeAnimated:animated completion:completion];
}

- (void)hideContentsAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion
{
    self.textFieldActive = NO;
    self.displayLabelShouldShrink = NO;
    [self animateChangeAnimated:animated completion:completion];
    [self.textField resignFirstResponder];
}

#pragma mark -
#pragma mark - UITextFieldDelegate Methods
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return ([self.delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) ? [self.delegate textFieldShouldBeginEditing:textField] : YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.displayLabelShouldShrink = YES;
    self.textFieldActive = YES;
    [self animateChangeAnimated:YES completion:nil];
    if ([self.delegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) [self.delegate textFieldDidBeginEditing:textField];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return ([self.delegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) ? [self.delegate textFieldShouldEndEditing:textField] : YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.textFieldActive = NO;
    self.displayLabelShouldShrink = ([self.textField.text isEmptyOrWhitespace]) ? NO : YES;
    [self animateChangeAnimated:YES completion:nil];
    
    if ([self.delegate respondsToSelector:@selector(textFieldDidEndEditing:)]) [self.delegate textFieldDidEndEditing:textField];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return ([self.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) ? [self.delegate textField:textField shouldChangeCharactersInRange:range replacementString:string] : YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    return ([self.delegate respondsToSelector:@selector(textFieldShouldClear:)]) ? [self.delegate textFieldShouldClear:textField] : YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return ([self.delegate respondsToSelector:@selector(textFieldShouldReturn:)]) ? [self.delegate textFieldShouldReturn:textField] : YES;
}

@end
