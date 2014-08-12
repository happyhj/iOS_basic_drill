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
        
        // 초기화 되었다는 신호를 노티피케이션 센터에 날린다.
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"modelInitializedNotification"
         object:self
         userInfo:nil];
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
    sortedArray = [data sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSString *first = [(NSDictionary*)a objectForKey:@"date"];
        NSString *second = [(NSDictionary*)b objectForKey:@"date"];
        return [first compare:second];
    }];
    data = sortedArray;
}
- (void) deleteAtIndex:(NSInteger)integer {
    [data removeObjectAtIndex:integer];
}
@end
