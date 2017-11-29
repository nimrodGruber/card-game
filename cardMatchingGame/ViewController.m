//
//  ViewController.m
//  cardMatchingGame
//
//  Created by nimrod gruber on 19/11/2017.
//  Copyright © 2017 Lightricks. All rights reserved.
//

#import "CGCardMatchingGame.h"
//#import "CGPlayingCardDeck.h"

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CGCardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLable;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (weak, nonatomic) IBOutlet UILabel *logLable;

@end

@implementation ViewController

- (UIImage *)backGroundImageForCard:(CGCard *)card {
  return [UIImage imageNamed:card.chosen ? @"cardFront" : @"cardBack"];
}

- (CGDeck *)createDeck { // Abstract.
  //return [[CGPlayingCardDeck alloc] init];
  return nil;
}

- (CGCardMatchingGame *)game
{
  if (!_game) {
    _game = [[CGCardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[self createDeck]];
  }
  
  return _game;
}

- (IBAction)reDeal:(UIButton __unused *)sender {
  self.game = nil;
  [self updateUI];
  [self enableSegmentControl];
}

- (NSString *)titleForCard:(CGCard *)card {
  return card.chosen ? card.contents : @"";
}

- (IBAction)touchCardButton:(UIButton *)sender {
  [self disableSegmentControl];
  NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
  [self.game chooseCardAtIndex:chosenButtonIndex];
  [self updateUI];
}

- (void) updateUI {
  for (UIButton *cardButton in self.cardButtons) {
    NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
    CGCard *card = [self.game cardAtIndex:cardButtonIndex];
    [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
    [cardButton setBackgroundImage:[self backGroundImageForCard:card] forState:UIControlStateNormal];
    cardButton.enabled = !card.matched;
    self.scoreLable.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
    self.logLable.text = self.game.log;
  }
}

- (IBAction)methodPicking:(UISegmentedControl __unused *)sender {
  if (self.segmentControl.selectedSegmentIndex == 0) {
    self.game.matchMode = 2;
    NSLog(@"%ld", self.game.matchMode);
  } else {
    self.game.matchMode = 3;
    NSLog(@"%ld", self.game.matchMode);
  }
}

-(void)disableSegmentControl {
  self.segmentControl.enabled = NO;
}

-(void)enableSegmentControl {
  self.segmentControl.enabled = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
