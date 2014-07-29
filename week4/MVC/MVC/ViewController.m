//
//  ViewController.m
//  MVC
//
//  Created by KIM HEE JAE on 7/29/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClickButton:(id)sender {
    [[UIApplication sharedApplication]
     openURL:[NSURL URLWithString:@"http://clien.net"]];
}

- (IBAction)onClickColorButton:(id)sender {
    [self.view setBackgroundColor:
     [UIColor yellowColor]];
}

@end
