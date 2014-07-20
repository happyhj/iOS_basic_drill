//
//  JSON_Serializer.h
//  JSON_Serialization
//
//  Created by KIM HEE JAE on 7/17/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONDeserializer : NSObject

+ (JSONDeserializer*) deserializer;
- (id) deserialize:(NSString*)jsonString;
@end
