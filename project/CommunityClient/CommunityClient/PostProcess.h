//
//  ClienPostProcess.h
//  CommunityClient
//
//  Created by KIM HEE JAE on 9/2/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostProcess : NSObject
+ (NSMutableDictionary*) postProcessWith:(NSMutableDictionary*) source and:(NSString*)listsUrl;

@end
