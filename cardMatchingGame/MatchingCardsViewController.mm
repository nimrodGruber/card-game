// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by nimrod gruber.

#import "CGPlayingCardDeck.h"
#import "MatchingCardsViewController.h"

NS_ASSUME_NONNULL_BEGIN

@implementation MatchingCardsViewController

- (CGDeck *)createDeck {
  return [[CGPlayingCardDeck alloc] init]; 
}

- (NSString *)titleForCard:(CGCard *)card {
  return card.chosen ? card.contents : @"";
}

@end

NS_ASSUME_NONNULL_END
