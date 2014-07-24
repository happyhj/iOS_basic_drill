//
//  NSString+Command.m
//  puzzle
//
//  Created by KIM HEE JAE on 7/24/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import "NSString+Command.h"

@implementation NSString (Command)
- (bool)isDirection {
    if([self isEqualToString:@"a"]||[self isEqualToString:@"s"]||[self isEqualToString:@"w"]||[self isEqualToString:@"d"]) {
        return YES;
    }
    return NO;}
- (bool)isRedoOrUndo {
    if([self isEqualToString:@"r"]||[self isEqualToString:@"u"]) {
        return YES;
    }
    return NO;
}
@end
