//
//  NSDictionary+JSONParse.m
//  JSON_Serialization
//
//  Created by KIM HEE JAE on 7/20/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import "NSDictionary+JSONParse.h"
#import "NSString+JSONParse.h"

@implementation NSDictionary (JSONParse)

- (NSString*) getEveryElementsInString {
    NSUInteger size = [[self allKeys] count];
    NSUInteger itr_c = 0;
    NSMutableString* result = [[NSMutableString alloc] init];
    for (NSString* key in [self allKeys]) {
        [result appendString:[key surroundWith:@"\"" andWith:@"\""]];
        [result appendString:@":"];
        [result appendString:[self objectForKey:key]];
        itr_c++;
        if(itr_c < size)
            [result appendString:@","];
    }
    return result;
}
- (bool) hasEveryValueString {
    bool notNSStringFound = NO;
    for (NSString* key in [self allKeys]) {
        if(![[self objectForKey:key] isKindOfClass:[NSString class]]) notNSStringFound = YES;
    }
    return !notNSStringFound;
}

@end
