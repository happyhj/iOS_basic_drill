//
//  Community.h
//  CommunityClient
//
//  Created by KIM HEE JAE on 9/27/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Board.h"

@interface Community : NSObject
{
    @public
    NSString * name_en;
    NSString * name_ko;
    NSString * domain;
    NSMutableArray * boardCollection; // Community 객체의 인스턴스들로 이루어진다.
}
- (id) initWithAttribute:(NSDictionary*)config;
- (Board *) boardAtIndex:(int) index;

@end
