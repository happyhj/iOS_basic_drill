//
//  RockScissorPaper.m
//  notification
//
//  Created by KIM HEE JAE on 7/31/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import "RockScissorPaper.h"

@implementation RockScissorPaper
- (void)randomize
{
    int handInt = (arc4random() % 3);
    NSString* handString;
    switch (handInt) {
        case 0:
            handString = @("rock");
            break;
        case 1:
            handString = @("paper");
            break;
        case 2:
            handString = @("scissors");
            break;
        default:
            break;
    }

    if (handString != NULL) {
        NSDictionary *info = [NSDictionary dictionaryWithObject:handString forKey:@"handString"];
        
        // Observer will be notified
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"rockScissorPaperNotification"
         object:self
         userInfo:info];
    }
}
@end
