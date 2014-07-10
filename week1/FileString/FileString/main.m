//
//  main.m
//  FileString
//
//  Created by KIM HEE JAE on 7/10/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FileMatcher.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        NSString *path = @"/Volumes/DATA/Users/heejae/Desktop/test";
        [FileMatcher displayAllFilesAtPath:path];
        [FileMatcher displayAllFilesAtPath:path withExtension:@"jpg"];
        
        if([FileMatcher isExistFilename:@"happy.png" atPath:path]){
            NSLog(@"Exist!");
        } else {
            NSLog(@"Not Exist...");
        }
    }
    return 0;
}

