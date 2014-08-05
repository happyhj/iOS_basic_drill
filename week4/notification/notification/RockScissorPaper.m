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
        status = info;
        
        // Observer will be notified
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"rockScissorPaperNotification"
         object:self
         userInfo:info];
    }
}

- (void)loadStatus
{
    NSLog(@"나는 모델인데 로드할게요");
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    id info = nil;
    if (userDefaults) {
        info = [userDefaults objectForKey:@"status"];
    }

    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"rockScissorPaperNotification"
     object:self
     userInfo:info];
}

- (void)saveStatus
{
    NSLog(@"나는 모델인데 저장할게요");
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (userDefaults) {
        [userDefaults setObject:status forKey:@"status"];
    }
    [userDefaults synchronize];
}
@end
