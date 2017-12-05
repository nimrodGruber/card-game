// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by nimrod gruber.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HistoryViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *historyOfSetGame;
@property (strong, nonatomic) NSString *textOfMatchMove;
@property (strong, nonatomic) NSString *textOfSetMove;
@property (strong, nonatomic) NSMutableArray <NSMutableString *> *logMatchGame;
@property (strong, nonatomic) NSMutableArray <NSMutableString *> *logSetGame;

@end

NS_ASSUME_NONNULL_END
