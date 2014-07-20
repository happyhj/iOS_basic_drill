//
//  NSMutableArray+JSONParser.m
//  JSON_Serialization
//
//  Created by KIM HEE JAE on 7/20/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import "NSMutableArray+JSONParse.h"

@implementation NSMutableArray (JSONParse)
- (void) setObject:(id)object forKey:(NSNumber*)key {
    [self replaceObjectAtIndex:[key integerValue] withObject:object];
}
// NSARRAY merge 기능의 메소드 작성
- (void) mergeElementAtIndex:(NSInteger)sourceIndex intoElementAtIndex:(NSInteger)targetIndex {
    NSString *source = [self objectAtIndex:sourceIndex];
    NSString *target = [self objectAtIndex:targetIndex];
    NSString *result = [NSString stringWithFormat: @"%@,%@", target, source];
    [self insertObject:result atIndex:targetIndex];
    [self removeObjectAtIndex:sourceIndex];
    [self removeObjectAtIndex:sourceIndex];
}
- (void) trimBrace {
    [self replaceObjectAtIndex:0 withObject:[[self objectAtIndex:0] substringFromIndex:1]];
    [self replaceObjectAtIndex:[self count]-1 withObject:[[self objectAtIndex:[self count]-1] substringToIndex:[[self objectAtIndex:[self count]-1] length]-1]];
}
- (void) trimStringElements {
    for(int i=0; i<[self count] ; i++){
        NSString* element = [self objectAtIndex:i];
        [self replaceObjectAtIndex:i withObject:[element stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    }
}
@end
