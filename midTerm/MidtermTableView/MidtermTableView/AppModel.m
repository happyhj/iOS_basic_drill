//
//  AppModel.m
//  MidtermTableView
//
//  Created by KIM HEE JAE on 8/12/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import "AppModel.h"

@implementation AppModel

-(id)initWithUTF8String:(char*)data_ {
    self = [super init];
    if (self)
    {
        NSData *jsonData = [[NSString stringWithUTF8String:data_] dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
        data = [dict mutableCopy];
    }
    return self;
}
-(NSInteger) getCount {
    return [data count];
}
-(NSDictionary*) dictionaryAtIndex:(NSInteger)integer {
    return [data objectAtIndex:integer];
}
-(void) sort {
    NSArray *sortedArray;
    data = [data sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSString *first = [(NSDictionary*)a objectForKey:@"date"];
        NSString *second = [(NSDictionary*)b objectForKey:@"date"];
        return [first compare:second];
    }];
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"modelInitializedNotification"
     object:nil
     userInfo:nil];
}
- (void) deleteAtIndex:(NSInteger)integer {
   // NSLog(@"!@#!@#!@");
    [data removeObjectAtIndex:integer];
}
@end
