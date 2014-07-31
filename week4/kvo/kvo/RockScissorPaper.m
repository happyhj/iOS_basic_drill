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
    switch (handInt) {
        case 0:
            self.handString = @("rock");
            break;
        case 1:
            self.handString = @("paper");
            break;
        case 2:
            self.handString = @("scissors");
            break;
        default:
            break;
    }
}
@end
