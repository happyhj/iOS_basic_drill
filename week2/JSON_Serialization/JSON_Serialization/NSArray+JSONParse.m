//
//  NSArray+JSONParse.m
//  JSON_Serialization
//
//  Created by KIM HEE JAE on 7/20/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import "NSArray+JSONParse.h"
#import "NSString+JSONParse.h"

#define QUOTATION_MARK @"\""
#define ARRAY_OPEN @"["
#define ARRAY_CLOSE @"]"
#define DICT_OPEN @"{"
#define DICT_CLOSE @"}"

@implementation NSArray (JSONParse)
- (NSArray*) allKeys {
    NSUInteger size = [self count];
    NSMutableArray* keys = [[NSMutableArray alloc] init];
    for (int i=0; i<size; i++) {
        NSNumber* iWrapped = [NSNumber numberWithInt:i];
        [keys addObject:iWrapped];
    }
    return keys;
}
- (id) objectForKey:(NSNumber*)key {
    return [self objectAtIndex:[key integerValue]];
}
- (NSMutableDictionary*) getDictionary {
    NSMutableDictionary *my_dict = [[NSMutableDictionary alloc] init];
    for(NSString *element in self){
        [my_dict setObject:[element extractValueString] forKey:[element extractKeyString]];
    }
    return my_dict;
}

- (bool) hasEveryValueString {
    NSUInteger size = [self count];
    bool notNSStringFound = NO;
    for (int i=0; i<size; i++) {
        if(![[self objectAtIndex:i] isKindOfClass:[NSString class]]) notNSStringFound = YES;
    }
    return !notNSStringFound;
}
- (NSString*) getEveryElementsInString {
    NSUInteger size = [self count];
    NSMutableString* result = [[NSMutableString alloc] init];
    for (int i=0; i<size; i++) {
        [result appendString:[self objectAtIndex:i]];
        if(i<size-1){
            [result appendString:@","];
        }
    }
    return result;
}
@end
