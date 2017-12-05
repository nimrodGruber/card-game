// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by nimrod gruber.

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetCardsViewController : ViewController

@end

NS_ASSUME_NONNULL_END



//
//  NSString *redText = @"red text";
//  NSString *greenText = @"green text";
//  NSString *purpleBoldText = @"purple bold text";
//
//  NSString *text = [NSString stringWithFormat:@"Here are %@, %@ and %@",
//                    redText,
//                    greenText,
//                    purpleBoldText];
//
//  // If attributed text is supported (iOS6+)
//  if ([self.label respondsToSelector:@selector(setAttributedText:)]) {
//
//    // Define general attributes for the entire text
//    NSDictionary *attribs = @{
//                              NSForegroundColorAttributeName: self.label.textColor,
//                              NSFontAttributeName: self.label.font
//                              };
//    NSMutableAttributedString *attributedText =
//    [[NSMutableAttributedString alloc] initWithString:text
//                                           attributes:attribs];
//
//    // Red text attributes
//    UIColor *redColor = [UIColor redColor];
//    NSRange redTextRange = [text rangeOfString:redText];// * Notice that usage of rangeOfString in this case may cause some bugs - I use it here only for demonstration
//    [attributedText setAttributes:@{NSForegroundColorAttributeName:redColor}
//                            range:redTextRange];
//
//    // Green text attributes
//    UIColor *greenColor = [UIColor greenColor];
//    NSRange greenTextRange = [text rangeOfString:greenText];// * Notice that usage of rangeOfString in this case may cause some bugs - I use it here only for demonstration
//    [attributedText setAttributes:@{NSForegroundColorAttributeName:greenColor}
//                            range:greenTextRange];
//
//    // Purple and bold text attributes
//    UIColor *purpleColor = [UIColor purpleColor];
//    UIFont *boldFont = [UIFont boldSystemFontOfSize:self.label.font.pointSize];
//    NSRange purpleBoldTextRange = [text rangeOfString:purpleBoldText];// * Notice that usage of rangeOfString in this case may cause some bugs - I use it here only for demonstration
//    [attributedText setAttributes:@{NSForegroundColorAttributeName:purpleColor,
//                                    NSFontAttributeName:boldFont}
//                            range:purpleBoldTextRange];
//
//    self.label.attributedText = attributedText;
//  }
//  // If attributed text is NOT supported (iOS5-)
//  else {
//    self.label.text = text;
//  }
