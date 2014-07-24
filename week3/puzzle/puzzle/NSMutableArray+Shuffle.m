//
//  NSMutableArray+Shuffle.m
//  puzzle
//
//  Created by KIM HEE JAE on 7/24/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import "NSMutableArray+Shuffle.h"
#include <Cocoa/Cocoa.h>

@implementation NSMutableArray (Shuffle)
- (void)shuffle
{
    NSUInteger count = [self count];
    for (NSUInteger i = 0; i < count; ++i) {
        NSInteger remainingCount = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform((int)remainingCount);
        [self exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
}
- (void)swapElementAtIndex:(NSInteger)index1 withAtIndex:(NSInteger)index2
{
    id temp = [self objectAtIndex:index1];
    [self replaceObjectAtIndex:index1 withObject:[self objectAtIndex:index2]];
    [self replaceObjectAtIndex:index2 withObject:temp];
}
@end
