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
    
    //
    NSLog(@"%@", self->WLSnapshots);
    [self oneStepForward];
    /*
    int ladderLength = 0;
    NSMutableSet* dict_m = [dict mutableCopy];
    [dict_m addObject:end];
   
    for(NSString* word in dict_m) {
        int distance = [start getDistanceTo:word];
        NSLog(@"%@ TO %@ -> DISTANCE : %d",start,word,distance);
        NSLog(@"dict : %@",dict_m);

        if(distance==1) {
            NSMutableSet* new_dict = [dict_m mutableCopy];
            [new_dict removeObject:word];
            NSLog(@"new dict : %@",new_dict);
            NSLog(@"start :%@, end: %@",word,end);
            ladderLength = [self getLadderLengthStartsWith:word endsWith:end within:new_dict]+1;
        } else if(distance==0)  {
            ladderLength = 0;
        }
    }
    */
    return 0;
}

- (void) oneStepForward {
    // distance를 구할 임시 Array (dict +
}
@end
