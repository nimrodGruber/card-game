// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by nimrod gruber.

#import "CGPlayingCardDeck.h"
#import "MatchingCardsViewController.h"

NS_ASSUME_NONNULL_BEGIN

@implementation MatchingCardsViewController

- (CGDeck *)createDeck {
  return [[CGPlayingCardDeck alloc] init]; 
}

@end

NS_ASSUME_NONNULL_END
