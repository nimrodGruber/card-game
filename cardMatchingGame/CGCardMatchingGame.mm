// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by nimrod gruber.

#import "CGCardMatchingGame.h"

NS_ASSUME_NONNULL_BEGIN

@interface CGCardMatchingGame()

@property (strong, nonatomic) NSMutableArray<CGCard *> *cards;
@property (readwrite, nonatomic) NSMutableString *log;
@property (strong, nonatomic, nullable) NSMutableArray<CGCard *> *pickedCards;
@property (readwrite, nonatomic) NSInteger score;

@end

@implementation CGCardMatchingGame

static const int kMismatchPenalty = 2;
static const int kMatchBonus = 4;
static const int kCostToChoose = 1;
static const int kMaxLogLength = 6; //  ==> card.contents.length * 3.

- (CGCard *)cardAtIndex:(NSUInteger)index
{
  return (index <= self.cards.count) ? self.cards[index] : nil;
}

- (void)chooseCardAtIndex:(NSUInteger)index {
  CGCard *card = [self cardAtIndex:index];
  
  [self flipAndClearPickedCardsIfNeeded];

  if (!card.matched) {
    if (card.chosen) {
      card.chosen = NO;
      [self.pickedCards removeObject:card];
      [self logRemoveUnchosenCard:card];
    } else {
      [self logAddChosenCard:card];
      
      card.chosen = YES;
      [self.pickedCards addObject:card];

//      if (self.pickedCards.count == self.matchMode) {
//        int matchScore = [card match:self.pickedCards matchMethod:self.matchMode];
      if (self.pickedCards.count == self.matchMode) {
        int matchScore = 0;
        
        if (self.matchMode == 2) {
          matchScore = [card matchTwoCards:self.pickedCards];
        } else { // if (self.matchMode == 3)
          matchScore = [card matchThreeCards:self.pickedCards];
        }
      
        if (matchScore) {
          self.score += matchScore * kMatchBonus;
          [self logPresentMatchScore:(matchScore * kMatchBonus) success:YES];
          [self markCardsMatchedSign:self.pickedCards sign:YES];
        } else {
          self.score -= kMismatchPenalty;
          [self logPresentMatchScore:(kMismatchPenalty + kCostToChoose) success:NO];
        }
      }
      
      self.score -= kCostToChoose;
    }
  }
}

- (void)flipAndClearPickedCardsIfNeeded {
  if (self.pickedCards.count == self.matchMode) {
    if ([self.pickedCards firstObject].matched == NO) {
      [self markCardsChosenSign:self.pickedCards sign:NO];
    }
    [self.pickedCards removeAllObjects];
  }
}

- (nullable instancetype)initWithCardCount:(NSUInteger)count usingDeck:(CGDeck *)deck {
  if (self = [super init]) {
    _cards = [[NSMutableArray<CGCard *> alloc] init];
    _log = [[NSMutableString alloc] init];
    _matchMode = 2;
    _pickedCards = [[NSMutableArray<CGCard *> alloc] init];
    _score = 0;
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

- (void)markCardsChosenSign:(NSMutableArray *)cards sign:(BOOL)sign {
  for (CGCard *card in cards) {
    card.chosen = sign;
  }
}

- (void)markCardsMatchedSign:(NSMutableArray *)cards sign:(BOOL)sign {
  for (CGCard *card in cards) {
    card.matched = sign;
  }
}

- (void)logRemoveUnchosenCard:(CGCard *)card {
  NSRange cardRange = [self.log rangeOfString:card.contents];
  [self.log deleteCharactersInRange:cardRange];
}

- (void)logAddChosenCard:(CGCard *)card {
  if (self.log.length > kMaxLogLength) {
    [self.log setString: @""];
  }
  [self.log appendString:[NSString stringWithFormat:@"%@", card.contents]];
}

- (void)logPresentMatchScore:(NSUInteger)points success:(BOOL)success {
  [self.log setString: @""];
  
  for (CGCard *pCard in self.pickedCards) {
    [self.log appendString:[NSString stringWithFormat:@"%@", pCard.contents]];
  }
  
  if (success) {
    [self.log appendString:[NSString stringWithFormat:@" matched for %lu points", (unsigned long)points]];
  } else {
    [self.log appendString:[NSString stringWithFormat:@" wrong match %lu penalty", (unsigned long)points]];
  }
}

@end

NS_ASSUME_NONNULL_END
