//
//  Communities.m
//  CommunityClient
//
//  Created by KIM HEE JAE on 9/27/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import "Communities.h"


@implementation Communities
{
    NSMutableArray * communityCollection; // Community 객체의 인스턴스들로 이루어진다.
}

// 설정파일을 읽어서 커뮤니티 인스턴스를 제작. 파서들도 각 보드들에 주입
- (id) init
{
    if (!(self = [super init]))
        return nil;
    
    communityCollection = [[NSMutableArray alloc]init];
    
    // 1. 설정파일을 문자열로 읽는다.
    NSError *error;
    NSString *strFileContent = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]
                                                                   pathForResource: @"community" ofType: @"json"] encoding:NSUTF8StringEncoding error:&error];
    if(error) {  //Handle error
    }
    
    // 2. 설정파일을 JSON으로 파싱한다.
    NSData *data = [strFileContent dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    // 3. 커뮤니티를 만들어서 가진다.
    for (NSDictionary* communityConfig in json) {
        Community * community = [[Community alloc] initWithAttribute:communityConfig];
        [communityCollection addObject:community];

    }
   
    return self;
}

// 소유한 모든 게시판에 대해 첫 페이지에 대한 Article들을 모두 확보하라고 명령하기
- (void) prepareForEveryFirstPageArticles
{
    for(Community* community in communityCollection) {
        NSMutableArray * boardCollection = community->boardCollection;
        for(Board* board in boardCollection) {
            [board fetchArticlesAtPage:0];
        }
    }
}

- (Community*) communityAtIndex:(int) index {
    return communityCollection[index];
}

@end
