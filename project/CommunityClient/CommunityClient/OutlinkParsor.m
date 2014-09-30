//
//  OutlinkParsor.m
//  CommunityClient
//
//  Created by KIM HEE JAE on 9/30/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//
#import "TFHpple.h"
#import "OutlinkParsor.h"

@implementation OutlinkParsor
- (NSDictionary*) getOutlinkMetaInfoWith:(NSString *) url
{
   // NSLog(@"아웃링크 %@ 에 대한 정보 가져오는 중...", url );

    NSURL *listUrl = [NSURL URLWithString:url];

    NSURLRequest* request = [NSURLRequest requestWithURL:listUrl cachePolicy:0 timeoutInterval:5];
    NSURLResponse* response=nil;
    NSError* error=nil;
    NSData* data=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
   
    
//    NSData *listHtmlData = [NSData dataWithContentsOfURL:listUrl];
    TFHpple *listHtmlParser = [TFHpple hppleWithHTMLData:data encoding:@"utf-8"];
//    NSArray *listNodes = [listHtmlParser searchWithXPathQuery:@"//title/text()"];
    NSArray *listNodes = [listHtmlParser searchWithXPathQuery:@"//meta[@property='og:title']/@content"];
    //@"//meta[@property='og:title']/@content"
 //   NSLog(@"%@", [listNodes count] );
    NSString * title ;
     if(listNodes != nil && [listNodes count]>0) {
         TFHppleElement *element = [listNodes objectAtIndex:0];
         title = [element.firstChild content];
     } else {
         NSArray *listNodes = [listHtmlParser searchWithXPathQuery:@"//title/text()"];
         if(listNodes != nil && [listNodes count]>0) {
             TFHppleElement *element = [listNodes objectAtIndex:0];
             title = [element.firstChild content];
         } else {
             //NSLog(@"기사 제목이 없다요");
         }
     }
 
    listNodes = [listHtmlParser searchWithXPathQuery:@"//meta[@property='og:image']/@content"];
    //@"//meta[@property='og:title']/@content"
    //   NSLog(@"%@", [listNodes count] );
    NSString * image;
    if(listNodes != nil && [listNodes count]>0) {
        TFHppleElement *element = [listNodes objectAtIndex:0];
        image = [element.firstChild content];
    } else {
        //NSLog(@"기사 이미지가 없다요");
    }
    
    listNodes = [listHtmlParser searchWithXPathQuery:@"//meta[@property='og:description']/@content"];
    //@"//meta[@property='og:title']/@content"
    //   NSLog(@"%@", [listNodes count] );
    NSString * description;
    if(listNodes != nil && [listNodes count]>0) {
        TFHppleElement *element = [listNodes objectAtIndex:0];
        description = [element.firstChild content];
    } else {
       // NSLog(@"기사 설명이 없다요");
    }
    
    
 /*
    if(title != nil) {
        title = [title stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"%@",title);
    }
    if(image != nil) {
        image = [image stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"%@",image);
    }
    if(description != nil) {
        description = [description stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"%@",description);
    }
  */
    /*
    NSString *userAgent = @"Mozilla/4.0 (compatible; MSIE 5.23; Mac_PowerPC)";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:listUrl];
    [request setValue:userAgent forHTTPHeaderField:@"User-Agent"];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *result = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
    
    TFHpple *listHtmlParser = [TFHpple hppleWithHTMLData:responseData];
    NSArray *listNodes = [listHtmlParser searchWithXPathQuery:@"//title/text()"];
    if(listNodes != nil) {
        TFHppleElement *element = [listNodes objectAtIndex:0];
        NSLog(@"%@", [element content]);
    } else {
        NSLog(@"정보가 없다요");
    }
*/
    
    NSDictionary * result = nil;
    if(title != nil && image != nil && description != nil)
        result = [NSDictionary dictionaryWithObjects:@[title,image,description] forKeys:@[@"title",@"image",@"description"]];
    return result;
}

@end
