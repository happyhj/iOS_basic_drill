//
//  NSString+JSONParse.m
//  JSON_Serialization
//
//  Created by KIM HEE JAE on 7/20/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import "NSString+JSONParse.h"

@implementation NSString (JSONParse)
- (NSString*) trimHeadFor:(int)head_trim_count andTailFor :(int)tail_trim_count{
    NSMutableString *string = [self mutableCopy];
    string = [[string substringFromIndex:head_trim_count] mutableCopy];
    string = [[string substringToIndex:[string length]-tail_trim_count] mutableCopy];
    NSString *string_value = string;
    return string_value;
}
- (NSUInteger) countMatchesWith:(NSString*)findStr {
    NSUInteger count = 0, length = [self length];
    NSRange range = NSMakeRange(0, length);
    while(range.location != NSNotFound)
    {
        range = [self rangeOfString: findStr options:0 range:range];
        if(range.location != NSNotFound)
        {
            range = NSMakeRange(range.location + range.length, length - (range.location + range.length));
            count++;
        }
    }
    return count;
}

- (NSString*) extractKeyString {
    NSRange colonIdx = [self rangeOfString:@":"];
    NSMutableString *key = [[self substringToIndex:colonIdx.location] mutableCopy];
    key = [[key stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] mutableCopy];
    return [key trimHeadFor:1 andTailFor :1];
}

- (NSString*) extractValueString {
    NSRange colonIdx = [self rangeOfString:@":"];
    NSMutableString *value = [[self substringFromIndex:colonIdx.location+1] mutableCopy];
    value = [[value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] mutableCopy];
    return value;
}

- (bool) has:(NSString*)pattern {
    if([self rangeOfString:pattern].location == NSNotFound) return NO;
    else return YES;
}

- (bool) isSurroundedBy:(NSString*)open_saparator and:(NSString*)close_saparator{
    NSString *lastChar = [self substringFromIndex:[self length]-1];
    if([self rangeOfString:open_saparator].location == 0 && [lastChar isEqualToString:close_saparator])
        return YES;
    else return NO;
}

- (NSNumber*) getNumberObject {
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterNoStyle];
    NSNumber* result = [f numberFromString:self];
    return result;
}

// for Serializer
- (NSString*) surroundWith:(NSString*)open andWith:(NSString*)close {
    NSMutableString* result = [open mutableCopy];
    [result appendString:self];
    [result appendString:close];
    return result;
}
@end
