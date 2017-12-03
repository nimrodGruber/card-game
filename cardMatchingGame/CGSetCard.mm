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
  NSMutableArray *cards = [[NSMutableArray alloc] init];
  [cards addObject:first];
  [cards addObject:second];
  [cards addObject:self];
  
  if ( (([self allNumbersAreEqual:cards]) || ([self allNumbersAreDifferent:cards])) &&
       (([self allSymbolAreEqual:cards])  || ([self allSymbolAreDifferent:cards]))  &&
       (([self allShadingAreEqual:cards]) || ([self allShadingAreDifferent:cards]))  &&
       (([self allColorsAreEqual:cards])  || ([self allColorsAreDifferent:cards]))  ) {
    cardsAreLegalSet = YES;
  }

  return cardsAreLegalSet;
}

- (BOOL)allNumbersAreEqual:(NSMutableArray *)cards {
  CGSetCard *first = [cards objectAtIndex:0];
  CGSetCard *second = [cards objectAtIndex:1];
  CGSetCard *third = [cards objectAtIndex:2];
  
  if ((first.number == second.number) && (first.number == third.number)) {
    return YES;
  } else {
    return NO;
  }
}

- (BOOL)allNumbersAreDifferent:(NSMutableArray *)cards {
  CGSetCard *first = [cards objectAtIndex:0];
  CGSetCard *second = [cards objectAtIndex:1];
  CGSetCard *third = [cards objectAtIndex:2];
  
  if ((first.number != second.number) && (first.number != third.number) && (second.number != third.number)) {
    return YES;
  } else {
    return NO;
  }
}

- (BOOL)allSymbolAreEqual:(NSMutableArray *)cards {
  CGSetCard *first = [cards objectAtIndex:0];
  CGSetCard *second = [cards objectAtIndex:1];
  CGSetCard *third = [cards objectAtIndex:2];
  
  if ((first.symbol == second.symbol) && (first.symbol == third.symbol)) {
    return YES;
  } else {
    return NO;
  }
}

- (BOOL)allSymbolAreDifferent:(NSMutableArray *)cards {
  CGSetCard *first = [cards objectAtIndex:0];
  CGSetCard *second = [cards objectAtIndex:1];
  CGSetCard *third = [cards objectAtIndex:2];
  
  if ((first.symbol != second.symbol) && (first.symbol != third.symbol) && (second.symbol != third.symbol)) {
    return YES;
  } else {
    return NO;
  }
}

- (BOOL)allShadingAreEqual:(NSMutableArray *)cards {
  CGSetCard *first = [cards objectAtIndex:0];
  CGSetCard *second = [cards objectAtIndex:1];
  CGSetCard *third = [cards objectAtIndex:2];
  
  if ((first.shading == second.shading) && (first.shading == third.shading)) {
    return YES;
  } else {
    return NO;
  }
}

- (BOOL)allShadingAreDifferent:(NSMutableArray *)cards {
  CGSetCard *first = [cards objectAtIndex:0];
  CGSetCard *second = [cards objectAtIndex:1];
  CGSetCard *third = [cards objectAtIndex:2];
  
  if ((first.shading != second.shading) && (first.shading != third.shading) && (second.shading != third.shading)) {
    return YES;
  } else {
    return NO;
  }
}

- (BOOL)allColorsAreEqual:(NSMutableArray *)cards {
  CGSetCard *first = [cards objectAtIndex:0];
  CGSetCard *second = [cards objectAtIndex:1];
  CGSetCard *third = [cards objectAtIndex:2];
  
  if ((first.color == second.color) && (first.color == third.color)) {
    return YES;
  } else {
    return NO;
  }
}

- (BOOL)allColorsAreDifferent:(NSMutableArray *)cards {
  CGSetCard *first = [cards objectAtIndex:0];
  CGSetCard *second = [cards objectAtIndex:1];
  CGSetCard *third = [cards objectAtIndex:2];
  
  if ((first.color != second.color) && (first.color != third.color) && (second.color != third.color)) {
    return YES;
  } else {
    return NO;
  }
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
