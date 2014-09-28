//
//  ListItem.m
//  HTMLParsing
//
//  Created by KIM HEE JAE on 9/2/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import "ListItem.h"

@implementation ListItem
{
    NSString * article_id;
    NSString * article_title;
    NSString * article_url;
    NSString * author_name;
    NSString * view_count;

}
- (id) initWithListItemAttribute:(NSDictionary*) listItem
{
    if (!(self = [super init]))
        return nil;
    
    article_id = [listItem objectForKey:@"article_id"];
    article_title = [listItem objectForKey:@"article_title"];
    article_url = [listItem objectForKey:@"article_url"];
    author_name = [listItem objectForKey:@"author_name"];
    view_count = [listItem objectForKey:@"view_count"];
    
    return self;
}
@end
