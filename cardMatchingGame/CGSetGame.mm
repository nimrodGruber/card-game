// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by nimrod gruber.

#import "CGSetGame.h"
#import "CGSetCard.h"


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
    _history = [[HistoryBoss alloc] init];
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

//same as match game - should it be in parent class?
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
    [self.history.logSetGame addObject:[self cardToText:card]];
    
    if (self.pickedCards.count == self.matchMode - 1) {
      int matchScore = 0;
      matchScore = [card matchThreeCards:self.pickedCards];
      
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

//same as match game - should it be in parent class?
- (void)flipAndClearPickedCardsIfNeeded:(CGCard *)card {
  if (self.pickedCards.count == self.matchMode) {
    if ([self.pickedCards firstObject].matched == NO) {
      [self markCardsChosenSign:card cards:self.pickedCards sign:NO];
    }
    [self.pickedCards removeAllObjects];
  }
}

//same as match game - should it be in parent class?
- (void)markCardsChosenSign:(CGCard *)card cards:(NSMutableArray *)cards sign:(BOOL)sign {
  for (CGCard *picked in cards) {
    picked.chosen = sign;
  }
  
  card.chosen = sign;
}

//same as match game - should it be in parent class?
- (void)markCardsMatchedSign:(CGCard *)card cards:(NSMutableArray *)cards sign:(BOOL)sign {
  for (CGCard *picked in cards) {
    picked.matched = sign;
  }
  
  card.matched = sign;
}

- (NSMutableString *)cardToText: (CGCard*)card { //this function appears again in set view controller
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
