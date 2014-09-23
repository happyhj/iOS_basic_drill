//
//  ClienPostProcess.m
//  CommunityClient
//
//  Created by KIM HEE JAE on 9/2/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import "PostProcess.h"

@implementation PostProcess
{
    NSString * domain;
}

- (id) initWith:(NSDictionary*) boardInfo
{
    if (!(self = [super init]))
        return nil;
    
    domain = [[[boardInfo objectForKey:@"list"] objectForKey:@"lists_url"] substringToIndex:16];
    //NSLog(@"%@",domain);
    return self;
}

- (NSMutableDictionary*) postProcessWith:(NSMutableDictionary*) source
{
    NSString* article_url_ = [source objectForKey:@"article_url"];
    NSString* comment_count_ = [source objectForKey:@"comment_count"];
//    NSString* view_count_ = [source objectForKey:@"view_count"];
//    NSString* article_id_ = [source objectForKey:@"article_id"];
    NSString* author_image_ = [source objectForKey:@"author_image"];
    if(article_url_ != NULL){
        article_url_ = [article_url_ substringFromIndex:2];
        [source setObject:[NSString stringWithFormat:@"%@/cs2%@",domain,article_url_] forKey:@"article_url"];
    }
    if(author_image_ != NULL)
        [source setObject:[NSString stringWithFormat:@"%@%@",domain,author_image_] forKey:@"author_image"];
    if(comment_count_ != NULL) {
        comment_count_ = [[comment_count_ substringFromIndex:1] substringToIndex:[comment_count_ length]-2];
        [source setObject:comment_count_ forKey:@"comment_count"];
    }
    /*
    NSNumberFormatter * f1 = [[NSNumberFormatter alloc] init];
    [f1 setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber * article_id = [f1 numberFromString:article_id_];
    [source setObject:article_id forKey:@"article_id"];
*/
    
    //    [source setObject:<#(id)#> forKey:@"article_url"]
    return source;
}
@end
