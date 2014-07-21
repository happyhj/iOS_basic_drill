//
//  WLSnapshot.m
//  WordLadder
//
//  Created by KIM HEE JAE on 7/21/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import "WLSnapshot.h"
#import "NSString+WordLadder.h"

@implementation WLSnapshot

- (NSMutableArray *)transformations {
    return transformations;
}

- (void)setTransformations:(NSMutableArray *)newValue {
    transformations = newValue;
}

- (NSString *)start {
    return start;
}

- (void)setStart:(NSString *)newValue {
    start = newValue;
}

- (NSString *)end {
    return end;
}

- (void)setEnd:(NSString *)newValue {
    end = newValue;
}

- (NSMutableSet *)dict {
    return dict;
}

- (void)setDict:(NSMutableSet *)newValue {
    dict = newValue;
}


- (NSMutableArray*) oneStepForward {

    if ([self isOver]){
        return [NSMutableArray arrayWithObject:self];
    }
    
    // distance를 구할 임시 Array (dict + end) 를 마련한다
    NSMutableSet* extended_set = [self->dict mutableCopy];
    [extended_set addObject:end];

    // 여기서 start와 distance가 1인단어들을 찾는다.
    NSMutableArray* new_snapshots = [[NSMutableArray alloc]init];
    for (NSString* word in extended_set) {
        if([word getDistanceTo:start] == 1){
            NSString* new_start = word;
            NSString* new_end = self->end;
            NSMutableSet* new_dict = [self->dict mutableCopy];
            [new_dict removeObject:word];
            NSMutableArray* new_transformations = [self->transformations mutableCopy];
            [new_transformations addObject:word];
            
            WLSnapshot* new_snapshot = [[WLSnapshot alloc] init];
            [new_snapshot setStart:new_start];
            [new_snapshot setTransformations:new_transformations];
            [new_snapshot setEnd:new_end];
            [new_snapshot setDict:new_dict];
 
            if([new_snapshot isOver]) { // 끝났으면 끝났다고 하기
                int result = [new_snapshot getLadderLength];
                if(result != 0) {
                    NSLog(@"진행이 완료 되었습니다. 사다리길이 : %d", result);
                } else {
                    NSLog(@"진행이 완료 되었습니다. 결과는 실패 end에 도달가능한 경로가 아닙니다.");                    
                }
                NSLog(@"진행경로 : %@",new_snapshot.transformations);
            }
            
            [new_snapshots addObject:new_snapshot];
        }
    }
    // 찾았으면 이 단어를 start로 하고, 이 단어가 dict에서 제외된(선택), 이 단어가 transformations에 추가된 WLSnapshot 을 생성한다.
   
    
    //WLSnapshot 들의 array를 반환한다.
    return new_snapshots;
}

- (bool) isOver {
    // 진행이 끝난 경우1 start와 end가 같다면 진행이 완료되었으며, 이행이 성공한 경우이다. transformations의 원소 수가 ladder length 이다.
    if([self->start isEqualToString:self->end]) return YES;
    // 진행이 끝난 경우2 start와 end가 다른데 start와 distance가 1인단어가 없는 경우. 이행실패 ㅠㅠ
    else {
        NSMutableSet* extended_set = [self->dict mutableCopy];
        [extended_set addObject:end];
        
        // 여기서 start와 distance가 1인단어들을 찾는다.
        NSMutableArray* new_starts= [[NSMutableArray alloc]init];
        for (NSString* word in extended_set) {
            if([word getDistanceTo:start] == 1){
                [new_starts addObject:word];
            }
        }
        if([new_starts count]==0) return YES;
    }
    return NO;
}

- (int) getLadderLength {
    // 진행이 끝나지 않은 경우는 -1
    if (![self isOver]) {
        return -1;
    }
    // 진행이 끝나고 성공했다면 1 이상의 실제 길이값
    if([self->start isEqualToString:self->end]) {
        return (int)[self->transformations count];
    }
    // 진행이 끝나고 실패한 경우는 0 을 반환.
    return 0;
}

@end
