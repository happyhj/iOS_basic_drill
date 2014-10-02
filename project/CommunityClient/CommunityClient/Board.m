//
//  Board.m
//  CommunityClient
//
//  Created by KIM HEE JAE on 9/27/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import "Board.h"
#import "ListParsor.h"
#import "ArticleParsor.h"
#import "OutlinkParsor.h"

@implementation Board
{
    NSString * article_key;
    
    ListParsor * listParsor;
    ArticleParsor * articleParsor;
    OutlinkParsor * outlinkParsor;
}
- (id) initWithAttribute:(NSDictionary*)config {
    if (!(self = [super init]))
        return nil;
    
    articleCollection = [[NSMutableArray alloc] init];
    
    // 1. 기본정보를 설정한다.
    name_en = [config objectForKey:@"board_name_en"];
    name_ko = [config objectForKey:@"board_name_ko"];
    article_key = [config objectForKey:@"article_key"];
  
    // 2. 리스트파서와 게시글파서객체를 생성해서 가진다.
    NSDictionary * listConfig = [config objectForKey:@"list"];
    NSDictionary * articleConfig = [config objectForKey:@"article"];
    listParsor = [[ListParsor alloc] initWithAttribute:listConfig];
    articleParsor = [[ArticleParsor alloc] initWithAttribute:articleConfig];
    outlinkParsor = [[OutlinkParsor alloc] init];

    return self;
}

- (void) fetchArticlesAtPage:(int) page
{
    NSArray* lists = [listParsor fetchListItemsAtPage:page];
    
    NSMutableArray* articles = [[NSMutableArray alloc] init];
    for(NSDictionary* listItem in lists) {
        [articles addObject:[articleParsor getAtricleItemWith:listItem]];
    }
    // article_key 를 참고하여 새로운것과 동일한게 존재하는지 확인하고
    for(NSDictionary* fetchedArticle in articles) {
        NSString* fetched_article_id = [[fetchedArticle objectForKey:@"meta"] objectForKey:article_key];
        for(NSDictionary* atricle in articleCollection) {
            NSString* article_id = [[atricle objectForKey:@"meta"] objectForKey:article_key];
            // 동일한게 있으면 그 아이템을 UPDATE
            if([fetched_article_id isEqualToString:article_id]) {
                // 업데이트 하고
                //// 방법. atricle 을 articleCollection 에서 삭제
                [articleCollection delete:atricle];
            }
        }
    }
    // articles 에 남은 글들은 진짜 새로운 글이다. articleCollection 에 아무렇게나 추가
    for(NSDictionary* fetchedArticle in articles) {
        [articleCollection addObject:fetchedArticle];
    }
    
    // 전체를 article_key를 비교해서 소팅해서 articleCollection 에 다시 대입
    NSArray *sortedArticleCollection;
    sortedArticleCollection = [articleCollection sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSString *first = [[(NSDictionary*)a objectForKey:@"meta"] objectForKey:article_key];
        NSString *second = [[(NSDictionary*)b objectForKey:@"meta"] objectForKey:article_key];
        return [second compare:first];
    }];
    
    articleCollection = [sortedArticleCollection mutableCopy];
    
    // articleCollection 을 돌면서 outlink가 있으면 meta 정보도 구해와서 가져온다.
    [self fetchOutlinkMetaInfo];
    // article Fetched! 방송 뿌우우우우웅!!!

}

- (void) fetchOutlinkMetaInfo
{
    for (NSMutableDictionary* article in articleCollection) {
        NSMutableArray* article_outlinks = [article objectForKey:@"article_outlink"];
        if(article_outlinks != nil) {
            NSString* outlink_url = [article_outlinks objectAtIndex:0];
            NSDictionary * meta = [outlinkParsor getOutlinkMetaInfoWith:outlink_url];
            if(meta) {
               //NSLog(@"%@",meta);
                [article setObject:meta forKey:@"article_outlink_meta"];
            }
        }
        
    }
}

@end
