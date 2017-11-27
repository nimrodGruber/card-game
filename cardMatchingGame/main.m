//
//  main.m
//  cardMatchingGame
//
//  Created by nimrod gruber on 19/11/2017.
//  Copyright © 2017 Lightricks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}



/* old version of choose card at index:
 //  if (!card.matched) {
 //    if (card.chosen) {
 //      card.chosen = NO;
 //    } else { // Match against 1 card.
   //      for (CGCard *otherCard in self.cards) {
   //        if (otherCard.chosen && !otherCard.matched) {
   //          int matchScore = [card match:@[otherCard]];
   //          if (matchScore) {
   //            self.score += matchScore * kMatchBonus;
   //            card.matched = YES;
   //            otherCard.matched = YES;
   //          } else {
   //            self.score -= kMismatchPenalty;
   //            otherCard.chosen = NO;
   //          }
   //          break;
   //        }
   //      }
   //      self.score -= kCostToChoose;
   //      card.chosen = YES;
 
 
 if (!card.matched) {
 if (card.chosen) {
 card.chosen = NO;
 [self logRemoveUnchosenCard:card];
 } else { // Match against 2 cards.
 [self logAddChosenCard:card];
 
 for (CGCard *otherCard in self.cards) {
 if (otherCard.chosen && !otherCard.matched) {
 [self.pickedCards addObject:otherCard];
 }
 }
 
 if (self.pickedCards.count == 2) {
 int matchScore = [card match:self.pickedCards matchMethod:self.matchMode];
 if (matchScore) {
 self.score += matchScore * kMatchBonus;
 card.matched = YES;
 [self logPresentMatchScore:card matchScore:(matchScore * kMatchBonus) success:YES];
 [self markCardsMatchedSign:self.pickedCards sign:YES];
 } else {
 self.score -= kMismatchPenalty;
 [self markCardsChosenSign:self.pickedCards sign:NO];
 [self logPresentMatchScore:card matchScore:(kMismatchPenalty + kCostToChoose) success:NO];
 }
 }
 
 [self.pickedCards removeAllObjects];
 self.score -= kCostToChoose;
 card.chosen = YES;
 }
 }
 */
