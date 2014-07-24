//
//  PuzzleBoard.h
//  puzzle
//
//  Created by KIM HEE JAE on 7/24/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSMutableArray+Shuffle.h"

@interface PuzzleBoard : NSObject
{
    NSMutableArray* rows;
    NSInteger size;
    NSMutableArray* history;
    int historyHead;
    int gameStatus; // 0 초기화 중 || 게임 아닌 중  , 1 게임 중
}
- (id)initWithSize:(NSInteger)size;
- (NSMutableArray*) getSerializedBoard;
- (void)showStatus;
- (void)shuffleBoard;
- (void)command:(NSString*)direction;
- (void)move:(NSString*)direction;
- (bool)swap:(NSString*)direction;
- (bool)isSolved;
- (void)pauseGame;
- (void)resumeGame;
- (void)showHistory;
- (int)getMoveCount;
- (void)undo;
- (void)redo;
- (NSString*)getOpositeDirection:(NSString*)direction;
// 소멸자 안에 rows 릴리즈하는거 오버라이딩하기
- (void)release;
@end
