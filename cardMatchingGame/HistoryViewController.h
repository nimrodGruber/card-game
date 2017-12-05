// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by nimrod gruber.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HistoryViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *historyOfGame;

- (void)updateHistory:(NSMutableArray <NSString *> *)log;

@end

NS_ASSUME_NONNULL_END
