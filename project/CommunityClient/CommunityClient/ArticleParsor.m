//
//  ArticleParsor.m
//  CommunityClient
//
//  Created by KIM HEE JAE on 9/2/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//
#import "TFHpple.h"
#import "ArticleParsor.h"

// listItem(NSDictionary *)을 받아서 5종류의 AtricleItem subclass중 하나로 내놓는 클래스
@implementation ArticleParsor
{
    NSString * article_xpath;
    NSDictionary * article_content_xpaths;
    //PostProcess * postProcess;
}

- (id) initWithAttribute:(NSDictionary*) config
{
    if (!(self = [super init]))
        return nil;
    
    article_xpath = [config objectForKey:@"article"];
    article_content_xpaths = [config objectForKey:@"article_content"];
    
    return self;
}


- (NSDictionary*) getAtricleItemWith:(NSDictionary *) listItem
{
    // listItem에서 받은 정보를 통해 article HTML을 받아온다.
    NSURL *listUrl = [NSURL URLWithString:[listItem objectForKey:@"article_url"]];
    NSData *listHtmlData = [NSData dataWithContentsOfURL:listUrl];

    // 2
    TFHpple *listHtmlParser = [TFHpple hppleWithHTMLData:listHtmlData];
    
    // 3 article을 다 감싸는 부분을 가죠옴 , 당연히 1개일 것으로 예상
    NSArray *listNodes = [listHtmlParser searchWithXPathQuery:article_xpath];

    // 4 본문 만 가져옴
    TFHppleElement *contentElement = [listNodes objectAtIndex:0];

    NSArray * article_content_keys = [article_content_xpaths allKeys];
    // 받아온 HTML에서 여러정보를 NSDictionary 로 가지가지 파싱해 온다.
    NSMutableDictionary * articleDict = [[NSMutableDictionary alloc] init];
    for (NSString *key in article_content_keys) {
        NSString * contentXpath = [article_content_xpaths objectForKey:key];
        NSArray * contentNodes = [contentElement searchWithXPathQuery:contentXpath];

        NSMutableArray * contentList = [[NSMutableArray alloc]init];
        for (TFHppleElement * parsedNode in contentNodes) {
            if(nil == [parsedNode content]) { // 구하고자하는게 애트리뷰트의 값인 경우
                [contentList addObject:[[parsedNode children][0] content]];
            } else {  // 구하고자 하는게 텍스트 콘텐츠인 경우
                NSString * text = [parsedNode content];
                text = [text stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                text = [text stringByReplacingOccurrencesOfString:@"\r" withString:@""];
                if([text length] > 2 ) {
                    [contentList addObject:text];
                }
            }
        }
        
        if([contentList count] > 0) {
            [articleDict setObject:contentList forKey:key];
        }
        
           /*
        if([parsedNode count] == 0) {
            continue;
        }
        //NSLog(@"[[ %@ ]] ",content_key);
        if(nil == [parsedNode[0] content]) { // 구하고자하는게 애트리뷰트의 값인 경우
            [list_content setObject:[[parsedNode[0] children][0] content] forKey:content_key];
        } else {  // 구하고자 하는게 텍스트 콘텐츠인 경우
            [list_content setObject:[parsedNode[0] content] forKey:content_key];
        }
     */
    }
    // list item 정보와 합친다.
    [articleDict setObject:listItem forKey:@"meta"];

    return articleDict;
};
@end
