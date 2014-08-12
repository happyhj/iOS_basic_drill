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
@end
