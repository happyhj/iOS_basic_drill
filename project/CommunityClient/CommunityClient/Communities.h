//
//  Communities.h
//  CommunityClient
//
//  Created by KIM HEE JAE on 9/27/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Community.h"
#import "Board.h"
@interface Communities : NSObject

- (void) prepareForEveryFirstPageArticles;
- (Community*) communityAtIndex:(int) index;

@end
