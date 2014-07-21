//
//  WordLadder.m
//  WordLadder
//
//  Created by KIM HEE JAE on 7/20/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import "WordLadder.h"
#import "NSString+WordLadder.h"
#import "WLSnapshot.h"

@implementation WordLadder

- (int) getLadderLengthStartsWith:(NSString*)start endsWith:(NSString*)end within:(NSSet*)dict {
    // 멤버 초기화
    self->step = 0;
    self->WLSnapshots = [[NSMutableArray alloc]init];
    
    // 인자 초기화
    WLSnapshot* initialWLSnapshot = [[WLSnapshot alloc] init];
    [initialWLSnapshot setStart: start];
    [initialWLSnapshot setEnd: end];
    [initialWLSnapshot setDict:[dict mutableCopy]];
    [initialWLSnapshot setTransformations:[NSMutableArray arrayWithObject:start]];
    [self->WLSnapshots addObject:initialWLSnapshot];
    
    while (![self everyStepVisited]) {
        [self oneStepForward];
    }

    return [self getMinimunLadderLength];
}

- (void) oneStepForward {
    NSMutableArray* new_snapshots = [[NSMutableArray alloc] init];
    for(WLSnapshot* snapshot in self->WLSnapshots){
        NSMutableArray* child_snapshots = [snapshot oneStepForward];
        [new_snapshots addObjectsFromArray:child_snapshots];
    }
    self->WLSnapshots = new_snapshots;
}

- (bool) everyStepVisited {
    bool everyStepVisited = YES;
    for(WLSnapshot* snapshot in self->WLSnapshots){
        if (![snapshot isOver]) {
            everyStepVisited = NO;
        }
    }
    return everyStepVisited;
}

- (int) getMinimunLadderLength {
    int ladderLength = [[self->WLSnapshots objectAtIndex:0] getLadderLength];
    for(WLSnapshot* snapshot in self->WLSnapshots){
        int ladderLength_temp = [snapshot getLadderLength];
        if (ladderLength_temp > 0 && ladderLength_temp < ladderLength) {
            ladderLength = ladderLength_temp;
        }
    }
    return ladderLength;
}
@end
