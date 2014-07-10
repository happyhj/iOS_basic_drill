//
//  FileMatcher.h
//  FileString
//
//  Created by KIM HEE JAE on 7/10/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileMatcher : NSObject

+(NSArray*)allFilesAtPath:(NSString*)path;
+(NSArray*)allFilesAtPath:(NSString*)path withExtension:(NSString*)extension;
+(void)displayAllFilesAtPath:(NSString*)path;
+(void)displayAllFilesAtPath:(NSString*)path withExtension:(NSString*)extension;
+(bool)isExistFilename:(NSString*)filename atPath:(NSString*)path;
+(bool)isExistFilenames:(NSArray*)filenames atPath:(NSString*)path;

@end
