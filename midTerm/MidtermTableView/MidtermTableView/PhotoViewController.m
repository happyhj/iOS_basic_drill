//
//  PhotoViewController.m
//  MidtermTableView
//
//  Created by KIM HEE JAE on 8/12/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import "PhotoViewController.h"

@interface PhotoViewController ()

@end

@implementation PhotoViewController

#pragma mark - Managing the detail item
/*
- (void)setDetailItem:(NSDictionary*)newDetailItem
{
    if (self.photo != newDetailItem) {
        self.photo = newDetailItem;
        [self configureView];
    }
}

- (void)configureView
{
    if (self.photo) {
        [self.photoTitle setText:[self.photo objectForKey:@"title"]];
        [self.photoDate setText:[self.photo objectForKey:@"date"]];
        UIImage *image = [UIImage imageNamed: [self.photo objectForKey:@"image"]];
        [self.photoImage setImage:image];
        NSLog(@"%@",[self.photo objectForKey:@"date"]);
        NSLog(@"%@",self.photoTitle);
    }
}
*/

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"viewDidLoad");
    [self.photoTitle setText:self.title];
    [self.photoDate setText:self.date];
    UIImage *image = [UIImage imageNamed: self.image];
    [self.photoImage setImage:image];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
