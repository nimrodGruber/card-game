// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by nimrod gruber.

#import "HistoryViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HistoryViewController ()
@property (weak, nonatomic) IBOutlet HistoryViewController *matchingHistory;

@end

@implementation HistoryViewController

- (void)setHistoryText:(NSMutableString *)historyText {
  [historyText appendString:@""];
  [historyText appendString:historyText];
  if (self.view.window) {
   [self updateHistoryUI];
  }
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:YES];
  [self updateHistoryUI];
}



- (void)updateHistoryUI {
  
}

@end

NS_ASSUME_NONNULL_END
