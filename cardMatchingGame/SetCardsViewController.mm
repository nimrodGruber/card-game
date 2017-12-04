// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by nimrod gruber.

#import "CGSetCard.h"
#import "CGSetDeck.h"
#import "CGSetGame.h"
#import "SetCardsViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetCardsViewController ()

@property (strong, nonatomic) CGSetGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@end

@implementation SetCardsViewController

- (CGDeck *)createDeck {
  return [[CGSetDeck alloc] init];
}

- (UIImage *)backGroundImageForCard:(CGCard *)card {
  if (card.chosen) {
    return [UIImage imageNamed:@"chosenSetCard"];
  } else {
  return [UIImage imageNamed:@"cardFront"];
  }
}

- (CGCardGame *)game {
  if (!_game) {
    _game = [[CGSetGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[self createDeck]];
  }

  return _game;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.

  [self updateUI];
}

- (void)updateUI {
  for (UIButton *cardButton in self.cardButtons) {
    NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
    CGCard *card = [self.game cardAtIndex:cardButtonIndex];
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] init];
    [self extractCardAttributedTitle:card title:title];
    [cardButton setAttributedTitle:title forState:UIControlStateNormal];
    [cardButton setBackgroundImage:[self backGroundImageForCard:card]forState:UIControlStateNormal];
    cardButton.enabled = !card.matched;
    
    self.scoreLable.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
    
    [self logUpdateInTheUI];
  }
}

- (void)logUpdateInTheUI {
  NSMutableString *log = [[NSMutableString alloc] init];
  for (CGCard *card in self.game.pickedCards) {
    [log appendString:[self cardToText:card]];
  }
  
  if ([self.game.pickedCards count] == self.game.matchMode) {
    if ([self.game.pickedCards firstObject].matched) {
      [log appendString:[[NSString alloc] initWithFormat:@" matched for %d points !", self.game.lastMatchScoring]];
    } else {
      [log appendString:[[NSString alloc] initWithFormat:@" mismatch penalty %d points !", self.game.lastMatchScoring]];
    }
  }
  
  self.logLable.text = log;
}
  
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

- (NSMutableString *)cardToText: (CGCard*)card {
  CGSetCard *setCard = (CGSetCard *)card;
  NSMutableString *textCard = [[NSMutableString alloc] init];
  
  if (setCard.number == 1) {
    [textCard appendString:@"1"];
  } else if (setCard.number == 2) {
    [textCard appendString:@"2"];
  } else { // (setCard.number == 3)
    [textCard appendString:@"3"];
  }
  
  if (setCard.symbol == triangle) {
    [textCard appendString:@"▲"];
  } else if (setCard.symbol == circle) {
    [textCard appendString:@"●"];
  } else { // (setCard.symbol == square)
    [textCard appendString:@"■"];
  }
  
  return textCard;
}

- (ShadeType)findCardShade:(CGCard *)card {
  CGSetCard *setCard = (CGSetCard *) card;
  if (setCard.shading == solid) {
    return solid;
  } else if (setCard.shading == opened) {
    return opened;
  } else { // (setCard.shading == striped)
    return striped;
  }
}

- (UIColor *)findCardColor:(CGCard *)card {
  CGSetCard *setCard = (CGSetCard *) card;

  if (setCard.color == red) {
    return [UIColor redColor];
  } else if (setCard.color == green) {
    return [UIColor greenColor];
  } else { //(setCard.color == purple)
    return [UIColor purpleColor];
  }
}

- (int)findCardNumber:(CGCard *)card {
   CGSetCard *setCard = (CGSetCard *)card;
   return setCard.number;
 }

- (NSString *)findCardSymbol:(CGCard *)card {
   CGSetCard *setCard = (CGSetCard *)card;

   if (setCard.symbol == triangle) {
     return @"▲";
   } else if (setCard.symbol == circle) {
     return @"●";
   } else { //setCard.symbol == squar
     return @"■";
   }
 }

- (void)extractCardAttributedTitle:(CGCard *)card title:(NSMutableAttributedString *)title {
  [title appendAttributedString:[[NSAttributedString alloc] initWithString: [[NSString alloc] initWithFormat:@"%d%@",[self findCardNumber:card], [self findCardSymbol:card]]]];

  if ([self findCardShade:card] == opened) {
    [title setAttributes:@{ NSForegroundColorAttributeName : [self findCardColor:card],
                            NSStrokeWidthAttributeName : @-5 }
                   range:NSMakeRange(0, [title length])];
  } else if ([self findCardShade:card] == solid) {
    [title setAttributes:@{ NSForegroundColorAttributeName : [self findCardColor:card],
                            NSStrokeWidthAttributeName : @5 }
                   range:NSMakeRange(0, [title length])];
  } else { // (setCard.shading == striped)
    if ([self findCardColor:card] == [UIColor redColor]) {
      [title setAttributes:@{ NSForegroundColorAttributeName : [self findCardColor:card],
                              NSBackgroundColorAttributeName : [[UIColor redColor] colorWithAlphaComponent:0.2] }
                     range:NSMakeRange(0, [title length])];
    } else if ([self findCardColor:card] == [UIColor greenColor]) {
      [title setAttributes:@{ NSForegroundColorAttributeName : [self findCardColor:card],
                              NSBackgroundColorAttributeName : [[UIColor greenColor] colorWithAlphaComponent:0.2] }
                     range:NSMakeRange(0, [title length])];
    } else {
      [title setAttributes:@{ NSForegroundColorAttributeName : [self findCardColor:card],
                              NSBackgroundColorAttributeName : [[UIColor purpleColor] colorWithAlphaComponent:0.2] }
                     range:NSMakeRange(0, [title length])];
    }
  }
}

@end

NS_ASSUME_NONNULL_END
