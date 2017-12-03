// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by nimrod gruber.

#import "CGSetCard.h"
#import "CGSetDeck.h"

NS_ASSUME_NONNULL_BEGIN

@implementation CGSetDeck

static const int kMaxSetCardFeatures = 3;

- (instancetype)init {
  if (self = [super init]) {
    for (int colorNum = 0; colorNum < kMaxSetCardFeatures; ++colorNum) {
      for (int numberNum = 0; numberNum < kMaxSetCardFeatures; ++numberNum) {
        for (int shadingNum = 0; shadingNum < kMaxSetCardFeatures; ++shadingNum) {
          for (int symbolNum = 0; symbolNum < kMaxSetCardFeatures; ++symbolNum) {
            CGSetCard *card = [[CGSetCard alloc] initWithCardColor:colorNum
                                                   usingNumberType:numberNum
                                                    usingShadeType:shadingNum
                                                    usingSymbolType:symbolNum];
            [self addCard:card];
          }
        }
      }
    }
  }

  return self;
}

@end

NS_ASSUME_NONNULL_END
