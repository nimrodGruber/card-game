//
//  ViewController.h
//  cardMatchingGame
//
//  Created by nimrod gruber on 19/11/2017.
//  Copyright © 2017 Lightricks. All rights reserved.
//
// Abstract class. Must implement methods as described below.

#import "CGDeck.h"

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

// For subclasses.
- (CGDeck *)createDeck; // Abstract.

- (NSString *)titleForCard:(CGCard *)card; // Abstract.

- (UIImage *)backGroundImageForCard:(CGCard *)card; // Abstract.

@end
