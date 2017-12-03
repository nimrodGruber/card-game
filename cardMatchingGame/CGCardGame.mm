// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by nimrod gruber.

#import "CGCardGame.h"

NS_ASSUME_NONNULL_BEGIN

@implementation CGCardGame

- (CGCard *)cardAtIndex:(NSUInteger)index { // Abstract.
  return nil;
}

- (void)chooseCardAtIndex:(NSUInteger)index { // Abstract.
}

@end

NS_ASSUME_NONNULL_END
