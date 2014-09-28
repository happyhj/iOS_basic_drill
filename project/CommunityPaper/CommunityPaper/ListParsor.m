//
//  ListParsor.m
//  HTMLParsing
//
//  Created by KIM HEE JAE on 9/2/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//
#import "TFHpple.h"
#import "Tutorial.h"
#import "ListParsor.h"
#import "ListItem.h"

@implementation ListParsor
{
    NSString * board_name_ko;
    NSString * board_name_en;
    NSString * lists_url;
    
    NSString * list_xpath;
    NSDictionary * list_content_xpaths;
    
    NSMutableArray * listItems;
}
- (id) initWithBoardAttribute:(NSDictionary*) boardDict
{
    if (!(self = [super init]))
        return nil;
    
    board_name_ko = [boardDict objectForKey:@"board_name_ko"];
    board_name_en = [boardDict objectForKey:@"board_name_en"];
    lists_url = [[boardDict objectForKey:@"list"] objectForKey:@"lists_url"];
    list_xpath = [[boardDict objectForKey:@"list"]objectForKey:@"list"];
    list_content_xpaths = [[boardDict objectForKey:@"list"]objectForKey:@"list_content"];

    listItems = [[NSMutableArray alloc] init];
    [self getListItemsAtPage:1];
    return self;
}

- (NSArray*) getListItemsAtPage:(int)page
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
        NSLog(@"%@",element);
        NSMutableDictionary * list_content = [[NSMutableDictionary alloc]init];
        for(NSString* content_key in content_keys){
            
            NSString * xPathStr = [list_content_xpaths objectForKey:content_key];
            NSArray * parsedNode = [element searchWithXPathQuery:xPathStr];
            
            if([parsedNode count] == 0) {
                continue;
            }
            NSLog(@"[[ %@ ]] ",content_key);
            if(nil == [parsedNode[0] content]) { // 구하고자하는게 애트리뷰트의 값인 경우
                [list_content setObject:[[parsedNode[0] children][0] content] forKey:content_key];
            } else {  // 구하고자 하는게 텍스트 콘텐츠인 경우
                [list_content setObject:[parsedNode[0] content] forKey:content_key];
            }
        }
        [newListItems addObject:list_content];
    }
    
    [listItems addObjectsFromArray: newListItems];
    return nil;
}
@end
