//
//  ComminutyParsor.m
//  HTMLParsing
//
//  Created by KIM HEE JAE on 9/2/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//
#import "TFHpple.h"
#import "ListParsor.h"

@implementation CommunityParsor
{
    NSString * name_en;
    NSString * name_ko;
    NSString * domain;
    NSMutableArray * listParsors; // listParsor
}
- (id) init
{
    if (!(self = [super init]))
        return nil;
 
    listParsors = [[NSMutableArray alloc] init];

    // 1. 설정파일을 문자열로 읽는다.
    NSError *error;
    NSString *strFileContent = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]
                                                                   pathForResource: @"community" ofType: @"json"] encoding:NSUTF8StringEncoding error:&error];
    
    if(error) {  //Handle error
        
    }
    
    // 2. 설정파일을 JSON으로 파싱한다.
    NSData *data = [strFileContent dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];

    // 3. 기본정보를 설정한다.
    name_en = [json objectForKey:@"community_name_en"];
    name_ko = [json objectForKey:@"community_name_ko"];
    domain = [json objectForKey:@"domain"];

    // 3. 게시판별 리스트파서를 생성한다.
    NSArray * boards = [json objectForKey:@"boards"];
    for (NSDictionary* board in boards){
        [listParsors addObject:[[ListParsor alloc] initWithBoardAttribute:board]];
    }
    
    return self;

}
@end
