//
//  DetailViewController.m
//  Tcp
//
//  Created by KIM HEE JAE on 8/21/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import "DetailViewController.h"
#define BUFFER_SIZE 1024
#define DOMAIN @"10.73.43.170"

@interface DetailViewController ()
{
    NSMutableData *_data;
    NSInputStream *_stream_buffer;
    long bytesRead;
    long bytesToRead;
    bool isHeadOfStream;
}
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    bytesRead = 0;
    isHeadOfStream = YES;
    [self setTCPConnectionWith:DOMAIN andWith:8000];
    
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

- (void)setTCPConnectionWith:(NSString*)domain andWith:(int)port
{
 //   NSURL *website = [NSURL URLWithString:domain];
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    CFStreamCreatePairWithSocketToHost(NULL, (__bridge CFStringRef)domain, port, &readStream, &writeStream);
    
    NSInputStream *inputStream = (__bridge_transfer NSInputStream *)readStream;
    [inputStream setDelegate:self];
    [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    _stream_buffer = inputStream;
    [inputStream open];
}

- (void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)eventCode {
    switch(eventCode) {
        case NSStreamEventHasBytesAvailable:
        {
            if(!_data) {
                _data = [[NSMutableData alloc] init];
            }
            
            uint8_t buf[BUFFER_SIZE];
            unsigned int len = 0;
            if (isHeadOfStream==YES) {
                len = [(NSInputStream *)stream read:buf maxLength:8];
                buf[len] = '\0';
            } else {
                len = [(NSInputStream *)stream read:buf maxLength:BUFFER_SIZE];
            }
            NSLog(@"len : %d",len);

            if(len > 0) {
                if (isHeadOfStream==YES) {
                    bytesToRead = atol((const char*)buf);
                    NSLog(@"bytesToRead : %ld",bytesToRead);
                    if (isHeadOfStream==YES) {
                        isHeadOfStream = NO;
                    }
                } else if (isHeadOfStream==NO) {
                    [_data appendBytes:(const void *)buf length:len];
                    bytesRead += len;
                    if (bytesToRead <= bytesRead) {
                        self.imageView.image = [UIImage imageWithData:_data];
                        NSLog(@"bytesRead : %ld",bytesRead);

                        // bytesRead 를 0으로 초기화
                        bytesRead = 0;
                        [_data init];
                        isHeadOfStream = YES;
                    }
                }
            } else {
                NSLog(@"no buffer!");
            }
            break;
        }
        case NSStreamEventEndEncountered:
        {

            break;
        }
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:(BOOL)animated];    // Call the super class
    NSLog(@"Stream closing!!!!!");
    [_stream_buffer close];
    [_stream_buffer removeFromRunLoop:[NSRunLoop currentRunLoop]
                      forMode:NSDefaultRunLoopMode];
    _stream_buffer = nil; // stream is ivar, so reinit it
}

@end
