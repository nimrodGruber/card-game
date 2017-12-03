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

- (NSString *)titleForCard:(CGCard *)card {
  if (![card isKindOfClass:[CGSetCard class]]) {
    return @"";
  } else {
    CGSetCard *setCard = (CGSetCard *) card;
    NSMutableString *cardData = [[NSMutableString alloc] init];
    [cardData appendString:[self numberValue:setCard]];
    [cardData appendString:[self symbolValue:setCard]];
    [cardData appendString:[self colorValue:setCard]];
    [cardData appendString:[self shadeValue:setCard]];
    return cardData;
  }
}

- (NSString *)colorValue:(CGSetCard *)card {
  if (card.color == red) {
    return @"r";
  } else if (card.color == green) {
    return @"g";
  } else {
    return @"p";
  }
}

- (NSString *)numberValue:(CGSetCard *)card {
  if (card.number == 1) {
    return @"1";
  } else if (card.number == 2) {
    return @"2";
  } else {
    return @"3";
  }
}

- (NSString *)shadeValue:(CGSetCard *)card {
  if (card.shading == solid) {
    return @"so";
  } else if (card.shading == striped) {
    return @"st";
  } else { //card.shading == open
    return @"op";
  }
}

- (NSString *)symbolValue:(CGSetCard *)card {
  if (card.symbol == triangle) {
    return @"▲";
  } else if (card.symbol == circle) {
    return @"●";
  } else { //card.symbol == squar
    return @"■";
  }
  
}

- (UIImage *)backGroundImageForCard:(CGCard *)card {
  return [UIImage imageNamed:@"cardFront"];
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

- (void) updateUI {
  for (UIButton *cardButton in self.cardButtons) {
    NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
    CGCard *card = [self.game cardAtIndex:cardButtonIndex];
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] init];
    
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

    //[self setCardShade:card btn:cardButton]; //not applied for some reasone
    [cardButton setAttributedTitle:title forState:UIControlStateNormal];
    //[cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
    [cardButton setBackgroundImage:[self backGroundImageForCard:card] forState:UIControlStateNormal];
    cardButton.enabled = !card.matched;
    self.scoreLable.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
    self.logLable.text = self.game.log;
  }
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
                                   
                                   
@end

NS_ASSUME_NONNULL_END
