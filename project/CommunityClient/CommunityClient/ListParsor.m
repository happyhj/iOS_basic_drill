//
//  ListParsor.m
//  HTMLParsing
//
//  Created by KIM HEE JAE on 9/2/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//
#import "TFHpple.h"
#import "ListParsor.h"
#import "PostProcess.h"
#import "ArticleParsor.h"

@implementation ListParsor
{
    NSString * board_name_ko;
    NSString * board_name_en;

    NSString * lists_url;
    NSString * list_item_key;

    NSString * list_xpath;
    NSDictionary * list_content_xpaths;
    
    PostProcess * postProcess;

    NSMutableArray * listItems; // 아티클의 metadata
    NSMutableArray * articleItems; // 파스된 아티클이 들어감 -> 최종 결과물

    ArticleParsor * articleParsor;
}

- (id) initWithBoardAttribute:(NSDictionary*) boardDict
{
    if (!(self = [super init]))
        return nil;
    
    postProcess = [[PostProcess alloc] initWith:boardDict];
    articleParsor = [[ArticleParsor alloc] initWith:boardDict];
    
    board_name_ko = [boardDict objectForKey:@"board_name_ko"];
    board_name_en = [boardDict objectForKey:@"board_name_en"];
    list_item_key = [boardDict objectForKey:@"article_key"];
    
    lists_url = [[boardDict objectForKey:@"list"] objectForKey:@"lists_url"];
    list_xpath = [[boardDict objectForKey:@"list"]objectForKey:@"list"];
    list_content_xpaths = [[boardDict objectForKey:@"list"]objectForKey:@"list_content"];

    listItems = [[NSMutableArray alloc] init];
    [self prepareListItemsAtPage:1];
    return self;
}

- (NSArray*) prepareListItemsAtPage:(int)page
{
    // 첫 페이지들의 리스트들을 확보하면서 시작한다.
    NSURL *listUrl = [NSURL URLWithString:[lists_url stringByReplacingOccurrencesOfString:@"<%=page%>" withString:[NSString stringWithFormat:@"%d",page]]];
    NSData *listHtmlData = [NSData dataWithContentsOfURL:listUrl];
    
    // 2
    TFHpple *listHtmlParser = [TFHpple hppleWithHTMLData:listHtmlData];
    // 3
    NSArray *listNodes = [listHtmlParser searchWithXPathQuery:list_xpath];
    // NSArray *listNodes = [listHtmlParser searchWithXPathQuery:@"//tr[@class='mytr']/td[@class='post_subject']/a"];
    
    // 4
    NSMutableArray *newListItems = [[NSMutableArray alloc] init];
    for (TFHppleElement *element in listNodes) {
        NSArray *content_keys = [list_content_xpaths allKeys];
        //NSLog(@"%@",element);
        NSMutableDictionary * list_content = [[NSMutableDictionary alloc]init];
        for(NSString* content_key in content_keys){
            NSString * xPathStr = [list_content_xpaths objectForKey:content_key];
            NSArray * parsedNode = [element searchWithXPathQuery:xPathStr];
            if([parsedNode count] == 0) {
                continue;
            }
            //NSLog(@"[[ %@ ]] ",content_key);
            if(nil == [parsedNode[0] content]) { // 구하고자하는게 애트리뷰트의 값인 경우
                [list_content setObject:[[parsedNode[0] children][0] content] forKey:content_key];
            } else {  // 구하고자 하는게 텍스트 콘텐츠인 경우
                [list_content setObject:[parsedNode[0] content] forKey:content_key];
            }
        }
        // 넘기기전에 post process를 하자
        list_content = [postProcess postProcessWith:list_content];
        if([[list_content allKeys] count] < 4) {
            continue;
        }
        [newListItems addObject:list_content];
    }
    
    [listItems addObjectsFromArray: newListItems];

    
    for(int i=0,len = [listItems count];i<len;i++) {
        [[self articleItems] addObject:[articleParsor getAtricleItemWith:[listItems objectAtIndex:i]]];
    }
    return [self articleItems];
}
- (NSMutableArray *)articleItems {
    return articleItems;
}

- (void)setArticleItems:(NSMutableArray *)newValue {
    articleItems = newValue;
}

@end
