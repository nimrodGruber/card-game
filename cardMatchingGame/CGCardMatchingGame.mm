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
  
  [self flipAndClearPickedCardsIfNeeded:card];

  if (card.matched) {
    return;
  } else if (card.chosen) {
      card.chosen = NO;
      [self.pickedCards removeObject:card];
      [self logRemoveUnchosenCard:card];
  } else {
      [self logAddChosenCard:card];
    
      card.chosen = YES;

      if (self.pickedCards.count == self.matchMode - 1) {
        int matchScore = 0;
        
        if (self.matchMode == 2) {
          matchScore = [card matchTwoCards:self.pickedCards];
        } else { // if (self.matchMode == 3)
          matchScore = [card matchThreeCards:self.pickedCards];
        }
      
        if (matchScore) {
          self.score += matchScore * kMatchBonus;
          [self logPresentMatchScore:card points:(matchScore * kMatchBonus) success:YES];
          [self markCardsMatchedSign:card cards:self.pickedCards sign:YES];
        } else {
          self.score -= kMismatchPenalty;
          [self logPresentMatchScore:card points:(kMismatchPenalty + kCostToChoose) success:NO];
        }
      }
    
      [self.pickedCards addObject:card];
    
      self.score -= kCostToChoose;
  }
}

//same as set
- (void)flipAndClearPickedCardsIfNeeded:(CGCard *)card {
  if (self.pickedCards.count == self.matchMode) {
    if ([self.pickedCards firstObject].matched == NO) {
      [self markCardsChosenSign:card cards:self.pickedCards sign:NO];
    }
    [self.pickedCards removeAllObjects];
  }
}

//same as set
- (nullable instancetype)initWithCardCount:(NSUInteger)count usingDeck:(CGDeck *)deck {
  if (self = [super init]) {
    _cards = [[NSMutableArray<CGCard *> alloc] init];
    _log = [[NSMutableString alloc] init];
    _matchMode = 2; //in set game matchMode is always 3
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

//same as set
- (void)markCardsChosenSign:(CGCard *)card cards:(NSMutableArray *)cards sign:(BOOL)sign {
  for (CGCard *picked in cards) {
    picked.chosen = sign;
  }
  
  card.chosen = sign;
}

//same as set
- (void)markCardsMatchedSign:(CGCard *)card cards:(NSMutableArray *)cards sign:(BOOL)sign {
  for (CGCard *picked in cards) {
    picked.matched = sign;
  }
  
  card.matched = sign;
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

- (void)logPresentMatchScore:(CGCard *)card points:(NSUInteger)points success:(BOOL)success {
  [self.log setString: @""];
  
  for (CGCard *pCard in self.pickedCards) {
    [self.log appendString:[NSString stringWithFormat:@"%@", pCard.contents]];
  }
  
  [self.log appendString:[NSString stringWithFormat:@"%@", card.contents]];
  
  if (success) {
    [self.log appendString:[NSString stringWithFormat:@" matched for %lu points", (unsigned long)points]];
  } else {
    [self.log appendString:[NSString stringWithFormat:@" wrong match %lu penalty", (unsigned long)points]];
  }
}

@end

NS_ASSUME_NONNULL_END
