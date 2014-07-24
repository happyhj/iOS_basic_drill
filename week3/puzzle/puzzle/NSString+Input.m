//
//  NSString+Input.m
//  puzzle
//
//  Created by KIM HEE JAE on 7/24/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import "NSString+Input.h"

@implementation NSString (Input)
+ (NSString *) stringFromStandardInDelimitedByCharactersInSet:(NSCharacterSet *)delimiters {
    NSMutableString * string = [NSMutableString string];
    unichar input = '\0';
    while ((input = getchar())) {
        if ([delimiters characterIsMember:input]) { break; }
        [string appendFormat:@"%C", input];
    }
    return string;
}
@end
