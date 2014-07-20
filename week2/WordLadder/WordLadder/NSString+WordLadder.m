//
//  NSString+WordLadder.m
//  WordLadder
//
//  Created by KIM HEE JAE on 7/20/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import "NSString+WordLadder.h"

@implementation NSString (WordLadder)

- (int) getDistanceTo:(NSString*)destination {
    // 출발지와 목적지의 문자 수가 같다는 전제
    int count = 0;
    for (int i=0; i<[self length]; i++) {
        NSInteger index = i;
        if(![[self getCharacterAtIndex:index] isEqualToString:[destination getCharacterAtIndex:index]]){
            count++;
        }
    }
    return count;
}
- (NSString*) getCharacterAtIndex:(NSUInteger)index {
    return [[self substringFromIndex:index] substringToIndex:1];
}
            
@end
