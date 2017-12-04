// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by nimrod gruber.

#import "HistoryViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HistoryViewController ()

@property (strong, nonatomic) NSMutableArray *logMatchGame;
@property (strong, nonatomic) NSMutableArray *logSetGame;

@end

@implementation HistoryViewController

//- (void)setTextOfMatchMove:(NSMutableString *)textOfMatchMove {
//  _textOfMatchMove = textOfMatchMove;
//
//  if (self.view.window) {
//   [self updateMatchHistory];
//  }
//}

- (void)setTextOfSetMove:(NSMutableString *)textOfSetMove {
  _textOfSetMove = textOfSetMove;
  [self.logSetGame addObject:textOfSetMove];
  NSLog(@"@", self.logSetGame);
//  NSLog(@"%ld", self.game.matchMode);
  [self updateSetHistory];
  
//  if (self.view.window) {
//    [self updateSetHistory];
//  }
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:YES];
  [self updateSetHistory];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  _logMatchGame = [[NSMutableArray alloc] init];
  _logSetGame = [[NSMutableArray alloc] init];
}

- (void)updateSetHistory {
  self.historyOfSetGame = nil;
  
  for (int i = 0; i < [self.logSetGame count]; ++i) {
    self.historyOfSetGame.text = [self.historyOfSetGame.text stringByAppendingString:self.logSetGame[i]];
    self.historyOfSetGame.text = [self.historyOfSetGame.text stringByAppendingString:@"/n"];
  }
}

//- (void)updateMatchHistory {
//
//}

@end

NS_ASSUME_NONNULL_END
