// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by nimrod gruber.

#import "CGSetGame.h"

NS_ASSUME_NONNULL_BEGIN

@interface CGSetGame()

@property (strong, nonatomic) NSMutableArray<CGCard *> *cards;
//@property (readwrite, nonatomic) NSMutableString *log;
@property (strong, nonatomic, nullable) NSMutableArray<CGCard *> *pickedCards;
//@property (readwrite, nonatomic) NSInteger score;

@end

@implementation CGSetGame

static const int kMismatchPenalty = 2;
static const int kMatchBonus = 4;
static const int kCostToChoose = 1;
//static const int kMaxLogLength = 6; //  ==> card.contents.length * 3.

//same as cardMatch game
- (nullable instancetype)initWithCardCount:(NSUInteger)count usingDeck:(CGDeck *)deck {
  if (self = [super init]) {
    _cards = [[NSMutableArray<CGCard *> alloc] init];
    self.log = [[NSMutableString alloc] init];
    self.matchMode = 3; //in set game matchMode is always 3
    _pickedCards = [[NSMutableArray<CGCard *> alloc] init];
    self.score = 0;
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

//same as set game
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
//    [self logRemoveUnchosenCard:card];
  } else {
   // [self logAddChosenCard:card];
    
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
//        [self logPresentMatchScore:card points:(matchScore * kMatchBonus) success:YES];
        [self markCardsMatchedSign:card cards:self.pickedCards sign:YES];
      } else {
        self.score -= kMismatchPenalty;
//        [self logPresentMatchScore:card points:(kMismatchPenalty + kCostToChoose) success:NO];
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
