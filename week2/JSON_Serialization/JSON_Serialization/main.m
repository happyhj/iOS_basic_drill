//
//  main.m
//  JSON_Serialization
//
//  Created by KIM HEE JAE on 7/17/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONDeserializer.h"
#import "JSONSerializer.h"

int main(int argc, const char * argv[])
{
    @autoreleasepool {
        // 문자열로 된 JSON 객체들을 Foundation 객체로 변환하고 이를 다시 JSON 문자열로 만든 결과를 다시 Foundation 객체로 읽어들여서 테스트를 수행하였다.
        // 파싱하는것과 JSON문자열로 만드는것 두가지 모두 동시에 테스트한다.
        //
        
        NSString *json1 = @"{\"id\": 7.1,\"name\":\"james\",\"weapons\":[\"gun\",\"pen\",1432],\"contact\":{\"phone\":[\"01025217577\",\"02-2001-9181\"],\"nickname\":{\"sally\":\"father\"}}}";
        NSString *json2 = @"[{\"id\":001,\"name\":\"john\"},{\"id\":7.1,\"name\":\"james\"}]";

        NSDictionary *dict_json1 = [[JSONDeserializer deserializer] deserialize:json1];
        NSArray *arr_json2 = [[JSONDeserializer deserializer] deserialize:json2];
       
        NSString *dict_json1_stringified = [[JSONSerializer serializer] serializeObject:dict_json1];
        NSDictionary *dict_json1_result = [[JSONDeserializer deserializer] deserialize:dict_json1_stringified];


        NSString *arr_json2_stringified = [[JSONSerializer serializer] serializeObject:arr_json2];
        NSArray *arr_json2_result = [[JSONDeserializer deserializer] deserialize:arr_json2_stringified];

        
        if([@"james" isEqualTo:[dict_json1_result objectForKey:@"name"]]) NSLog(@"success");
        else NSLog(@"fail");
        
        if([@(7.1) isEqualTo:[dict_json1_result objectForKey:@"id"]]) NSLog(@"success");
        else NSLog(@"fail");

        if([@"pen" isEqualTo:[[dict_json1_result objectForKey:@"weapons"] objectAtIndex:1]]) NSLog(@"success");
        else NSLog(@"fail");
            
        if([@"james" isEqualTo:[[arr_json2_result objectAtIndex:1] objectForKey:@"name"]]) NSLog(@"success");
        else NSLog(@"fail");

        if([@(1) isEqualTo:[[arr_json2_result objectAtIndex:0] objectForKey:@"id"]]) NSLog(@"success");
        else NSLog(@"fail");
        
        NSLog(@"JSON Stringified : %@",dict_json1_stringified);
        NSLog(@"Foundation Object : %@",dict_json1_result);
        NSLog(@"JSON Stringified : %@",arr_json2_stringified);
        NSLog(@"Foundation Object : %@",arr_json2_result);
    }
    return 0;
}