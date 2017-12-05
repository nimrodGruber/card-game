// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by nimrod gruber.

#import "HistoryBoss.h"

NS_ASSUME_NONNULL_BEGIN

@implementation HistoryBoss

- (instancetype)init {
  if (self = [super init]) {
    _logMatchGame = [[NSMutableArray alloc] init];
    _logSetGame = [[NSMutableArray alloc] init];
  }
  
  return self;
}

@end

NS_ASSUME_NONNULL_END
