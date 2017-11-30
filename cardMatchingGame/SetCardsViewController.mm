// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by nimrod gruber.

#import "CGSetDeck.h"
//#import "CGPlayingCardDeck.h"
#import "SetCardsViewController.h"

NS_ASSUME_NONNULL_BEGIN

@implementation SetCardsViewController

//- (CGDeck *)createDeck {
//  return [[CGPlayingCardDeck alloc] init];
//}

- (CGDeck *)createDeck {
  return [[CGSetDeck alloc] init];
}

//- (void)viewWillAppear:(BOOL)animated {
//  [super viewWillAppear:animated];
//}

@end

NS_ASSUME_NONNULL_END











