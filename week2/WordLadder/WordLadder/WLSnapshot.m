//
//  WLSnapshot.m
//  WordLadder
//
//  Created by KIM HEE JAE on 7/21/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import "WLSnapshot.h"

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
    // distance를 구할 임시 Array (dict + end) 를 마련한다
    // 여기서 start와 distance가 1인단어들을 찾는다.
    
        // 찾았으면 이 단어를 start로 하고, 이 단어가 dict에서 제외된(선택), 이 단어가 transformations에 추가된 WLSnapshot 을 생성한다.
    
    //WLSnapshot 들의 array를 반환한다.
}

- (bool) isOver {
    // 진행이 끝난 경우1 start와 end가 같다면 진행이 완료되었으며, 이행이 성공한 경우이다. transformations의 원소 수가 ladder length 이다.
    // 진행이 끝난 경우2 start와 end가 다른데 start와 distance가 1인단어가 없는 경우. 이행실패 ㅠㅠ
}

- (int) getLadderLength {
    // 진행이 끝나지 않은 경우는 -1
    // 진행이 끝나고 성공했다면 1 이상의 실제 길이값
    // 진행이 끝나고 실패한 경우는 0 을 반환.
    
    return 0;
}

@end
