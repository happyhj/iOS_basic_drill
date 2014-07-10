//
//  FileMatcher.m
//  FileString
//
//  Created by KIM HEE JAE on 7/10/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import "FileMatcher.h"

@implementation FileMatcher

+(NSArray*)allFilesAtPath:(NSString*)path
{
    return [FileMatcher allFilesAtPath:path withExtension:nil];
}

+(NSArray*)allFilesAtPath:(NSString*)path withExtension:(NSString*)extension
{
    // An array to store the all the enumerated file names in
    NSMutableArray *fileNameArray=[NSMutableArray array];
    
    NSURL *directoryToScan = [NSURL URLWithString: path];
    // Create a local file manager instance
    NSFileManager *localFileManager=[[NSFileManager alloc] init];
    
    // Enumerate the directory (specified elsewhere in your code)
    // Request the two properties the method uses, name and isDirectory
    // Ignore hidden files
    // The errorHandler: parameter is set to nil. Typically you'd want to present a panel
    NSDirectoryEnumerator *dirEnumerator = [localFileManager enumeratorAtURL:directoryToScan
                                                  includingPropertiesForKeys:[NSArray arrayWithObjects:NSURLNameKey,
                                                                              NSURLIsDirectoryKey,nil]
                                                                     options:NSDirectoryEnumerationSkipsHiddenFiles
                                                                errorHandler:nil];
    
    
    // Enumerate the dirEnumerator results, each value is stored in allURLs
    for (NSURL *theURL in dirEnumerator) {
        
        // Retrieve the file name. From NSURLNameKey, cached during the enumeration.
        NSString *fileName;
        [theURL getResourceValue:&fileName forKey:NSURLNameKey error:NULL];
        
        // Retrieve whether a directory. From NSURLIsDirectoryKey, also
        // cached during the enumeration.
        NSNumber *isDirectory;
        [theURL getResourceValue:&isDirectory forKey:NSURLIsDirectoryKey error:NULL];
        
        // Ignore files under the _extras directory
        if (([fileName caseInsensitiveCompare:@"_extras"]==NSOrderedSame) && ([isDirectory boolValue]==YES))
        {
            [dirEnumerator skipDescendants];
        }
        else
        {
            // Add full path for non directories
            if ([isDirectory boolValue]==NO)
            {
                if(extension == nil)
                {
                    [fileNameArray addObject:fileName];
                } else if([[fileName pathExtension] isEqualTo:extension]){
                    [fileNameArray addObject:fileName];
                }
            }
        }
    }
    
    // Sort File Name Array Alphabetically
    [fileNameArray sortUsingSelector:@selector(caseInsensitiveCompare:)];
    
    return fileNameArray;
}

+(void)displayAllFilesAtPath:(NSString*)path
{
    NSArray *theArray=[NSArray array];
    theArray = [FileMatcher allFilesAtPath:path];
    NSLog(@"items at %@\n- %@", path, theArray);
}

+(void)displayAllFilesAtPath:(NSString*)path withExtension:(NSString*)extension
{
    NSArray *theArray=[NSArray array];
    theArray = [FileMatcher allFilesAtPath:path withExtension:(NSString*)extension];
    NSLog(@"items at %@\n- %@", path, theArray);
}

+(bool)isExistFilename:(NSString*)filename atPath:(NSString*)path
{
    NSFileManager *localFileManager=[[NSFileManager alloc] init];
    NSString *fullPath = [NSString stringWithFormat:@"%@/%@", path, filename];
    return [localFileManager fileExistsAtPath:fullPath];
}
+(bool)isExistFilenames:(NSArray*)filenames atPath:(NSString*)path
{
    NSFileManager *localFileManager=[[NSFileManager alloc] init];
    for (NSString *filename in filenames) {
        NSString *fullPath = [NSString stringWithFormat:@"%@/%@", path, filename];
        if(![localFileManager fileExistsAtPath:fullPath]){
            return NO;
        };
    }
    return YES;
}
@end
