//
//  NSString+JSONParse.h
//  JSON_Serialization
//
//  Created by KIM HEE JAE on 7/20/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JSONParse)
- (NSString*) trimHeadFor:(int)head_trim_count andTailFor :(int)tail_trim_count;
- (NSUInteger) countMatchesWith:(NSString*)findStr;
- (NSString*) extractKeyString;
- (NSString*) extractValueString;
- (bool) has:(NSString*)pattern;
- (bool) isSurroundedBy:(NSString*)open_saparator and:(NSString*)close_saparator;
- (NSNumber*) getNumberObject;

- (NSString*) surroundWith:(NSString*)open andWith:(NSString*)close;
@end
