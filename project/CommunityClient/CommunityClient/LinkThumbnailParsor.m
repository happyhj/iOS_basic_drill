//
//  LinkThumbnailParsor.m
//  CommunityClient
//
//  Created by KIM HEE JAE on 9/3/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import "LinkThumbnailParsor.h"

@implementation LinkThumbnailParsor
+ (NSDictionary *) getLinkThunmnailDict:(NSString*)linkUrl
{
    NSURL *listUrl = [NSURL URLWithString:linkUrl];
    NSData *listHtmlData = [NSData dataWithContentsOfURL:listUrl];
    
    return nil;
}
@end
