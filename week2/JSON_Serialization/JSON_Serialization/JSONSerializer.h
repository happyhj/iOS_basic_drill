//
//  JSONSerializer.h
//  JSON_Serialization
//
//  Created by KIM HEE JAE on 7/20/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONSerializer : NSObject
+ (JSONSerializer*) serializer;
- (NSString*) serializeObject:(id)object;
- (NSString*) makeLeafNodeStringPresentation:(id)object;
@end
