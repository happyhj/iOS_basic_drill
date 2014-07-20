//
//  JSONSerializer.m
//  JSON_Serialization
//
//  Created by KIM HEE JAE on 7/20/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import "JSONSerializer.h"
#import "NSArray+JSONParse.h"
#import "NSString+JSONParse.h"

#define QUOTATION_MARK @"\""
#define ARRAY_OPEN @"["
#define ARRAY_CLOSE @"]"
#define DICT_OPEN @"{"
#define DICT_CLOSE @"}"

@implementation JSONSerializer
+ (JSONSerializer*) serializer {
    JSONSerializer* serializer =[[self allocWithZone:NULL] init];
    return serializer;
}
- (NSString*) serializeObject:(id)object {
    id result = [self makeLeafNodeStringPresentation:object];
    
    while(![result hasEveryValueString]) {
        result = [self makeLeafObjectStringPresentation:result];
    }
    result = [result getEveryElementsInString];
    
    if([object isKindOfClass:[NSDictionary class]])
       result = [result surroundWith:DICT_OPEN andWith:DICT_CLOSE];
    else if([object isKindOfClass:[NSArray class]])
        result = [result surroundWith:ARRAY_OPEN andWith:ARRAY_CLOSE];
    return result;
}

- (NSString*) makeLeafNodeStringPresentation:(id)object {
    NSArray *keys = [object allKeys];
   
    for(id key in keys){
        id valueObject = [object objectForKey:key];
        
        if([valueObject isKindOfClass:[NSString class]]) {
            if(![valueObject isSurroundedBy:ARRAY_OPEN and:ARRAY_CLOSE] && ![valueObject isSurroundedBy:DICT_OPEN and:DICT_CLOSE] && ![valueObject isSurroundedBy:QUOTATION_MARK and:QUOTATION_MARK]){
                valueObject = [valueObject surroundWith:QUOTATION_MARK andWith:QUOTATION_MARK];
            }
        }
        else if([valueObject isKindOfClass:[NSNumber class]]) {
            if([valueObject doubleValue] == [valueObject intValue])
                valueObject = [NSString stringWithFormat:@"%d", [valueObject intValue]];
            else
                valueObject = [NSString stringWithFormat:@"%f", [valueObject doubleValue]];
        }
        else if([valueObject isKindOfClass:[NSArray class]] || [valueObject isKindOfClass:[NSDictionary class]]) {
            valueObject = [self makeLeafNodeStringPresentation:valueObject];
        }
        [object setObject:valueObject forKey:key];
    }

    return object;
}

- (NSString*) makeLeafObjectStringPresentation:(id)object {
    NSArray *keys = [object allKeys];
   
    for(id key in keys){
        id valueObject = [object objectForKey:key];
        
        if([valueObject isKindOfClass:[NSArray class]] && [valueObject hasEveryValueString]) {
            valueObject = [[valueObject getEveryElementsInString] surroundWith:ARRAY_OPEN andWith:ARRAY_CLOSE];
        }
        else if([valueObject isKindOfClass:[NSDictionary class]] && [valueObject hasEveryValueString]) {
            valueObject = [[valueObject getEveryElementsInString] surroundWith:DICT_OPEN andWith:DICT_CLOSE];
        } else if([valueObject isKindOfClass:[NSArray class]] || [valueObject isKindOfClass:[NSDictionary class]]) {
            valueObject = [self makeLeafObjectStringPresentation:valueObject];
        }
        
        [object setObject:valueObject forKey:key];
    }
    return object;
}
@end



