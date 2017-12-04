// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by nimrod gruber.

#import "CGDeck.h"
#import "CGCardGame.h"

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CGSetGame : CGCardGame

- (instancetype)init NS_UNAVAILABLE;
- (nullable instancetype)initWithCardCount:(NSUInteger)count
                                 usingDeck:(CGDeck *)deck NS_DESIGNATED_INITIALIZER;

- (CGCard *)cardAtIndex:(NSUInteger)index;
- (void)chooseCardAtIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END







