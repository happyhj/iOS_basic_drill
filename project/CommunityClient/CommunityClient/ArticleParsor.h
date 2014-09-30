//
//  ArticleParsor.h
//  CommunityClient
//
//  Created by KIM HEE JAE on 9/2/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleParsor : NSObject
- (id) initWithAttribute:(NSDictionary*) config;
- (NSDictionary*) getAtricleItemWith:(NSDictionary *) listItem;
@end
