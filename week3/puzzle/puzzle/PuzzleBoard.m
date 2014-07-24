//
//  PuzzleBoard.m
//  puzzle
//
//  Created by KIM HEE JAE on 7/24/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import "PuzzleBoard.h"
#import "NSMutableArray+Shuffle.h"
#include <Cocoa/Cocoa.h>
#import "NSString+Command.h"

@implementation PuzzleBoard
- (id)initWithSize:(NSInteger)size_input;
{
    self = [self init];
    [self pauseGame];
    self->historyHead = -1;
    self->rows = [[NSMutableArray alloc] initWithCapacity:size_input];
    self->history =[[NSMutableArray alloc] init];

    NSMutableArray* initTemp = [[NSMutableArray alloc] initWithCapacity:size_input*size_input];
    for (NSInteger i = 1; i < size_input*size_input; i++) {
        [initTemp addObject:[NSNumber numberWithInteger:i]];
    }
    [initTemp addObject:[NSNumber numberWithInteger:0]];
    
    for (NSInteger i = 1; i <= size_input; i++) {
        NSMutableArray *row = [[NSMutableArray alloc] initWithCapacity:size];
        for (NSInteger j = 1; j <= size_input; j++) {
            long index = (i-1)*(size_input)+j -1;
            [row addObject:[initTemp objectAtIndex:index]];
        }
        [self->rows addObject:row];
    }
    [initTemp release];
    
    self->size = size_input;
    return self;
}

- (NSMutableArray*) getSerializedBoard {
    NSMutableArray* serializedBoard = [[NSMutableArray alloc] initWithCapacity:size*size];
    for (NSInteger i = 0; i < size; i++) {
        for (NSInteger j = 0; j < size; j++) {
            [serializedBoard addObject:[[rows objectAtIndex:i] objectAtIndex:j]];
        }
    }
    return serializedBoard;
}

- (void)showStatus {
    for (NSInteger i = 0; i < size ; i++) {
        NSMutableString *status = [[NSMutableString alloc]init];
        for (NSInteger j = 0; j < size; j++) {
            [status appendString:[[[self->rows objectAtIndex:i] objectAtIndex:j] stringValue]];
            [status appendString:@" "];
        }
         NSLog(@"%@",status);
        [status release];
    }
}
- (void)shuffleBoard {
    // 2차원 배열을 1차원 배열로 만들어서 셔플한 다음 NSNumber 포인터를 다시 이차원배열에 배치하는 방법이었는데
    // 이렇게 하면 절대 풀수 없는 배치가 발생할 수 있다.
    /*
    NSMutableArray* serializedBoard = [self getSerializedBoard];
    [serializedBoard shuffle];
    for (NSInteger i = 0; i < size; i++) {
        for (NSInteger j = 0; j < size; j++) {
            [[rows objectAtIndex:i] setObject:[serializedBoard objectAtIndex:i*size+j] atIndex:j];
        }
    }
    [serializedBoard release];
     */
    //그래서 랜덤하게 이동을 많이 시키는 방법으로 셔플을 구현하겠다.
    for (int i=0;i<100; i++) {
        int direction = arc4random_uniform(4);
        switch (direction) {
            case 0:
                [self swap:@"a"];
                break;
            case 1:
                [self swap:@"s"];
                break;
            case 2:
                [self swap:@"d"];
                break;
            case 3:
                [self swap:@"w"];
                break;
            default:
                break;
        }
    }
}
- (void)command:(NSString*)command {
    if([command isDirection]) {
        NSLog(@"이동명령입니다");
        [self move:command];
    } else if ([command isRedoOrUndo]) {
        [self pauseGame];
        if([command isEqualToString:@"r"]) {
            NSLog(@"리두 명령입니다.");
            [self redo];
        } else if([command isEqualToString:@"u"]) {
            NSLog(@"언두 명령입니다");
            [self undo];
        }
        [self resumeGame];
    }
}
- (void)move:(NSString*)direction {
    bool isMoved = [self swap:direction];
    if(isMoved && gameStatus == 1) {
        [self->history addObject:direction];
        self->historyHead++;
    }
}
- (bool)swap:(NSString*)direction {
    NSMutableArray* serializedBoard = [self getSerializedBoard];
    // 값이 0인 NSNumber* 를 찾는다
    int blank_idx=0;
    bool isSwaped = NO;
    for(NSNumber* piece in serializedBoard) {
        if([piece intValue]==0){
            break;
        }
        blank_idx++;
    }
    if([direction isEqualToString:@"a"]) {
        if(blank_idx%size != 0) {
            [serializedBoard swapElementAtIndex:blank_idx withAtIndex:blank_idx-1];
            isSwaped = YES;
        }
    } else if([direction isEqualToString:@"d"]) {
        if(blank_idx%size != (size-1)) {
            [serializedBoard swapElementAtIndex:blank_idx withAtIndex:blank_idx+1];
            isSwaped = YES;
        }
    } else if([direction isEqualToString:@"w"]) {
        if(blank_idx/size != 0) {
            [serializedBoard swapElementAtIndex:blank_idx withAtIndex:blank_idx-size];
            isSwaped = YES;
        }
    } else if([direction isEqualToString:@"s"]) {
        if(blank_idx/size != (size-1)) {
            [serializedBoard swapElementAtIndex:blank_idx withAtIndex:blank_idx+size];
            isSwaped = YES;
        }
    }
    
    for (NSInteger i = 0; i < size; i++) {
        for (NSInteger j = 0; j < size; j++) {
            [[rows objectAtIndex:i] setObject:[serializedBoard objectAtIndex:i*size+j] atIndex:j];
        }
    }
    
    [serializedBoard release];
    return isSwaped;
}
- (bool)isSolved
{
    NSMutableArray* serializedBoard = [self getSerializedBoard];
    bool isSolved = YES;
    for (int i = 0;i<[serializedBoard count];i++) {        
        if(([[serializedBoard objectAtIndex:i] intValue] != (i+1) && i < [serializedBoard count]-1)||([[serializedBoard objectAtIndex:i] intValue] != 0 && i ==[serializedBoard count]-1)){
            isSolved = NO;
            break;
        }
    }
    [serializedBoard release];
    return isSolved;
}

- (void)pauseGame {
    gameStatus = 0;
}
- (void)resumeGame {
    gameStatus = 1;
}
- (void)showHistory {
    NSLog(@"HISTORY \n%@",self->history);
}
- (int)getMoveCount {
    return (int)[self->history count];
}
- (void)undo {
    // history count가 1 이상이고 && head가 0 이상일 경우
    if([history count] >= 1 && historyHead >= 0) {
        // head가 가리키는 명령을 반대로 수행하고
        [self move:[self getOpositeDirection:[history objectAtIndex:historyHead]]];
        // head를 --함
        historyHead--;
    } else if (historyHead == -1){
        NSLog(@"Cannot Undo");
    }
}
- (void)redo {
    // history count가 1 이상이고 && head가 [history count]-1 미만일 경우
    if(([history count] >= 1) && (historyHead < ((int)[history count]-1)) ) {
        // head+1가 가리키는 명령을 반대로 수행하고
        [self move:[history objectAtIndex:historyHead+1]];
        // head를 ++함
        historyHead++;
    } else if (historyHead == ((int)[history count]-1)){
        NSLog(@"Cannot Redo");
    }
}

- (NSString*)getOpositeDirection:(NSString*)direction {
    if([direction isEqualToString:@"a"]) {
        return @"d";
    } else if([direction isEqualToString:@"d"]) {
        return @"a";
    } else if([direction isEqualToString:@"w"]) {
        return @"s";
    } else if([direction isEqualToString:@"s"]) {
        return @"w";
    }
    return nil;
}

- (void)release {
    [rows release];
    [history release];
    [super release];
}
@end
