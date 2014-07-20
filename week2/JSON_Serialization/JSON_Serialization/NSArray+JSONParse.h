//
//  NSArray+JSONParse.h
//  JSON_Serialization
//
//  Created by KIM HEE JAE on 7/20/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (JSONParse)
- (NSArray*) allKeys;
- (id) objectForKey:(NSNumber*)key;
- (NSMutableDictionary*) getDictionary;

- (bool) hasEveryValueString;
- (NSString*) getEveryElementsInString;
@end
