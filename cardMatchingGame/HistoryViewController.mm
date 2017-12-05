// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by nimrod gruber.

#import "HistoryViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HistoryViewController ()

@end

@implementation HistoryViewController

- (void)updateHistory:(NSMutableArray <NSString *> *)log {
  for (int i = 0; i < log.count; ++i) {
    self.historyOfGame.text = [self.historyOfGame.text stringByAppendingString:log[i]];
  }
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:YES];
}

- (void)viewDidLoad {
  [super viewDidLoad];
}


@end

NS_ASSUME_NONNULL_END
