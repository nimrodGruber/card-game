// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by nimrod gruber.

#import "CGSetCard.h"

NS_ASSUME_NONNULL_BEGIN

@implementation CGSetCard

@synthesize color = _color;
@synthesize number = _number;
@synthesize shading = _shading;
@synthesize symbol = _symbol;

- (instancetype)init {
  if (self = [super init]) {
    _number = undefinedNumber;
    _symbol = undefinedSymbol;
    _shading = undefinedShade;
    _color = undefinedColor;
  }

  return self;
}

- (int)matchThreeCards:(NSMutableArray *)otherCards {

  BOOL cardsAreLegalSet = NO;
  
  CGSetCard *first = [otherCards firstObject];
  CGSetCard *second = [otherCards lastObject];
  
  if ( ((self.number == first.number == second.number) || (self.number != first.number != second.number)) &&
       ((self.symbol == first.symbol == second.symbol) || (self.symbol != first.symbol != second.symbol)) &&
       ((self.shading == first.shading == second.shading) || (self.shading != first.shading != second.shading)) &&
       ((self.color == first.color == second.color) || (self.color != first.color != second.color)) ) {
    cardsAreLegalSet = YES;
  }

  return cardsAreLegalSet;
}

- (ColorType)color {
  return ((_color < undefinedColor) && (_color >= 0)) ? _color : undefinedColor;
}

- (NumberType)number {
  return ((_number < undefinedNumber) && (_number >= 0)) ? _number : undefinedNumber;
}

- (ShadeType)shading {
  return ((_shading < undefinedShade) && (_shading >= 0)) ? _shading : undefinedShade;
}

- (SymbolType)symbol {
  return ((_symbol < undefinedSymbol) && (_symbol >= 0)) ? _symbol : undefinedSymbol;
}

-(void)setColor:(ColorType)color {
  if ((color < undefinedColor) && (color >= 0)) {
    _color = color;
  }
}

-(void)setNumber:(NumberType)number {
  if ((number < undefinedNumber) && (number >= 0)) {
    _number = number;
  }
}

-(void)setShading:(ShadeType)shading {
  if ((shading < undefinedShade) && (shading >= 0)) {
    _shading = shading;
  }
}

-(void)setSymbol:(SymbolType)symbol {
  if ((symbol < undefinedSymbol) && (symbol >= 0)) {
    _symbol = symbol;
  }
}

@end

NS_ASSUME_NONNULL_END
