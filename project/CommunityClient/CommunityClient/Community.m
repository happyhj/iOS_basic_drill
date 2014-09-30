//
//  Community.m
//  CommunityClient
//
//  Created by KIM HEE JAE on 9/27/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import "Community.h"

@implementation Community
{
    NSMutableArray * boardCollection; // Community 객체의 인스턴스들로 이루어진다.
}
- (id) initWithAttribute:(NSDictionary*)config
{
    if (!(self = [super init]))
        return nil;

    boardCollection = [[NSMutableArray alloc]init];
    
    // 1. 기본정보를 설정한다.
    name_en = [config objectForKey:@"community_name_en"];
    name_ko = [config objectForKey:@"community_name_ko"];
    domain = [config objectForKey:@"domain"];
  
    // 2. 게시판들을 만들어서 가진다.
    NSArray * boards = [config objectForKey:@"boards"];
    for (NSDictionary* boardConfig in boards){
        Board * board = [[Board alloc] initWithAttribute:boardConfig];
        [boardCollection addObject:board];
    }
    return self;
}
- (Board *) boardAtIndex:(int) index
{
    return boardCollection[index];
}
@end
