// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by nimrod gruber.

#import "CGSetCard.h"

NS_ASSUME_NONNULL_BEGIN

@implementation CGSetCard


//@synthesize suit = _suit;
//
//static const int kRankMatchScore = 4;
//static const int kSuitMatchScore = 1;
//static const int kThreeMatchBonus = 10;
//
//- (NSString *)contents {
//  NSArray *rankStrings = [CGPlayingCard rankStrings];
//
//  return [rankStrings[static_cast<unsigned long long>(self.rank)] stringByAppendingString:self.suit];
//}
//
- (instancetype)init {
  if (self = [super init]) {
    _number = 0;
    _symbol = @"?";
    _shading = undefinedSymbol;
    _color = undefinedColor;
  }

  return self;
}


//- (int)matchThreeCards:(NSMutableArray *)otherCards {
//  int score = 0;
//  int matchCount =0;
//
//  for (CGPlayingCard *card in otherCards) {
//    if (self.rank == card.rank) {
//      score += kRankMatchScore;
//      matchCount += 1;
//    } else if ([self.suit isEqualToString:card.suit]) {
//      score += kSuitMatchScore;
//      matchCount += 1;
//    }
//  }
//
//  CGPlayingCard *first = [otherCards firstObject];
//  CGPlayingCard *second = [otherCards lastObject];
//
//  if (first.rank == second.rank) {
//    score += kRankMatchScore;
//    matchCount += 1;
//  } else if ([first.suit isEqualToString:second.suit]) {
//    score += kSuitMatchScore;
//    matchCount += 1;
//  }
//
//  if (matchCount == 3) {
//    score *= kThreeMatchBonus;
//  }
//
//  return score;
//}
//
//+ (NSUInteger)maxRank {
//  return [[self rankStrings] count] -1;
//}
//
//+ (NSArray *)rankStrings {
//  return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
//}
//
//- (void)setRank:(NSUInteger)rank {
//  if (rank <= [CGPlayingCard maxRank]) {
//    _rank = rank;
//  }
//}
//
//- (void)setSuit:(NSString *)suit {
//  if ([[CGPlayingCard validSuits] containsObject:suit]) {
//    _suit = suit;
//  }
//}
//
//- (NSString *)suit {
//  return _suit ? _suit : @"?";
//}
//
//+ (NSArray *)validSuits {
//  return @[@"♠️", @"♣️", @"♥️", @"♦️"];
//}



@end

NS_ASSUME_NONNULL_END
