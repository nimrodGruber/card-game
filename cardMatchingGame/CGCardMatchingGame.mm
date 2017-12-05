// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by nimrod gruber.

#import "CGCardMatchingGame.h"

NS_ASSUME_NONNULL_BEGIN

@interface CGCardMatchingGame()

@property (strong, nonatomic) NSMutableArray<CGCard *> *cards;

@end

@implementation CGCardMatchingGame

static const int kMismatchPenalty = 2;
static const int kMatchBonus = 4;
static const int kCostToChoose = 1;

//almost same as set game - should it be in parent class?
- (nullable instancetype)initWithCardCount:(NSUInteger)count usingDeck:(CGDeck *)deck {
  if (self = [super init]) {
    _cards = [[NSMutableArray<CGCard *> alloc] init];
    _history = [[HistoryBoss alloc] init];
    self.log = [[NSMutableString alloc] init];
    self.matchMode = 2; //in set game matchMode is always 3
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

//same as set game - should it be in parent class?
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
    [self.history.logSetGame removeLastObject];
  } else {
    card.chosen = YES;
    [self.history.logMatchGame addObject:[[NSString alloc] initWithFormat:@"%@", card.contents]];
  
    if (self.pickedCards.count == self.matchMode - 1) {
      int matchScore = 0;
      
      if (self.matchMode == 2) {
        matchScore = [card matchTwoCards:self.pickedCards];
      } else { // if (self.matchMode == 3)
        matchScore = [card matchThreeCards:self.pickedCards];
      }
      
      if (matchScore) {
        self.score += matchScore * kMatchBonus;
        self.lastMatchScoring = matchScore * kMatchBonus;
        [self markCardsMatchedSign:card cards:self.pickedCards sign:YES];
        [self addHistoryOfMatch];
      } else {
        self.score -= kMismatchPenalty;
        self.lastMatchScoring = kMismatchPenalty;
        [self addHistoryOfMismatch];
      }
    }
  
    [self.pickedCards addObject:card];
  
    self.score -= kCostToChoose;
  }
}

//same as set game - should it be in parent class?
- (void)flipAndClearPickedCardsIfNeeded:(CGCard *)card {
  if (self.pickedCards.count == self.matchMode) {
    if ([self.pickedCards firstObject].matched == NO) {
      [self markCardsChosenSign:card cards:self.pickedCards sign:NO];
    }
    [self.pickedCards removeAllObjects];
  }
}


//same as set game - should it be in parent class?
- (void)markCardsChosenSign:(CGCard *)card cards:(NSMutableArray *)cards sign:(BOOL)sign {
  for (CGCard *picked in cards) {
    picked.chosen = sign;
  }
  
  card.chosen = sign;
}

//same as set game - should it be in parent class?
- (void)markCardsMatchedSign:(CGCard *)card cards:(NSMutableArray *)cards sign:(BOOL)sign {
  for (CGCard *picked in cards) {
    picked.matched = sign;
  }
  
  card.matched = sign;
}

- (void)addHistoryOfMatch {
  NSMutableString *result = [[NSMutableString alloc] initWithFormat:@" matched for %d points !", self.lastMatchScoring];;
  [self.history.logSetGame addObject:result];
}

- (void)addHistoryOfMismatch {
  NSMutableString *result = [[NSMutableString alloc] initWithFormat:@" mismatch penalty %d points !", self.lastMatchScoring];
  [self.history.logSetGame addObject:result];
}

@end

NS_ASSUME_NONNULL_END
