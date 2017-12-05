// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by nimrod gruber.

#import "HistoryViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HistoryViewController ()

@end

@implementation HistoryViewController

//- (void)setTextOfMatchMove:(NSMutableString *)textOfMatchMove {
//  _textOfMatchMove = textOfMatchMove;
//
//  if (self.view.window) {
//   [self updateMatchHistory];
//  }
//}

- (void)setLogSetGame:(NSMutableArray<NSMutableString *> *)logSetGame {
  _logSetGame = logSetGame;
//  for (int i = 0; i < logSetGame.count; ++i) {
//    self.historyOfSetGame.text = [self.historyOfSetGame.text stringByAppendingString:self.logSetGame[i]];
//  }
//  [self.logSetGame addObject:textOfSetMove];
  //  NSLog(@"%ld", self.game.matchMode);
  [self updateSetHistory];
  
  //  if (self.view.window) {
  //    [self updateSetHistory];
  //  }
}



//- (void)setTextOfSetMove:(NSMutableString *)textOfSetMove {
//  _textOfSetMove = textOfSetMove;
//  if (!self.logSetGame) {
//    self.logSetGame = [[NSMutableArray alloc] init];
//  }
//  [self.logSetGame addObject:textOfSetMove];
////  NSLog(@"%ld", self.game.matchMode);
//  [self updateSetHistory];
//
////  if (self.view.window) {
////    [self updateSetHistory];
////  }
//}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:YES];
  [self updateSetHistory];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  if (!self.logSetGame) {
    _logSetGame = [[NSMutableArray alloc] init];
  }
  if (!self.logMatchGame) {
    _logMatchGame = [[NSMutableArray alloc] init];    
  }
}

- (void)updateSetHistory {
  for (int i = 0; i < self.logSetGame.count; ++i) {
    self.historyOfSetGame.text = [self.historyOfSetGame.text stringByAppendingString:self.logSetGame[i]];
    //self.historyOfSetGame.text = [self.historyOfSetGame.text stringByAppendingString:@""];
  }
}

//- (void)updateMatchHistory {
//
//}

@end

NS_ASSUME_NONNULL_END
