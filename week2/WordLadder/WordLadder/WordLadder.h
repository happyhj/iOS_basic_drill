//
//  WordLadder.h
//  WordLadder
//
//  Created by KIM HEE JAE on 7/20/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WordLadder : NSObject
{
    NSMutableArray* WLSnapshots;
    int step;
}
- (int) getLadderLengthStartsWith:(NSString*)start endsWith:(NSString*)end within:(NSSet*)dict;
@end
