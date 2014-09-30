//
//  Board.h
//  CommunityClient
//
//  Created by KIM HEE JAE on 9/27/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Board : NSObject
{
    @public
    NSString * name_ko;
    NSString * name_en;
    NSMutableArray * articleCollection;
}
- (id) initWithAttribute:(NSDictionary*)config;
- (void) fetchArticlesAtPage:(int) page;
@end
