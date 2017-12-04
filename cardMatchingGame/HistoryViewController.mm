// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by nimrod gruber.

#import "HistoryViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HistoryViewController ()

@end

@implementation HistoryViewController

- (void)setTextOfMatchMove:(NSMutableString *)textOfMatchMove {
  _textOfMatchMove = textOfMatchMove;
  
  if (self.view.window) {
   [self updateMatchHistory];
  }
}

- (void)setTextOfSetMove:(NSMutableString *)textOfSetMove {
  _textOfSetMove = textOfSetMove;
  
  if (self.view.window) {
    [self updateSetHistory];
  }
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:YES];
  [self updateSetHistory];
}

- (void)updateSetHistory {
  [self.historyOfSetGame setText:self.textOfSetMove];
}

- (void)updateMatchHistory {
  
}

@end

NS_ASSUME_NONNULL_END
