//
//  WLSnapshot.h
//  WordLadder
//
//  Created by KIM HEE JAE on 7/21/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLSnapshot : NSObject
{
    NSMutableArray* transformations;
    NSString* start;
    NSString* end;
    NSMutableSet* dict;
}
- (NSMutableArray *)transformations;

- (void)setTransformations:(NSMutableArray *)newValue;

- (NSString *)start;

- (void)setStart:(NSString *)newValue;

- (NSString *)end;

- (void)setEnd:(NSString *)newValue;

- (NSMutableSet *)dict;

- (void)setDict:(NSMutableSet *)newValue;


- (NSMutableArray*) oneStepForward;
@end
