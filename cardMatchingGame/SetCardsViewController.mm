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
//  if (![card isKindOfClass:[CGSetCard class]]) {
//    return @"";
//  } else {
    CGSetCard *setCard = (CGSetCard *) card;
    NSMutableString *cardData = [[NSMutableString alloc] init];
    [cardData appendString:[self numberValue:setCard]];
    [cardData appendString:[self symbolValue:setCard]];
    [cardData appendString:[self colorValue:setCard]];
    [cardData appendString:[self shadeValue:setCard]];
    return cardData;
//  }
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
  if (card.number == one) {
    return @"1";
  } else if (card.number == two) {
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
    return @"🔼";
  } else if (card.symbol == circle) {
    return @"⏺";
  } else { //card.symbol == squar
    return @"⏹";
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

@end

NS_ASSUME_NONNULL_END











