//
//  NSMutableArray+JSONParser.h
//  JSON_Serialization
//
//  Created by KIM HEE JAE on 7/20/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (JSONParse)
- (void) setObject:(id)object forKey:(NSNumber*)key;
- (void) mergeElementAtIndex:(NSInteger)sourceIndex intoElementAtIndex:(NSInteger)targetIndex;
- (void) trimBrace;
- (void) trimStringElements;
@end
