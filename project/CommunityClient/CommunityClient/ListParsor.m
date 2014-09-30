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

@implementation ListParsor
{
    NSString * lists_url;
    NSString * list_xpath;
    NSDictionary * list_content_xpaths;
}

- (id) initWithAttribute:(NSDictionary*) config
{
    if (!(self = [super init]))
        return nil;
    
    lists_url = [config objectForKey:@"lists_url"];
    list_xpath = [config objectForKey:@"list"];
    list_content_xpaths = [config objectForKey:@"list_content"];

    return self;
}

- (NSArray*) fetchListItemsAtPage:(int)page
{
    // 첫 페이지들의 리스트들을 확보하면서 시작한다.
    NSURL *listUrl = [NSURL URLWithString:[lists_url stringByReplacingOccurrencesOfString:@"<%=page%>" withString:[NSString stringWithFormat:@"%d",page]]];
    NSData *listHtmlData = [NSData dataWithContentsOfURL:listUrl];
    
    // 2
    TFHpple *listHtmlParser = [TFHpple hppleWithHTMLData:listHtmlData];
    // 3
    NSArray *listNodes = [listHtmlParser searchWithXPathQuery:list_xpath];
    
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
        list_content = [PostProcess postProcessWith:list_content and:lists_url];
        
        if([[list_content allKeys] count] < 4) {
            continue;
        }
        [newListItems addObject:list_content];
    }

    return newListItems;
}

@end
