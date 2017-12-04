// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by nimrod gruber.

#import "CGSetGame.h"
#import "CGSetCard.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CGSetGame()

@property (strong, nonatomic) NSMutableArray<CGCard *> *cards;

@end

@implementation CGSetGame

static const int kMismatchPenalty = 2;
static const int kMatchBonus = 15;
static const int kCostToChoose = 1;

- (nullable instancetype)initWithCardCount:(NSUInteger)count usingDeck:(CGDeck *)deck {
  if (self = [super init]) {
    _cards = [[NSMutableArray<CGCard *> alloc] init];
    self.matchMode = 3; //in set game matchMode is always 3
    for (NSUInteger i = 0; i < count; ++i) {
      CGCard *card = [deck drawRandomCard];
      if (card) {
        [self.cards addObject:card];
      } else {
        self = nil;
        break;
      }
    }
  }
  
  return self;
}

- (CGCard *)cardAtIndex:(NSUInteger)index {
  return (index <= self.cards.count) ? self.cards[index] : nil;
}

- (void)chooseCardAtIndex:(NSUInteger)index {
  CGCard *card = [self cardAtIndex:index];
  
  [self flipAndClearPickedCardsIfNeeded:card];
  
  if (card.matched) {
    return;
  } else if (card.chosen) {
    card.chosen = NO;
    [self.pickedCards removeObject:card];
  } else {
    card.chosen = YES;
    
    if (self.pickedCards.count == self.matchMode - 1) {
      int matchScore = 0;
      matchScore = [card matchThreeCards:self.pickedCards];
      
      if (matchScore) {
        self.score += matchScore * kMatchBonus;
        self.lastMatchScoring = matchScore * kMatchBonus;
        [self markCardsMatchedSign:card cards:self.pickedCards sign:YES];
      } else {
        self.score -= kMismatchPenalty;
        self.lastMatchScoring = kMismatchPenalty;
      }
    }
    
    [self.pickedCards addObject:card];
    
    self.score -= kCostToChoose;
  }
}

//same as set game
- (void)flipAndClearPickedCardsIfNeeded:(CGCard *)card {
  if (self.pickedCards.count == self.matchMode) {
    if ([self.pickedCards firstObject].matched == NO) {
      [self markCardsChosenSign:card cards:self.pickedCards sign:NO];
    }
    [self.pickedCards removeAllObjects];
  }
}

//same as set game
- (void)markCardsChosenSign:(CGCard *)card cards:(NSMutableArray *)cards sign:(BOOL)sign {
  for (CGCard *picked in cards) {
    picked.chosen = sign;
  }
  
  card.chosen = sign;
}

//same as set game
- (void)markCardsMatchedSign:(CGCard *)card cards:(NSMutableArray *)cards sign:(BOOL)sign {
  for (CGCard *picked in cards) {
    picked.matched = sign;
  }
  
  card.matched = sign;
}

@end

NS_ASSUME_NONNULL_END
