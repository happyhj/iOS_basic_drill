//
//  RockScissorPaper.h
//  notification
//
//  Created by KIM HEE JAE on 7/31/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RockScissorPaper : NSObject
{
    NSDictionary *status;
}
- (void)randomize;
- (void)loadStatus;
- (void)saveStatus;
@end
