//
//  ViewController.m
//  BarGraphView
//
//  Created by KIM HEE JAE on 8/28/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

PieGraphView *pieGraphView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *data = @"{\"data\":[{\"title\":\"April\", \"value\":5},{\"title\":\"May\", \"value\":12},{\"title\":\"June\", \"value\":18},{\"title\":\"July\", \"value\":11},{\"title\":\"August\", \"value\":15},{\"title\":\"September\", \"value\":9},{\"title\":\"October\", \"value\":17},{\"title\":\"November\", \"value\":25},{\"title\":\"December\", \"value\":31}]}";
    
    NSError *error;
    NSData *jsonData = [data dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:jsonData
                                                         options:kNilOptions
                                                           error:&error];
    NSArray * dataArr = [[NSArray alloc] initWithArray:[json objectForKey:@"data"]];
    
    float barGraphViewHeight = dataArr.count * 40 + 120;
    BarGraphView *barGraphView = [[BarGraphView alloc] initWithFrame:CGRectMake(0, 0, 320, barGraphViewHeight)];
    barGraphView.opaque = NO;

    [barGraphView setData:dataArr];
    [_scrollView addSubview:barGraphView];
    [_scrollView setContentSize:barGraphView.frame.size];
  
    
     NSString *pieData = @"[{\"title\":\"April\", \"percentage\":18},{\"title\":\"May\", \"percentage\":12},{\"title\":\"June\", \"percentage\":18},{\"title\":\"July\", \"percentage\":13},{\"title\":\"August\", \"percentage\":18}, {\"title\":\"September\", \"percentage\":9},{\"title\":\"October\", \"percentage\":18}]";
    NSData *jsonPieData = [pieData dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* pieJson = [NSJSONSerialization JSONObjectWithData:jsonPieData
                                                         options:kNilOptions
                                                           error:&error];
    NSArray * pieDataArr = [[NSArray alloc] initWithArray:pieJson];

    pieGraphView = [[PieGraphView alloc] initWithFrame:CGRectMake(0, 280, 320, 320)];
    pieGraphView.opaque = NO;
    [pieGraphView setData:pieDataArr];
    [self.view addSubview:pieGraphView];
     
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
