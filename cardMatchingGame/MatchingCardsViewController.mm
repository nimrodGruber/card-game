// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by nimrod gruber.

#import "CGPlayingCardDeck.h"
#import "CGCardMatchingGame.h"
#import "MatchingCardsViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MatchingCardsViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CGCardMatchingGame *game;
@end

@implementation MatchingCardsViewController

- (CGDeck *)createDeck {
  return [[CGPlayingCardDeck alloc] init]; 
}

- (NSString *)titleForCard:(CGCard *)card {
  return card.chosen ? card.contents : @"";
}

- (UIImage *)backGroundImageForCard:(CGCard *)card {

  return [UIImage imageNamed:card.chosen ? @"cardFront" : @"cardBack"];
}

- (CGCardMatchingGame *)game {
  if (!_game) {
    _game = [[CGCardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[self createDeck]];
  }
  
  return _game;
}

@end

NS_ASSUME_NONNULL_END
