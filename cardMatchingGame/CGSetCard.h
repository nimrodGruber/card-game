// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by nimrod gruber.

#import "CGCard.h"

NS_ASSUME_NONNULL_BEGIN

@interface CGSetCard : CGCard

//+ (NSUInteger)maxRank;
//+ (NSArray *)validSuits;

typedef enum {
  solid = 0,
  striped = 1,
  opened = 2,
  undefinedSymbol
} ShadeType;

typedef enum {
  red = 0,
  green = 1,
  purple = 2,
  undefinedColor
} ColorType;

@property (nonatomic) NSUInteger number;
@property (strong, nonatomic) NSString *symbol;
@property (nonatomic) ShadeType shading;
@property (nonatomic) ColorType color;

@end

NS_ASSUME_NONNULL_END
