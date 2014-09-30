//
//  ListParsor.h
//  HTMLParsing
//
//  Created by KIM HEE JAE on 9/2/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListParsor : NSObject

- (id) initWithAttribute:(NSDictionary*) config;
- (NSArray*) fetchListItemsAtPage:(int)page;
//- (NSMutableArray *)articleItems;

//- (void)setArticleItems:(NSMutableArray *)newValue;

@end
