//
//  ViewController.m
//  wordCount
//
//  Created by KIM HEE JAE on 9/4/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSString * bookfile;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    bookfile = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]
                                                             pathForResource:@"bookfile" ofType:@".txt"]  encoding:NSUTF8StringEncoding error:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)wordListCount:(id)sender {
    [self.activityIndicator startAnimating];

     // 글로벌 큐를 구한다. 메인 큐가 아닌 곳에 일을 시킨다.
    dispatch_queue_t aQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(aQueue, ^{
        [self listWorkingProgress];
    });

 }
- (void) listWorkingProgress {

    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    NSTimeInterval beforeStart = [[NSDate date] timeIntervalSince1970];
    NSURL *url = [NSURL URLWithString:@"http://125.209.194.123/wordlist.php"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
    NSTimeInterval afterParse = [[NSDate date] timeIntervalSince1970];
    
    int process_count = 0;
    for(NSString* element in json) {
        NSUInteger count = [self countOfSubstring:element atContents:bookfile];
        [dict setObject:@(count) forKey:element];
     
        process_count++;
    }
    NSTimeInterval afterCount = [[NSDate date] timeIntervalSince1970];
    
    NSArray *orderedKeys = [dict keysSortedByValueUsingComparator:^NSComparisonResult(id obj1, id obj2){
        return [obj1 compare:obj2];
    }];
    
    NSString *min_key = [orderedKeys objectAtIndex:0];
    NSString *max_key = [orderedKeys lastObject];
    NSTimeInterval afterEvaluate = [[NSDate date] timeIntervalSince1970];
    
    dispatch_async(mainQueue, ^{
        [self.activityIndicator stopAnimating];
        [[[UIAlertView alloc] initWithTitle:@"완료"
                                    message:[NSString stringWithFormat:
                                             @"총 시간: %f\n파싱 시간: %f\n세는 시간: %f\n정렬하는 시간: %f\n가장 많은 단어(%@) - %@\n가장 적은 단어(%@) - %@",
                                             afterEvaluate-beforeStart,
                                             afterParse-beforeStart,
                                             afterCount-afterParse,
                                             afterEvaluate-afterCount,
                                             [dict objectForKey:max_key],max_key,
                                             [dict objectForKey:min_key],min_key
                                             ]
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil, nil] show];
    });
}
- (IBAction)start:(id)sender {
   
    self.progressBar.progress = 0;
    // 글로벌 큐를 구한다. 메인 큐가 아닌 곳에 일을 시킨다.
    dispatch_queue_t aQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);dispatch_async(aQueue, ^{
        [self workingProgress];
    });
    
}

- (void) workingProgress {
    int length = bookfile.length;
    int spaceCount = 0;
    float progress = 0;
    unichar aChar;
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    for (int nLoop=0; nLoop<length; nLoop++) {
        aChar = [bookfile characterAtIndex:nLoop];
        if (aChar==' ') spaceCount++;
        progress = (float)nLoop / (float)length;
        dispatch_async(mainQueue, ^{
            self.progressBar.progress = progress;
        });
        
    }

    dispatch_async(mainQueue, ^{
        [[[UIAlertView alloc] initWithTitle:@"완료"
                                    message:[NSString stringWithFormat:@"찾았다 %d개",spaceCount]
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil, nil] show];
    });
}

-(NSUInteger)countOfSubstring:(NSString*)substring atContents:(NSString*)contents
{
    /*
    NSUInteger count = 0, length = [contents length];
    NSRange range = NSMakeRange(0, length);
    while(range.location != NSNotFound)
    {
        range = [contents rangeOfString: substring options:0 range:range];
        if(range.location != NSNotFound)
        {
            range = NSMakeRange(range.location + range.length, length - (range.location + range.length));
            count++; 
        }
    }
    return count;
     */
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:substring
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:contents
                                                        options:0
                                                          range:NSMakeRange(0, [contents length])];
    return numberOfMatches;
}
@end
