//
//  CJExampleViewController.m
//  CJFloatingTextFieldExample
//
//  Created by Aron on 22/01/2015.
//  Copyright (c) 2015 CoinJar. All rights reserved.
//

#import "CJExampleViewController.h"
#import "CJFloatingLabelTextField.h"

@interface CJExampleViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet CJFloatingLabelTextField *emailTextField;
@property (weak, nonatomic) IBOutlet CJFloatingLabelTextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UIButton *showTextButton;
@property (weak, nonatomic) IBOutlet UIButton *hideTextButton;
@end

@implementation CJExampleViewController

#pragma mark -
#pragma mark - UIViewController lifecycle methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpStyles];
    [self configureEmailTextField];
    [self configurePasswordTextField];
}

#pragma mark -
#pragma mark - Setup methods
- (void)setUpStyles
{
    [[CJFloatingLabelTextField appearance] setTextFieldFont:[UIFont fontWithName:@"Avenir-Book" size:14]];
    [[CJFloatingLabelTextField appearance] setActiveColor:[UIColor colorWithHue:0.57 saturation:0.86 brightness:0.6 alpha:1]];
    [[CJFloatingLabelTextField appearance] setLabelFont:[UIFont fontWithName:@"Avenir-Light" size:16]];
    [[CJFloatingLabelTextField appearance] setInactiveColor:[UIColor colorWithHue:0 saturation:0 brightness:0.56 alpha:1]];
    [[CJFloatingLabelTextField appearance] setInActiveBackgroundColor:[UIColor colorWithHue:0 saturation:0 brightness:0.96 alpha:1]];
    [[CJFloatingLabelTextField appearance] setActiveBackgroundColor:[UIColor colorWithHue:0 saturation:0 brightness:0.99 alpha:1]];
    [[CJFloatingLabelTextField appearance] setSecureShowHideButtonFont:[UIFont fontWithName:@"Avenir-Light" size:16]];
}

- (void)configureEmailTextField
{
    self.emailTextField.displayLabel.text = NSLocalizedString(@"Email", nil);
    self.emailTextField.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.emailTextField.textField.keyboardType = UIKeyboardTypeEmailAddress;
    self.emailTextField.textField.returnKeyType = UIReturnKeyNext;
    self.emailTextField.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.emailTextField setActiveImage:[UIImage imageNamed:@"icon__email--active"] inactiveImage:[UIImage imageNamed:@"icon__email"]];
    self.emailTextField.delegate = self;
    [self.emailTextField shouldShowTopBorder:YES showBottomBorder:YES];
}

- (void)configurePasswordTextField
{
    self.passwordTextField.displayLabel.text = NSLocalizedString(@"Password", nil);
    self.passwordTextField.secureTextEntry = YES;
    self.passwordTextField.textField.returnKeyType = UIReturnKeyDone;
    self.passwordTextField.textField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.passwordTextField.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.passwordTextField setActiveImage:[UIImage imageNamed:@"icon__lock--active"] inactiveImage:[UIImage imageNamed:@"icon__lock"]];
    self.passwordTextField.delegate = self;
    [self.passwordTextField shouldShowTopBorder:NO showBottomBorder:YES];
}

#pragma mark -
#pragma mark - Button action methods
- (IBAction)showText:(id)sender
{
    [self.emailTextField showContentsAnimated:YES completion:nil];
}

- (IBAction)hideText:(id)sender
{
    [self.emailTextField hideContentsAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark - UITextFieldDelegate Methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if      (textField == self.emailTextField.textField)            [self.passwordTextField.textField becomeFirstResponder];
    else if (textField == self.passwordTextField.textField)         [textField resignFirstResponder];
    
    return YES;
}

@end
