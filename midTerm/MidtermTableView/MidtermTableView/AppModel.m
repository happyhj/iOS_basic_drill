//
//  AppModel.m
//  MidtermTableView
//
//  Created by KIM HEE JAE on 8/12/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import "AppModel.h"
#import "Reachability.h"
@interface AppModel ()
@property (nonatomic) Reachability *hostReachability;
@end

@implementation AppModel 

-(id)init {
    self = [super init];
    imageDownloadBuffer = [[NSMutableDictionary alloc] init];
    data = [[NSMutableArray alloc] init];
    if (self)
    {
        NSString *remoteHostName = @"www.apple.com";
        self.hostReachability = [Reachability reachabilityWithHostName:remoteHostName];
        NSInteger result = [self.hostReachability currentReachabilityStatus];

        if(NotReachable!=result) {
            NSURLRequest * urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://125.209.194.123/json.php"]];
            
            NSURLResponse * response = nil;
            NSError * error = nil;
            NSData * responseData = [NSURLConnection sendSynchronousRequest:urlRequest
                                                  returningResponse:&response
                                                              error:&error];
            NSMutableArray *dict = [[NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil] mutableCopy];
            for (id element in dict){
                [data addObject:[element mutableCopy]];
            }
            
            for (id photoData in data) {
                // 모든 이미지 URL에 대해 비동기 요청을 보낸다.
                [self downloadImageWithURL:[photoData objectForKey:@"image"]];
            }
        } else {
            char *staticData = "[{\"title\":\"초록\",\"image\":\"01.jpg\",\"date\":\"20140116\"},\ {\"title\":\"장미\",\"image\":\"02.jpg\",\"date\":\"20140505\"},\ {\"title\":\"낙엽\",\"image\":\"03.jpg\",\"date\":\"20131212\"},\ {\"title\":\"계단\",\"image\":\"04.jpg\",\"date\":\"20130301\"},\ {\"title\":\"벽돌\",\"image\":\"05.jpg\",\"date\":\"20140101\"},\ {\"title\":\"바다\",\"image\":\"06.jpg\",\"date\":\"20130707\"},\ {\"title\":\"벌레\",\"image\":\"07.jpg\",\"date\":\"20130815\"},\ {\"title\":\"나무\",\"image\":\"08.jpg\",\"date\":\"20131231\"},\ {\"title\":\"흑백\",\"image\":\"09.jpg\",\"date\":\"20140102\"}]";
            NSData *jsonData = [[NSString stringWithUTF8String:staticData] dataUsingEncoding:NSUTF8StringEncoding];
            NSArray *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
            data = [dict mutableCopy];
        }

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
    //NSArray *sortedArray;
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
    [data removeObjectAtIndex:integer];
}


-(void)downloadImageWithURL:(NSString*)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *theRequest = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
    NSMutableData* receivedData = [[NSMutableData alloc] initWithLength:0];
    [imageDownloadBuffer setObject:receivedData forKey:urlString];

    NSURLConnection * connection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self startImmediately:YES];
}


- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSURL *myURL = [[connection currentRequest] URL];
    NSMutableData* receivedData = [imageDownloadBuffer objectForKey:[myURL absoluteString]];
    [receivedData setLength:0];
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data_ {
    NSURL *myURL = [[connection currentRequest] URL];
    NSMutableData* receivedData = [imageDownloadBuffer objectForKey:[myURL absoluteString]];
    [receivedData appendData:data_ ];
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
   
    NSURL *myURL = [[connection currentRequest] URL];
    NSMutableData* receivedData = [imageDownloadBuffer objectForKey:[myURL absoluteString]];
   //r [receivedData writeToFile:<#(NSString *)#> atomically:YES];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *targetPath = [documentsDirectory stringByAppendingPathComponent:[myURL lastPathComponent]];
    NSLog(@"Succeeded! Received %d bytes of data",[receivedData length]);
    NSLog(@"%@",targetPath);
   [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
   [receivedData writeToFile:targetPath atomically:YES];

    // data 객체 원소의 image의 값을 실제로 가져올 수 있는 주소로 바꾼다.
//    NSLog(@"%@",data);
    [self setLocalImagePath:myURL withAbsolutePath:targetPath];
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"modelInitializedNotification"
     object:nil
     userInfo:nil];
    
}

- (void) setLocalImagePath:(NSURL *)url withAbsolutePath:(NSString *) targetPath{
    NSString *urlString = [url absoluteString];
    NSMutableDictionary *photoData;
    for(id element in data) {
        if(urlString==[element objectForKey:@"image"]){
            photoData = element;
            break;
        };
    }
    [photoData setObject:targetPath forKey:@"image"];
}

/*
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"didReceiveResponse");
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"didReceiveData");
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError");
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"connectionDidFinishLoading");
}
 */
@end
