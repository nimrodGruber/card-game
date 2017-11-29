// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by nimrod gruber.

#import "CGPlayingCard.h"

NS_ASSUME_NONNULL_BEGIN

@implementation CGPlayingCard

@synthesize suit = _suit;

static const int kRankMatchScore = 4;
static const int kSuitMatchScore = 1;
static const int kThreeMatchBonus = 10;

- (NSString *)contents {
  NSArray *rankStrings = [CGPlayingCard rankStrings];
  
  return [rankStrings[static_cast<unsigned long long>(self.rank)] stringByAppendingString:self.suit];
}

- (instancetype)init {
  if (self = [super init]) {
    _rank = 0;
    _suit = @"?";
  }
  
  return self;
}

- (int)matchTwoCards:(NSMutableArray *)otherCards {
  int score = 0;
  int matchCount =0;
  
  id card = [otherCards firstObject];
  if ([card isKindOfClass:[CGPlayingCard class]]) {
    for (CGPlayingCard *card in otherCards) {
      if (self.rank == card.rank) {
        score += kRankMatchScore;
        matchCount += 1;
      } else if ([self.suit isEqualToString:card.suit]) {
        score += kSuitMatchScore;
        matchCount += 1;
      }
    }
  }
  
  return score;
}

- (int)matchThreeCards:(NSMutableArray *)otherCards {
  int score = 0;
  int matchCount =0;
  
  for (CGPlayingCard *card in otherCards) {
    if (self.rank == card.rank) {
      score += kRankMatchScore;
      matchCount += 1;
    } else if ([self.suit isEqualToString:card.suit]) {
      score += kSuitMatchScore;
      matchCount += 1;
    }
  }
  
  CGPlayingCard *first = [otherCards firstObject];
  CGPlayingCard *second = [otherCards lastObject];
  
  if (first.rank == second.rank) {
    score += kRankMatchScore;
    matchCount += 1;
  } else if ([first.suit isEqualToString:second.suit]) {
    score += kSuitMatchScore;
    matchCount += 1;
  }
  
  if (matchCount == 3) {
    score *= kThreeMatchBonus;
  }
  
  return score;
}

+ (NSUInteger)maxRank {
  return [[self rankStrings] count] -1;
}

+ (NSArray *)rankStrings {
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

- (void)setRank:(NSUInteger)rank {
  if (rank <= [CGPlayingCard maxRank]) {
    _rank = rank;
  }
}

- (void)setSuit:(NSString *)suit {
    if ([[CGPlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit {
  return _suit ? _suit : @"?";
}

+ (NSArray *)validSuits {
  return @[@"♠️", @"♣️", @"♥️", @"♦️"];
}

//- (int)match:(NSMutableArray *)otherCards matchMethod:(NSUInteger)matchMethod {
//  int score = 0;
//  int matchCount =0;
//
//  for (NSUInteger j = 0; j < otherCards.count; ++j) {
//    CGPlayingCard *card = [otherCards objectAtIndex:j];
//
//    for (NSUInteger i = 1 + j; i < otherCards.count; ++i) {
//      CGPlayingCard *otherCard = [otherCards objectAtIndex:i];
//
//      if (card.rank == otherCard.rank) {
//        score += kRankMatchScore;
//        matchCount += 1;
//      } else if ([card.suit isEqualToString:otherCard.suit]) {
//        score += kSuitMatchScore;
//        matchCount += 1;
//      }
//    }
//  }
//
//  if (matchMethod == kThreeCardMatchSystem) {
//    [self calculateThreeCardScore:matchCount score:&score];
//  }
//
//  return score;
//}


@end

NS_ASSUME_NONNULL_END
