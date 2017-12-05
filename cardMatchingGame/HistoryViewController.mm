// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by nimrod gruber.

#import "HistoryViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HistoryViewController ()

@end

@implementation HistoryViewController

- (void)setLog:(NSMutableArray <NSString *> *)log {
  _log = log;
  
  if (self.view.window) {
    [self updateHistory];
  }
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:YES];
  [self updateHistory];
}

//this public method fails to work from segue because this window is not yet called when the prepare for segue is called
//- (void)updateHistory:(NSMutableArray <NSString *> *)log {
//  for (int i = 0; i < log.count; ++i) {
//    [self.historyOfGame.text stringByAppendingString:log[i]];
//  }
//}

- (void)updateHistory {
  for (int i = 0; i < self.log.count; ++i) {
    self.historyOfGame.text = [self.historyOfGame.text stringByAppendingString:self.log[i]];
  }
}

- (void)viewDidLoad {
  [super viewDidLoad];
}


@end

NS_ASSUME_NONNULL_END
