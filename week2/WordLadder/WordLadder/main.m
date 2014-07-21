//
//  main.m
//  WordLadder
//
//  Created by KIM HEE JAE on 7/20/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WordLadder.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
 
        NSSet* dict = [[NSSet alloc] initWithObjects:@"hot",@"dot",@"dog",@"lot",@"log", nil];
        NSString* start = @"hit";
        NSString* end = @"cog";

        int ladderLength = [[[WordLadder alloc] init] getLadderLengthStartsWith:start endsWith:end within:dict];
        
        NSLog(@"%d", ladderLength);

    }
    return 0;
}

