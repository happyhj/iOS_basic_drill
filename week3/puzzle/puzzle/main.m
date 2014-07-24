//
//  main.m
//  puzzle
//
//  Created by KIM HEE JAE on 7/24/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PuzzleBoard.h"
#import "NSString+Input.h"


int main(int argc, const char * argv[])
{

    @autoreleasepool {
        PuzzleBoard* puzzleBoard = [[PuzzleBoard alloc] initWithSize:3];
        [puzzleBoard shuffleBoard];
        [puzzleBoard resumeGame];
        [puzzleBoard showStatus];
        
        while (YES) {
            NSString * input = [NSString stringFromStandardInDelimitedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
            [puzzleBoard command:input];
            [puzzleBoard showHistory];
            NSLog(@"%d 번 MOVE 함",[puzzleBoard getMoveCount]);
            if ([puzzleBoard isSolved]) {
                NSLog(@"You win!");
            }
            
            [puzzleBoard showStatus];
        }
        [puzzleBoard release];

    }
    return 0;
}

