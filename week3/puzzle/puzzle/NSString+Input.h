//
//  NSString+Input.h
//  puzzle
//
//  Created by KIM HEE JAE on 7/24/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Input)
+ (NSString *) stringFromStandardInDelimitedByCharactersInSet:(NSCharacterSet *)delimiters;

@end
