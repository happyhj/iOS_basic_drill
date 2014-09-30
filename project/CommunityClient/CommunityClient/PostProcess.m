//
//  ClienPostProcess.m
//  CommunityClient
//
//  Created by KIM HEE JAE on 9/2/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import "PostProcess.h"

@implementation PostProcess
// 포스트 프로세스가 필요없도록 상대  url 을 절대 URL로 바꾸는 유틸리티를 만드는게 나을것 같다.

+ (NSMutableDictionary*) postProcessWith:(NSMutableDictionary*) source and:(NSString*)listsUrl
{
    NSString* article_url_ = [source objectForKey:@"article_url"];
    NSString* comment_count_ = [source objectForKey:@"comment_count"];
    NSString* view_count_ = [source objectForKey:@"view_count"];
    NSString* article_id_ = [source objectForKey:@"article_id"];
    NSString* author_image_ = [source objectForKey:@"author_image"];
    if(article_url_ != NULL){
        if([article_url_ rangeOfString:@"../"].location == 0 || [article_url_ rangeOfString:@"./"].location == 0) {
            NSString * completedURL = [NSString stringWithFormat:@"%@%@",[self getCurrentPathFrom:listsUrl],article_url_];
            [source setObject:completedURL forKey:@"article_url"];
        }
        if([article_url_ rangeOfString:@"/"].location == 0 ) {
            NSString * completedURL = [NSString stringWithFormat:@"%@%@",[self getDomainFrom:listsUrl],article_url_];
            [source setObject:completedURL forKey:@"article_url"];
        }
    }
    if(author_image_ != NULL) {
        if([author_image_ rangeOfString:@"../"].location == 0 || [author_image_ rangeOfString:@"./"].location == 0) {
            NSString * completedURL = [NSString stringWithFormat:@"%@%@",[self getCurrentPathFrom:listsUrl],author_image_];
            [source setObject:completedURL forKey:@"author_image"];
        }
        if([author_image_ rangeOfString:@"/"].location == 0 ) {
            NSString * completedURL = [NSString stringWithFormat:@"%@%@",[self getDomainFrom:listsUrl],author_image_];
            [source setObject:completedURL forKey:@"author_image"];
        }
    }
    if(article_id_ != NULL) {
        article_id_ = [article_id_ stringByReplacingOccurrencesOfString:@"[^0-9]" withString:@""
                                                                      options:NSRegularExpressionSearch range:NSMakeRange(0, [article_id_ length])];
        [source setObject:article_id_ forKey:@"article_id"];
    }
    if(comment_count_ != NULL) {
        comment_count_ = [comment_count_ stringByReplacingOccurrencesOfString:@"[^0-9]" withString:@""
                                                      options:NSRegularExpressionSearch range:NSMakeRange(0, [comment_count_ length])];
        [source setObject:comment_count_ forKey:@"comment_count"];
    }
    if(view_count_ != NULL) {
        view_count_ = [view_count_ stringByReplacingOccurrencesOfString:@"[^0-9]" withString:@""
                                                                      options:NSRegularExpressionSearch range:NSMakeRange(0, [view_count_ length])];
        [source setObject:view_count_ forKey:@"view_count"];
    }
    return source;
}

+ (NSString*) getCurrentPathFrom:(NSString*)url {
    NSString * httpPrefix = @"http://";
    NSString * httpsPrefix = @"https://";
    
    NSString * protocol;
    
    if([url rangeOfString:httpPrefix].location == 0 ) {
        protocol = httpPrefix;
        url = [url substringFromIndex:[httpPrefix length]];
    } else if([url rangeOfString:httpsPrefix].location == 0 ) {
        protocol = httpsPrefix;
        url = [url substringFromIndex:[httpsPrefix length]];
    }
    
    NSArray* list = [url componentsSeparatedByString:@"/"];
    NSMutableArray* m_list = [list mutableCopy];
    [m_list removeLastObject];
    NSString * currentPath = [m_list componentsJoinedByString:@"/"];
    NSMutableString * m_currentPath = [currentPath mutableCopy];
    [m_currentPath appendString:@"/"];
    
    return [NSString stringWithFormat:@"%@%@",protocol,m_currentPath];
}
+ (NSString*) getDomainFrom:(NSString*)url {
    NSString * httpPrefix = @"http://";
    NSString * httpsPrefix = @"https://";
    
    NSString * protocol;
    
    if([url rangeOfString:httpPrefix].location == 0 ) {
        protocol = httpPrefix;
        url = [url substringFromIndex:[httpPrefix length]];
    } else if([url rangeOfString:httpsPrefix].location == 0 ) {
        protocol = httpsPrefix;
        url = [url substringFromIndex:[httpsPrefix length]];
    }
    NSArray* list = [url componentsSeparatedByString:@"/"];
    NSString * domain = [list objectAtIndex:0];

    return [NSString stringWithFormat:@"%@%@",protocol,domain];
}
@end
