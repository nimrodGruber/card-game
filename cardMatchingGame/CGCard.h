// Copyright (c) 2017 Lightricks. All rights reserved.
// Created by nimrod gruber.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CGCard : NSObject

-(int)match:(NSArray *)otherCards;

@property (nonatomic) BOOL chosen;
@property (strong, nonatomic) NSString *contents;
@property (nonatomic) BOOL matched;

-(int)match:(NSArray *)otherCards matchMethod:(NSUInteger)matchMethod;
-(int)matchTwoCards:(NSArray *)otherCards;
-(int)matchThreeCards:(NSArray *)otherCards;

@end

NS_ASSUME_NONNULL_END
