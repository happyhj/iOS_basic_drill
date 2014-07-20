//
//  JSON_Serializer.m
//  JSON_Serialization
//
//  Created by KIM HEE JAE on 7/17/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import "JSONDeserializer.h"
#import "NSString+JSONParse.h"
#import "NSMutableArray+JSONParse.h"
#import "NSArray+JSONParse.h"

#define QUOTATION_MARK @"\""
#define ARRAY_OPEN @"["
#define ARRAY_CLOSE @"]"
#define DICT_OPEN @"{"
#define DICT_CLOSE @"}"

@implementation JSONDeserializer

+ (JSONDeserializer*) deserializer {
    JSONDeserializer* deserializer =[[self allocWithZone:NULL] init];
    return deserializer;
}

- (id) deserialize:(NSString*)jsonString {
    id shallowParsed = [self getShallowParsedObject:jsonString];
    NSArray *keys = [shallowParsed allKeys];

    for(id key in keys){
        NSString* value = [shallowParsed objectForKey:key];
        id valueObject;
        
        if([value isSurroundedBy:QUOTATION_MARK and:QUOTATION_MARK])
            valueObject = [value trimHeadFor:1 andTailFor:1];
        else if(![value isSurroundedBy:ARRAY_OPEN and:ARRAY_CLOSE]&&![value isSurroundedBy:DICT_OPEN and:DICT_CLOSE]) {
            valueObject = [value getNumberObject];
        }
        else valueObject = [self deserialize:value];
        
        [shallowParsed setObject:valueObject forKey:key];
    }
    
    return shallowParsed;
}

- (id) getShallowParsedObject:(NSString*)jsonData {
    NSMutableArray *shallowParsedArray = [[jsonData componentsSeparatedByString:@","] mutableCopy];
    int array_depth = 0;
    int dict_depth = 0;
    if([jsonData isSurroundedBy:DICT_OPEN and:DICT_CLOSE]) {
        dict_depth = -1;
    } else if([jsonData isSurroundedBy:ARRAY_OPEN and:ARRAY_CLOSE]) {
        array_depth = -1;
    }

    for (int i = 0;i+1 <[shallowParsedArray count]; ) {
        NSUInteger array_open_count = [[shallowParsedArray objectAtIndex:i] countMatchesWith:ARRAY_OPEN];
        NSUInteger array_close_count = [[shallowParsedArray objectAtIndex:i] countMatchesWith:ARRAY_CLOSE];
        int temp_array_depth = array_depth + (int)array_open_count - (int)array_close_count;
        
        NSUInteger dict_open_count = [[shallowParsedArray objectAtIndex:i] countMatchesWith:DICT_OPEN];
        NSUInteger dict_close_count = [[shallowParsedArray objectAtIndex:i] countMatchesWith:DICT_CLOSE];
        int temp_dict_depth = dict_depth + ((int)dict_open_count - (int)dict_close_count);

        if(temp_array_depth != 0 || temp_dict_depth != 0) {// depth가 0이 아니라면, 바로 뒤의 문자열 원소를 현재 문자열에 합친다
            [shallowParsedArray mergeElementAtIndex:i+1 intoElementAtIndex:i];
        }
        else {
            dict_depth = temp_dict_depth;
            array_depth = temp_array_depth;
            i++;
        }
        
    }
    
    [shallowParsedArray trimBrace];
    [shallowParsedArray trimStringElements];

    if ([jsonData isSurroundedBy:DICT_OPEN and:DICT_CLOSE]) {
        return [shallowParsedArray getDictionary];
    }
    
    return shallowParsedArray;
}
@end
