// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by nimrod gruber.

#import "CGSetGame.h"
#import "CGSetCard.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CGSetGame()

@property (strong, nonatomic) NSMutableArray<CGCard *> *cards;
//@property (readwrite, nonatomic) NSMutableString *log;
@property (strong, nonatomic, nullable) NSMutableArray<CGCard *> *pickedCards;
//@property (readwrite, nonatomic) NSInteger score;

@end

@implementation CGSetGame

static const int kMismatchPenalty = 2;
static const int kMatchBonus = 12;
static const int kCostToChoose = 1;
//static const int kMaxLogLength = 6; //  ==> card.contents.length * 3.

- (nullable instancetype)initWithCardCount:(NSUInteger)count usingDeck:(CGDeck *)deck {
  if (self = [super init]) {
    _cards = [[NSMutableArray<CGCard *> alloc] init];
    self.log = [[NSMutableString alloc] init];
    self.matchMode = 3; //in set game matchMode is always 3
    _pickedCards = [[NSMutableArray<CGCard *> alloc] init];
    self.score = 0;
    for (NSUInteger i = 0; i < count; ++i) {
      CGCard *card = [deck drawRandomCard];
      if (card) {
        [self.cards addObject:card];
      } else {
        self = nil;
        break;
      }
    }
  }
  
  return self;
}

- (CGCard *)cardAtIndex:(NSUInteger)index
{
  return (index <= self.cards.count) ? self.cards[index] : nil;
}

- (void)chooseCardAtIndex:(NSUInteger)index {
  CGCard *card = [self cardAtIndex:index];
  
  [self flipAndClearPickedCardsIfNeeded:card];
  
  if (card.matched) {
    return;
  } else if (card.chosen) {
    card.chosen = NO;
    [self.pickedCards removeObject:card];
//    [self logRemoveUnchosenCard:card];
  } else {
    [self logAddChosenCard:card];
    
    card.chosen = YES;
    
    if (self.pickedCards.count == self.matchMode - 1) {
      int matchScore = 0;
      matchScore = [card matchThreeCards:self.pickedCards];
      
      if (matchScore) {
        self.score += matchScore * kMatchBonus;
        [self logPresentMatchScore:card points:(matchScore * kMatchBonus) success:YES];
        [self markCardsMatchedSign:card cards:self.pickedCards sign:YES];
      } else {
        self.score -= kMismatchPenalty;
        [self logPresentMatchScore:card points:(kMismatchPenalty + kCostToChoose) success:NO];
      }
    }
    
    [self.pickedCards addObject:card];
    
    self.score -= kCostToChoose;
  }
}

//same as set game
- (void)flipAndClearPickedCardsIfNeeded:(CGCard *)card {
  if (self.pickedCards.count == self.matchMode) {
    if ([self.pickedCards firstObject].matched == NO) {
      [self markCardsChosenSign:card cards:self.pickedCards sign:NO];
    }
    [self.pickedCards removeAllObjects];
  }
}

//same as set game
- (void)markCardsChosenSign:(CGCard *)card cards:(NSMutableArray *)cards sign:(BOOL)sign {
  for (CGCard *picked in cards) {
    picked.chosen = sign;
  }
  
  card.chosen = sign;
}

//same as set game
- (void)markCardsMatchedSign:(CGCard *)card cards:(NSMutableArray *)cards sign:(BOOL)sign {
  for (CGCard *picked in cards) {
    picked.matched = sign;
  }
  
  card.matched = sign;
}

-(void)extractCardAttributedTitle:(CGCard *)card title:(NSMutableAttributedString *)title {
  [title appendAttributedString:[[NSAttributedString alloc] initWithString: [[NSString alloc] initWithFormat:@"%d%@",[self findCardNumber:card], [self findCardSymbol:card]]]];
  
  if ([self findCardShade:card] == opened) {
    [title setAttributes:@{ NSForegroundColorAttributeName : [self findCardColor:card],
                            NSStrokeWidthAttributeName : @-5 }
                   range:NSMakeRange(0, [title length])];
  } else if ([self findCardShade:card] == solid) {
    [title setAttributes:@{ NSForegroundColorAttributeName : [self findCardColor:card],
                            NSStrokeWidthAttributeName : @5 }
                   range:NSMakeRange(0, [title length])];
  } else { // (setCard.shading == striped)
    if ([self findCardColor:card] == [UIColor redColor]) {
      [title setAttributes:@{ NSForegroundColorAttributeName : [self findCardColor:card],
                              NSBackgroundColorAttributeName : [[UIColor redColor] colorWithAlphaComponent:0.2] }
                     range:NSMakeRange(0, [title length])];
    } else if ([self findCardColor:card] == [UIColor greenColor]) {
      [title setAttributes:@{ NSForegroundColorAttributeName : [self findCardColor:card],
                              NSBackgroundColorAttributeName : [[UIColor greenColor] colorWithAlphaComponent:0.2] }
                     range:NSMakeRange(0, [title length])];
    } else {
      [title setAttributes:@{ NSForegroundColorAttributeName : [self findCardColor:card],
                              NSBackgroundColorAttributeName : [[UIColor purpleColor] colorWithAlphaComponent:0.2] }
                     range:NSMakeRange(0, [title length])];
    }
  }
}

- (ShadeType)findCardShade:(CGCard *)card {
  CGSetCard *setCard = (CGSetCard *) card;
  if (setCard.shading == solid) {
    return solid;
  } else if (setCard.shading == opened) {
    return opened;
  } else { // (setCard.shading == striped)
    return striped;
  }
}

- (UIColor *)findCardColor:(CGCard *)card {
  CGSetCard *setCard = (CGSetCard *) card;
  
  if (setCard.color == red) {
    return [UIColor redColor];
  } else if (setCard.color == green) {
    return [UIColor greenColor];
  } else { //(setCard.color == purple)
    return [UIColor purpleColor];
  }
}

- (int)findCardNumber:(CGCard *)card {
  CGSetCard *setCard = (CGSetCard *)card;
  return setCard.number;
}

- (NSString *)findCardSymbol:(CGCard *)card {
  CGSetCard *setCard = (CGSetCard *)card;
  
  if (setCard.symbol == triangle) {
    return @"▲";
  } else if (setCard.symbol == circle) {
    return @"●";
  } else { //setCard.symbol == squar
    return @"■";
  }
}

- (void)logRemoveUnchosenCard:(CGCard *)card {
//  NSMutableAttributedString *title = [[NSMutableAttributedString alloc] init];
//  [self extractCardAttributedTitle:card title:title];
  
  NSRange cardRange = [self.log rangeOfString:card.contents];
  [self.log deleteCharactersInRange:cardRange];
}

- (void)logAddChosenCard:(CGCard *)card {
  if (self.log.length > 6) {
    [self.log setString: @""];
  }
  NSMutableAttributedString *title = [[NSMutableAttributedString alloc] init];
  [self extractCardAttributedTitle:card title:title];
  
  [self.log appendString:[NSString stringWithFormat:@"%@", title]];
//  [self.log appendString:[NSString stringWithFormat:@"%@", card.contents]];
}

- (void)logPresentMatchScore:(CGCard *)card points:(NSUInteger)points success:(BOOL)success {
  [self.log setString: @""];
  
  NSMutableAttributedString *title = [[NSMutableAttributedString alloc] init];
  for (CGCard *pCard in self.pickedCards) {
    [self extractCardAttributedTitle:pCard title:title];
    
    [self.log appendString:[NSString stringWithFormat:@"%@", title]];
    //[self.log appendString:[NSString stringWithFormat:@"%@", pCard.contents]];
  }
  
  [self extractCardAttributedTitle:card title:title];
  [self.log appendString:[NSString stringWithFormat:@"%@", title]];
 // [self.log appendString:[NSString stringWithFormat:@"%@", card.contents]];
  
  if (success) {
    [self.log appendString:[NSString stringWithFormat:@" matched for %lu points", (unsigned long)points]];
  } else {
    [self.log appendString:[NSString stringWithFormat:@" wrong match %lu penalty", (unsigned long)points]];
  }
}

@end

NS_ASSUME_NONNULL_END
